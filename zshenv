case $USER in
	*sim*)		export REALHOME=/user/mhc ;;
	*)		export REALHOME=${HOME}
esac

source $REALHOME/.zshenv_ut

export PATH=$REALHOME/bin:$PATH

export HISTFILE=$REALHOME/.zsh_history_$USER

export DOTFILES=$REALHOME/.dotfiles

export ZSH_CUSTOM=$DOTFILES/ignored/omz-custom

export EDITOR=nano

export PYTHONSTARTUP=$REALHOME/.pystartup
