# dotfiles

My system-independent dotfiles.
Only directly useful to myself, but feel free to scavenge from them!

## Debian-based setup (outdated, I fully migrated to Arch)
```
sudo apt-get --yes install automake build-essential cmake git \
mosh python-dev python-pip ssh tmux vim zsh
sudo pip install virtualenv virtualenvwrapper
source /usr/local/bin/virtualenvwrapper.sh ; mkvirtualenv home
pip install powerline-status
ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa ; cat ~/.ssh/id_rsa.pub
```
Add key to GitHub account, then...
```
ssh-keyscan github.com >> ~/.ssh/known_hosts
git clone git@github.com:StarlitGhost/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
git pull && git submodule update --init --recursive && \
git submodule foreach git checkout master && git submodule foreach git pull
./install
chsh -s /bin/zsh ; exec zsh -l
```
### Additional GUI steps
```
sudo apt-get --yes install guake
sudo ln -s /usr/share/applications/guake.desktop /etc/xdg/autostart/
git clone https://github.com/powerline/fonts.git ~/powerline-fonts
~/powerline-fonts/install.sh
~/.dotfiles/ignored/gnome-terminal-obsidian.sh
~/.dotfiles/ignored/guake-obsidian.sh
```

## Arch Linux setup
```
sudo pacman -Syu
sudo pacman -S --needed base-devel
sudo pacman -S bat cmake cowsay diff-so-fancy fortune-mod git lolcat mosh \
ncdu neofetch openssh python-neovim python2-neovim python-pip python2-pip \
python-powerline python-pygments python-virtualenvwrapper ranger tmux neovim \
zsh
yay -S prettyping # need to install yay first, obviously
ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa ; cat ~/.ssh/id_rsa.pub
```
Add key to GitHub account, then...
```
ssh-keyscan github.com >> ~/.ssh/known_hosts
git clone git@github.com:StarlitGhost/dotfiles.git ~/.dotfiles
mv ~/.config/* ~/.dotfiles/config # should be fine assuming completely fresh system, but check for possible overwrites first!
cd ~/.dotfiles
git pull && git submodule update --init --recursive && \
git submodule foreach git checkout master && git submodule foreach git pull
./install
chsh -s /bin/zsh ; exec zsh -l
```
### Additional GUI steps
```
sudo pacman -S arc-gtk-theme arc-icon-theme compton dunst i3-gaps kitty lxappearance lxqt-policykit nitrogen redshift rofi thunar ttf-font-awesome
yay -S polybar powerline-fonts-git
```
