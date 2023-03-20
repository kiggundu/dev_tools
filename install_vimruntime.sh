#organised vimrc config
git clone git@kiggys.github.com:kiggundu/vimrc ~/.vim_runtime
sh ~/.vim_runtime/install_awesome_vimrc.sh

#The plugin manager
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

#source dotfiles config
mv ~/.vim_runtime/my_configs.vim ~/.vim_runtime/my_configs.vim.backup
ln -s ~/.dotfiles/.vim_runtime/my_configs.vim ~/.vim_runtime/my_configs.vim
