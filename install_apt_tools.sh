sudo apt install -y software-properties-common gnome-tweak-tool curl wget git git-extras terminator rbenv default-jdk kdiff3 lnav youtube-dl octave build-essential file htop libpq-dev gnome-control-center truecrypt calibre gnucash exfat-fuse exfat-utils tidy xdotool keynav vim-gtk tree xclip pass

#voice tools and voices
sudo apt install -y festival speech-tools
sudo apt-get install -y festvox-don festvox-rablpc16k festvox-kallpc16k festvox-kdlpc16k
./install_festival_voices.sh

#Install samba for file sharing from OSX servers et al
sudo apt install -y samba
sudo ufw allow samba    #update firewall to allow samba traffic

sudo apt install -y httpie ripgrep graphviz

