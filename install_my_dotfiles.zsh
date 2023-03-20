git clone git@kiggys.github.com:kiggundu/dotfiles ~/.dotfiles

mv ~/.oh-my-zsh/custom/profiles ~/.oh-my-zsh/custom/profiles-backup
ln -s ~/.dotfiles/.oh-my-zsh/custom/profiles ~/.oh-my-zsh/custom/profiles

mv ~/.zshrc  ~/.zshrc-backup
ln -s ~/.dotfiles/.zshrc ~/.zshrc

mv ~/.profile  ~/.profile-backup
ln -s ~/.dotfiles/.profile ~/.profile

mv ~/.config/youtube-dl  ~/.config/youtube-dl-backup
ln -s ~/.dotfiles/config/youtube-dl ~/.config/youtube-dl

mv ~/.config/git  ~/.config/git-backup
ln -s ~/.dotfiles/config/git ~/.config/git

mv ~/.config/variety  ~/.config/variety-backup
ln -s ~/.dotfiles/variety ~/.config/variety

mv ~/.gnuradio/grc.conf ~/.gnuradio/grc.conf-backup
ln -s ~/.dotfiles/.gnuradio/grc.conf ~/.gnuradio/grc.conf

mv ~/.config/fzf.zh  ~/.config/fzf.zh-backup
ln -s ~/.dotfiles/config/fzf.zsh ~/.config/fzf.zh

mv ~/.byobu  ~/.byobu-backup
ln -s ~/.dotfiles/.byobu ~/.byobu
