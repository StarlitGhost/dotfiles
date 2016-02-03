skip_global_compinit=1

case $USER in
	 *felix* | *sim* | *simvideo* )	export REALHOME=/user/mhc ;;
	 * )			export REALHOME=${HOME}
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

export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=$REALHOME/.local/lib:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=$REALHOME/lib:$LD_LIBRARY_PATH
typeset -T LD_LIBRARY_PATH ld_library_path
typeset -U ld_library_path

if whence manpath >/dev/null 2>&1; then
    MANPATH="`manpath`"
    manpath=(
        "$REALHOME/.local/man"
        "$REALHOME/.local/share/man"
        "$REALHOME/man"
        "$manpath[@]"
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
	*felix* | *sim* | *simvideo* )	export HISTFILE=$REALHOME/.zsh_histories/.zsh_history_$USER ;;
	* )				export HISTFILE=$REALHOME/.zsh_history_$USER
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

if [[ -e $(command -v virtualenvwrapper.sh) ]]; then
    source virtualenvwrapper.sh
elif [[ -e /usr/bin/virtualenvwrapper.sh ]]; then
    source /usr/bin/virtualenvwrapper.sh
else
    print "virtualenvwrapper.sh is missing, have you installed virtualenvwrapper?"
fi

# generate completion for commands that follow standard gnu --help output,
# but for some reason don't already have completions
compdef _gnu_generic watch progress

# if environment variables need to be modified for this machine, source a file that does that
if [[ -e $REALHOME/.zshenv_ut_post ]]; then
    source $REALHOME/.zshenv_ut_post
fi
