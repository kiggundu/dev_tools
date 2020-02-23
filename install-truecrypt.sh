sudo add-apt-repository ppa:stefansundin/truecrypt

sudo apt-get update
sudo apt-get install truecrypt

##You need root or sudo privileges to mount truecrypt partition with write access, To automatically grant root privileges to mount volumes, run:
#sudo visudo -f /etc/sudoers.d/truecrypt
##Then add the following line and save the file:
#your_username ALL=(ALL) NOPASSWD:/usr/bin/truecrypt
##Replace "your_username" with the actual user name of your Linux user account.
