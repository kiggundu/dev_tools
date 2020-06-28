sudo apt install -y software-properties-common gnome-tweak-tool curl wget git git-extras terminator rbenv default-jdk kdiff3 lnav youtube-dl octave build-essential file htop libpq-dev gnome-control-center truecrypt calibre gnucash exfat-fuse exfat-utils tidy xdotool keynav vim-gtk tree xclip pass

#voice tools and voices
sudo apt install -y festival speech-tools
sudo apt-get install -y festvox-don festvox-rablpc16k festvox-kallpc16k festvox-kdlpc16k
./install_festival_voices.sh

#Install samba for file sharing from OSX servers et al
sudo apt install -y samba

#update firewall to allow samba traffic
sudo ufw allow samba

sudo apt install -y httpie ripgrep graphviz

#some pre-requisites of building xdotool (keyboard magic)
sudo apt install  libxtst-dev libxinerama-dev libxcb-xinerama0 libxcb-xinerama0-dev libxkbcommon-dev
#below is required before pip install pyaudio can work. pyaudio is required for silvius mic selection
sudo apt install portaudio19-dev

sudo apt install flac #install flac decompressor
sudo apt install swig #wraps c++ headers to make libs available to python, ruby java nad other languages
