#!/bin/sh
#

### Set variables
# The UID that Tor runs as (varies from system to system)
_tor_uid="$(id -u debian-tor)" #the computed tor user
_stubby_uid="$(id -u ubuntu)" #The local stubby DNS server user
#_tor_uid=`id -u debian-tor` #Debian/Ubuntu
#_tor_uid=`id -u tor` #ArchLinux/Gentoo

# Tor's TransPort
#_trans_port="9050"
#Changing port to go through redsocks which socksifies before connecting to Tor
_trans_port="12345"

# Stubby secure  DNSPort
_dns_port="53"

# Tor's VirtualAddrNetworkIPv4
_virt_addr="10.192.0.0/10"

# Your outgoing interface
_out_if="wlan0"

# Your incoming interface and assigned local IP (Gateway)
_inc_if="wlan1"
_inc_ip="192.168.50.1"

# LAN destinations that shouldn't be routed through Tor
_non_tor="127.0.0.0/8 10.0.0.0/8 172.16.0.0/12 192.168.0.0/16"

# Other IANA reserved blocks (These are not processed by tor and dropped by default)
_resv_iana="0.0.0.0/8 100.64.0.0/10 169.254.0.0/16 192.0.0.0/24 192.0.2.0/24 192.88.99.0/24 198.18.0.0/15 198.51.100.0/24 203.0.113.0/24 224.0.0.0/4 240.0.0.0/4 255.255.255.255/32"


##########################################################################################
# SSH traffic rules
###########################################################################################
### ensure all ssh trafic for all interfaces is not redirected to Tor
sudo iptables -t nat -A PREROUTING -p tcp --dport 22 -j RETURN


##########################################################################################
# Rules governing LAN traffic
###########################################################################################
### Ensure all lan foffic from the incomming interface is not redirected to Tor
for _lan in $_non_tor; do
    sudo iptables -t nat -A PREROUTING -i $_inc_if -d $_lan -j RETURN
done

for _iana in $_resv_iana; do
    sudo iptables -t nat -A PREROUTING -i $_inc_if -d $_iana -j RETURN
done


##########################################################################################
# Rules redirecting to Tor (TCP) and Stubby (DNS)
###########################################################################################
### Redirect all remaining incoming TCP:* and UDP:53 packets to the Tor port.
sudo iptables -t nat -A PREROUTING -i $_inc_if -p tcp -m tcp --tcp-flags FIN,SYN,RST,ACK SYN -j REDIRECT --to-ports $_trans_port
sudo iptables -t nat -A PREROUTING -i $_inc_if -p udp -m udp --dport 53 -j REDIRECT --to-ports $_dns_port
### *nat OUTPUT (For local redirection)
# Ensure all .onion address destined communication from the router go tothe tor port
sudo iptables -t nat -A OUTPUT -d $_virt_addr -p tcp -m tcp --tcp-flags FIN,SYN,RST,ACK SYN -j REDIRECT --to-ports $_trans_port


##########################################################################################
# Rules for locally originated traffic
###########################################################################################
# nat all local dns requests to Stubby except those requests originating from stubby
sudo iptables -t nat -A OUTPUT -m owner --uid-owner $_stubby_uid -j RETURN
#TODO: Disabled local DNS redirection for now. All subsequent commands fail with 'unable to resolve host ubuntu: Temporary failure in name resolution'
#sudo iptables -t nat -A OUTPUT -p udp -m udp --dport 53 -j REDIRECT --to-ports $_dns_port
# Don't nat the Tor process, the loopback, or the local network, o ssh port 22
sudo iptables -t nat -A OUTPUT -m owner --uid-owner $_tor_uid -j RETURN
sudo iptables -t nat -A OUTPUT -o lo -j RETURN
sudo iptables -t nat -A OUTPUT -p tcp --dport 22 -j RETURN

# Allow lan access for hosts in $_non_tor
for _lan in $_non_tor; do
    sudo iptables -t nat -A OUTPUT -d $_lan -j RETURN
done

for _iana in $_resv_iana; do
    sudo iptables -t nat -A OUTPUT -d $_iana -j RETURN
done

# Redirect all other locally originated tcp trafic to Tor's TransPort
sudo iptables -t nat -A OUTPUT -p tcp -m tcp --tcp-flags FIN,SYN,RST,ACK SYN -j REDIRECT --to-ports $_trans_port


##########################################################################################
# Rules for trafic specifically destined for this router
###########################################################################################
### *filter INPUT
# Don't forget to grant yourself ssh access from remote machines before the DROP.
sudo iptables -A INPUT -p tcp --dport 22 -m state --state NEW -j ACCEPT
sudo iptables -A INPUT -m state --state ESTABLISHED -j ACCEPT
sudo iptables -A INPUT -i lo -j ACCEPT

# Allow DNS lookups from connected clients and internet access through tor.
sudo iptables -A INPUT -d $_inc_ip -i $_inc_if -p udp -m udp --dport $_dns_port -j ACCEPT
sudo iptables -A INPUT -d $_inc_ip -i $_inc_if -p tcp -m tcp --dport $_trans_port --tcp-flags FIN,SYN,RST,ACK SYN -j ACCEPT

# Allow INPUT from lan hosts in $_non_tor
# Uncomment these 3 lines to enable.
for _lan in $_non_tor; do
 sudo iptables -A INPUT -s $_lan -j ACCEPT
done

# Log & Drop everything else. Uncomment to enable logging.
sudo iptables -A INPUT -j LOG --log-prefix "Dropped INPUT packet: " --log-level 7 --log-uid
sudo iptables -A INPUT -j DROP



### *filter FORWARD
sudo iptables -A FORWARD -j DROP

### *filter OUTPUT
sudo iptables -A OUTPUT -m state --state INVALID -j DROP
sudo iptables -A OUTPUT -m state --state ESTABLISHED -j ACCEPT

# Allow Tor and Stubby  process output
sudo iptables -A OUTPUT -o $_out_if -m owner --uid-owner $_tor_uid -p tcp -m tcp --tcp-flags FIN,SYN,RST,ACK SYN -m state --state NEW -j ACCEPT
sudo iptables -A OUTPUT -o $_out_if -m owner --uid-owner $_stubby_uid -m state --state NEW,ESTABLISHED,RELATED -j ACCEPT

# Allow loopback output
sudo iptables -A OUTPUT -d 127.0.0.1/32 -o lo -j ACCEPT

# Tor transproxy magic
sudo iptables -A OUTPUT -d 127.0.0.1/32 -p tcp -m tcp --dport $_trans_port --tcp-flags FIN,SYN,RST,ACK SYN -j ACCEPT

# Allow OUTPUT to lan hosts in $_non_tor
# Uncomment these 3 lines to enable.
for _lan in $_non_tor; do
 sudo iptables -A OUTPUT -d $_lan -j ACCEPT
done

# Log & Drop everything else. Uncomment to enable logging
sudo iptables -A OUTPUT -j LOG --log-prefix "Dropped OUTPUT packet: " --log-level 7 --log-uid
sudo iptables -A OUTPUT -j DROP

### Set default policies to DROP
sudo iptables -P INPUT DROP
sudo iptables -P FORWARD DROP
sudo iptables -P OUTPUT DROP

### Set default policies to DROP for IPv6
#ip6tables -P INPUT DROP
#ip6tables -P FORWARD DROP
#ip6tables -P OUTPUT DROP
