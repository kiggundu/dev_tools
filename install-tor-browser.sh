wget https://www.torproject.org/dist/torbrowser/12.0.4/tor-browser-linux64-12.0.4_ALL.tar.xz
mv tor-browser-linux64-12.0.4_ALL.tar.xz tor-browser.tar.xz
7z x tor-browser.tar.xz
tar xf tor-browser.tar
sudo mv tor-browser /usr/share/
cd /usr/share/tor-browser
./start-tor-browser.desktop --register-app
