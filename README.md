dotfiles
========

My system-independent dotfiles.
Only directly useful to myself, but feel free to scavenge from them!

New system instructions
-----------------------
Instructions for setting up on a new debian-based machine.
My dotfiles still work on other systems, but package installation is different.

```
sudo apt-get install automake build-essential cmake git python-dev python-pip \
ruby ssh tmux vim zsh
sudo pip install virtualenv virtualenvwrapper
source /usr/local/bin/virtualenvwrapper.sh ; mkvirtualenv home
pip install powerline-status
ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa ; cat ~/.ssh/id_rsa.pub
```
Add key to GitHub account, then...
```
git clone git@github.com:MatthewCox/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
git pull && git submodule update --init --recursive && \
git submodule foreach git checkout master && git submodule foreach git pull
./install
chsh -s /bin/zsh ; exec zsh -l
```

And some additional steps for systems I load a desktop on.

```
sudo apt-get install guake
sudo ln -s /usr/share/applications/guake.desktop /etc/xdg/autostart/
git clone https://github.com/powerline/fonts.git ~/powerline-fonts
cd ~/powerline-fonts ; sudo ./install.sh
~/.dotfiles/ignored/gnome-terminal-obsidian.sh
~/.gotfiles/ignored/guake-obsidian.sh
```
