mkdir -p ~/workspace/usbwifi
cd ~/workspace/usbwifi
sudo apt install git dkms
git clone https://github.com/aircrack-ng/rtl8812au.git
cd rtl8812au
sed -i 's/CONFIG_PLATFORM_I386_PC = y/CONFIG_PLATFORM_I386_PC = n/g' Makefile
sed -i 's/CONFIG_PLATFORM_ARM64_RPI = n/CONFIG_PLATFORM_ARM64_RPI = y/g' Makefile
make && make install

#For the hotspot
sudo apt install -y hostapd dnsmasq
#ensure dnsmasq should only bind the interfaces its configured to listen to so as not to conflict with systemd-r
sudo sed -i 's/\#bind-interface/bind-interfaces/g' /etc/dnsmasq.conf
sudo tee -a /etc/dhcpcd.conf > /dev/null <<EOT
interface wlan0
static ip_address=192.168.0.20/24
denyinterfaces eth0
denyinterfaces wlan0
EOT
