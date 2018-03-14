skip_global_compinit=1

export SHELL=$(command -v zsh)
stty -ixon
stty ixany

case $USER in
	 felix|sim|simvideo)
         export REALHOME=/user/mhc
         ;;
	 *)
         export REALHOME=${HOME}
esac

# source untracked machine specific environment variables, if they exist
if [[ -e $REALHOME/.zshenv_ut ]]; then
    source $REALHOME/.zshenv_ut
fi

path=(
    "$REALHOME/.dotfiles/ignored/commands"
    "$REALHOME/scripts"
    "$REALHOME/.tmuxifier/bin"
    "$REALHOME/.local/bin"
    "$REALHOME/bin"
    "$path[@]"
)
export PATH
typeset -U path

export LD_LIBRARY_PATH=$REALHOME/.local/lib:$LD_LIBRARY_PATH
typeset -T LD_LIBRARY_PATH ld_library_path
typeset -U ld_library_path

if type manpath > /dev/null; then
    manpath=(
        "$REALHOME/.local/man"
        "$REALHOME/.local/share/man"
        "$REALHOME/man:"
    )
else
    manpath=(
        "$REALHOME/.local/man"
        "$REALHOME/.local/share/man"
        "$REALHOME/man"
        "/usr/local/man"
        "/usr/local/share/man"
        "/usr/share/man/en"
        "/usr/share/man"
        "/user/rcs/man"
        "/vl/seg/man"
    )
fi
typeset -U manpath
export MANPATH

case $USER in
	felix|sim|simvideo)
        export HISTFILE=$REALHOME/.zsh_histories/.zsh_history_$USER
        ;;
	*)
        export HISTFILE=$REALHOME/.zsh_history_$USER
esac

export LANG=en_GB.UTF-8
export LC_CTYPE=en_GB.UTF-8
unset LC_ALL

export DOTFILES=$REALHOME/.dotfiles

export ZSH_CUSTOM=$DOTFILES/ignored/omz-custom

export EDITOR="$REALHOME/.dotfiles/ignored/EDITOR"

# customized file/dir colours for ls
eval `dircolors -b $REALHOME/._dircolors_`

export PYTHONSTARTUP=$REALHOME/.pystartup

if [[ -x "$(command -v rustc)" ]]; then
    export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"
fi

if [[ -e $(command -v virtualenvwrapper.sh) ]]; then
    source virtualenvwrapper.sh
elif [[ -e /usr/bin/virtualenvwrapper.sh ]]; then
    source /usr/bin/virtualenvwrapper.sh
else
    print "virtualenvwrapper.sh is missing, have you installed virtualenvwrapper?"
fi

# if environment variables need to be modified for this machine, source a file that does that
if [[ -e $REALHOME/.zshenv_ut_post ]]; then
    source $REALHOME/.zshenv_ut_post
fi

# override $TERM with 256color support if running via ssh on Linux
if test -n "$SSH_CLIENT"; then
    if test "$(uname -s)=Linux"; then
        if [[ "$TERM" = xterm* ]]; then
            export TERM=xterm-256color
        fi
    fi
fi
