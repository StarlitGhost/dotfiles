case $USER in
	*sim*)		export REALHOME=/user/mhc ;;
	*)		export REALHOME=${HOME}
esac

source $REALHOME/.zshenv_ut

export PATH=$REALHOME/bin:$PATH

case $USER in
	*sim*)		export HISTFILE=$REALHOME/.zsh_histories/.zsh_history_$USER ;;
	*)		export HISTFILE=$REALHOME/.zsh_history_$USER
esac

export DOTFILES=$REALHOME/.dotfiles

export ZSH_CUSTOM=$DOTFILES/ignored/omz-custom

export EDITOR=nano

export DIRCOLORS=$REALHOME/.dircolors

export PYTHONSTARTUP=$REALHOME/.pystartup
