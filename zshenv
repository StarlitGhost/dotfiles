case $USER in
	*sim*)		REALHOME=/user/mhc ;;
	*)		REALHOME=${HOME}
esac

source $REALHOME/.zshenv_ut

PATH=$REALHOME/bin:$PATH

HISTFILE=$REALHOME/.zsh_history

DOTFILES=$REALHOME/.dotfiles

ZSH_CUSTOM=$DOTFILES/ignored/omz-custom

EDITOR=nano
