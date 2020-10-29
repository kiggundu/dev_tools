mkdir -p ~/workspace/usbwifi
cd ~/workspace/usbwifi
sudo apt install git dkms
git clone https://github.com/aircrack-ng/rtl8812au.git
cd rtl8812au
sudo ./dkms-install.sh
