
wget http://download-hr.utorrent.com/track/beta/endpoint/utserver/os/linux-x64-ubuntu-13-04 -O utserver.tar.gz
sudo tar xvf utserver.tar.gz -C /opt/
sudo chmod 777 /opt/utorrent-server-alpha-v3_3/
sudo apt install libssl1.0.0 libssl-dev

#the 2 lines below are irrespective of the version of ubuntu 18 or 19
wget http://archive.ubuntu.com/ubuntu/pool/main/o/openssl1.0/libssl1.0.0_1.0.2n-1ubuntu5.3_amd64.deb
sudo apt install ./libssl1.0.0_1.0.2n-1ubuntu5.3_amd64.deb

sudo ln -s /opt/utorrent-server-alpha-v3_3/utserver /usr/bin/utserver

#write the service config file to the appropriate location
sudo tee -a /etc/systemd/system/utserver.service > /dev/null <<EOT
[Unit]
Description=uTorrent Server
After=network.target

[Service]
Type=simple
User=utorrent
Group=utorrent
ExecStart=/usr/bin/utserver -settingspath /opt/utorrent-server-alpha-v3_3/
ExecStop=/usr/bin/pkill utserver
Restart=always
SyslogIdentifier=uTorrent Server

[Install]
WantedBy=multi-user.target
EOT

#reload the services
sudo systemctl daemon-reload
#add system user for the service to run as
sudo adduser --system utorrent
sudo addgroup --system utorrent
sudo adduser utorrent utorrent

#make sure the service can be started
sudo systemctl start utserver
systemctl status utserver


sudo systemctl enable utserver      #ensure it is started at boot time

echo "All done"
echo "Go to http://localhost:8080/gui and configure the download directory settings appropriately"
echo "To execute a shell as the utorrent user type: "
echo "sudo su -l utorrent -s /bin/bash"
