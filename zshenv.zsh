skip_global_compinit=1

export SHELL=$(command -v zsh)
stty -ixon
stty ixany

# source untracked machine specific environment variables, if they exist
if [[ -e $HOME/.zshenv_ut ]]; then
    source $HOME/.zshenv_ut
fi

path=(
    "$HOME/.dotfiles/ignored/commands"
    "$HOME/scripts"
    "$HOME/.dotfiles/scripts/colorscheme"
    "$HOME/.dotfiles/scripts"
    "$HOME/.tmuxifier/bin"
    "$HOME/.local/bin"
    "$HOME/bin"
    "$path[@]"
)
export PATH
typeset -U path

export LD_LIBRARY_PATH=$HOME/.local/lib:$LD_LIBRARY_PATH
typeset -T LD_LIBRARY_PATH ld_library_path
typeset -U ld_library_path

#if type manpath > /dev/null; then
#    manpath=(
#        "$HOME/.local/man"
#        "$HOME/.local/share/man:"
#    )
#else
#    manpath=(
#        "$HOME/.local/man"
#        "$HOME/.local/share/man"
#        "/usr/local/man"
#        "/usr/local/share/man"
#        "/usr/share/man/en"
#        "/usr/share/man"
#    )
#fi
#typeset -U manpath
#export MANPATH

export COWPATH=$HOME/.dotfiles/ignored/cows

export HISTFILE=$HOME/.zsh_history_$USER

export LANG=en_GB.UTF-8
export LC_CTYPE=en_GB.UTF-8
unset LC_ALL

export DOTFILES=$HOME/.dotfiles

export ZSH_CUSTOM=$DOTFILES/ignored/omz-custom

export EDITOR="$HOME/.dotfiles/ignored/EDITOR"

# customized file/dir colours for ls
eval `dircolors -b $HOME/._dircolors_`

export PYTHONSTARTUP=$HOME/.pystartup

if [[ -x "$(command -v rustc)" ]]; then
    export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"
    source "$HOME/.cargo/env"
fi

if [[ -e $(command -v virtualenvwrapper.sh) ]]; then
    source virtualenvwrapper.sh
elif [[ -e /usr/bin/virtualenvwrapper.sh ]]; then
    source /usr/bin/virtualenvwrapper.sh
elif [[ -e /usr/share/virtualenvwrapper/virtualenvwrapper.sh ]]; then
    source /usr/share/virtualenvwrapper/virtualenvwrapper.sh
else
    print "virtualenvwrapper.sh is missing, have you installed virtualenvwrapper?"
fi

export NPM_PACKAGES="$HOME/.npm-packages"
export NODE_PATH="$NPM_PACKAGES/lib/node_modules${NODE_PATH:+:$NODE_PATH}"
export PATH="$NPM_PACKAGES/bin:$PATH"
# Unset manpath so we can inherit from /etc/manpath via the `manpath`
# command
#unset MANPATH  # delete if you already modified MANPATH elsewhere in your config
#export MANPATH="$NPM_PACKAGES/share/man:$(manpath)"

# if environment variables need to be modified for this machine, source a file that does that
if [[ -e $HOME/.zshenv_ut_post ]]; then
    source $HOME/.zshenv_ut_post
fi

# override $TERM with 256color support if running via ssh on Linux
if test -n "$SSH_CLIENT"; then
    if test "$(uname -s)=Linux"; then
        if [[ "$TERM" = xterm* ]]; then
            export TERM=xterm-256color
        fi
    fi
fi
