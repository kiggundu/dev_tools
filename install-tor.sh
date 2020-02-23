sudo apt install torbrowser-launcher
gpg --homedir ~/.local/share/torbrowser/gnupg_homedir --delete-keys torbrowser@torproject.org
sudo sed -i 's/hkps\:\/\/hkps\.pool\.sks\-keyservers\.net/hkps\:\/\/keys\.openpgp\.org/g' /usr/lib/python2.7/dist-packages/torbrowser_launcher/common.py
