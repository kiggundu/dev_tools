sudo apt install -y software-properties-common
sudo apt install -y curl
sudo apt install -y wget
sudo apt install -y git
sudo apt install -y git-extras
sudo apt install -y gh
sudo apt install -y terminator
sudo apt install -y rbenv
sudo apt install -y default-jdk
sudo apt install -y kdiff3
sudo apt install -y lnav
sudo apt install -y youtube-dl
sudo apt install -y octave
sudo apt install -y build-essential
sudo apt install -y file
sudo apt install -y htop
sudo apt install -y libpq-dev
sudo apt install -y gnome-control-center
sudo apt install -y truecrypt
sudo apt install -y calibre
sudo apt install -y gnucash
sudo apt install -y exfat-fuse
sudo apt install -y tidy
sudo apt install -y xdotool
sudo apt install -y keynav
sudo apt install -y vim-gtk
sudo apt install -y tree
sudo apt install -y xclip
sudo apt install -y pass
sudo apt install -y zsh
sudo apt install -y fzf
sudo apt install -y vlc
sudo apt install -y sshfs
sudo apt install -y gparted
sudo apt install -y thefuck
sudo apt install -y autojump
sudo apt install -y llvm
sudo apt install -y libncurses5-dev
sudo apt install -y libncursesw5-dev
sudo apt install -y xz-utils
sudo apt install -y tk-dev
sudo apt install -y libffi-dev
sudo apt install -y liblzma-dev
sudo apt install -y nodejs
sudo apt install -y yarn
sudo apt install -y p7zip-full

#voice tools and voices
sudo apt install -y festival speech-tools
#sudo apt-get install -y festvox-don festvox-rablpc16k festvox-kallpc16k festvox-kdlpc16k
#./install_festival_voices.sh

#Install samba for file sharing from OSX servers et al
sudo apt install -y samba

#update firewall to allow samba traffic
sudo ufw allow samba

sudo apt install -y httpie
sudo apt install -y ripgrep
sudo apt install -y graphviz

#some pre-requisites of building xdotool (keyboard magic)
sudo apt install  libxtst-dev
sudo apt install -y libxinerama-dev
sudo apt install -y libxcb-xinerama0
sudo apt install -y libxcb-xinerama0-dev
sudo apt install -y libxkbcommon-dev
#below is required before pip install pyaudio can work. pyaudio is required for silvius mic selection
sudo apt install portaudio19-dev

sudo apt install -y flac #install flac decompressor
sudo apt install -y swig #wraps c++ headers to make libs available to python, ruby java nad other languages

sudo apt install -y vifm

sudo apt install -y adb
