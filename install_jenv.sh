git clone https://github.com/jenv/jenv.git ~/.jenv
# Shell: zsh
echo 'export PATH="$HOME/.jenv/bin:$PATH"' >> ~/.zshrc
echo 'eval "$(jenv init -)"' >> ~/.zshrc

sudo apt install default-jdk
jenv add /usr/lib/jvm/java-11-openjdk-amd64/
