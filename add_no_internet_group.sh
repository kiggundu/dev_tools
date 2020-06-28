sudo addgroup no-internet
sudo iptables -A OUTPUT -m owner --gid-owner no-internet -j DROP
#Execute sudo -g no-internet YOURCOMMAND instead of YOURCOMMAND
