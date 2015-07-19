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
mkvirtualenv home
pip install powerline-status
git clone git@github.com:MatthewCox/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install
// Make zsh default shell
// Run zsh
// Run update_dotfiles
```

And additional steps for systems I load a desktop on.

```
sudo apt-get install guake
// Guake autorun on startup
// Powerline font installation
```
