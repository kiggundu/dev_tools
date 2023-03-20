#NB this file should be executed as root

apt install apt-transport-https

ARCH=$(dpkg --print-architecture)

cat > /etc/apt/sources.list.d/tor.list <<EOT
deb     [signed-by=/usr/share/keyrings/tor-archive-keyring.gpg] https://deb.torproject.org/torproject.org jammy main
deb-src [signed-by=/usr/share/keyrings/tor-archive-keyring.gpg] https://deb.torproject.org/torproject.org jammy main
EOT

wget -qO- https://deb.torproject.org/torproject.org/A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89.asc | gpg --dearmor | tee /usr/share/keyrings/tor-archive-keyring.gpg >/dev/null


apt update
apt install tor
apt install deb.torproject.org-keyring
apt install nyx
