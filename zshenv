case $USER in
	 *felix* | *sim* | *simvideo* )	export REALHOME=/user/mhc ;;
	 * )			export REALHOME=${HOME}
esac

source $REALHOME/.zshenv_ut

export PATH=$REALHOME/bin:$REALHOME/.local/bin:$REALHOME/scripts:$REALHOME/.dotfiles/ignored/commands:$PATH
typeset -U PATH

export LD_LIBRARY_PATH=$REALHOME/lib:/usr/local/lib:$LD_LIBRARY_PATH
typeset -U LD_LIBRARY_PATH

case $USER in
	*felix* | *sim* | *simvideo* )	export HISTFILE=$REALHOME/.zsh_histories/.zsh_history_$USER ;;
	* )			export HISTFILE=$REALHOME/.zsh_history_$USER
esac

export LC_ALL=en_GB.UFT-8
export LANG=en_GB.UTF-8
export LANGUAGE=en_GB.UTF-8

export DOTFILES=$REALHOME/.dotfiles

export ZSH_CUSTOM=$DOTFILES/ignored/omz-custom

export EDITOR=nano

export DIRCOLORS=$REALHOME/.dircolors

export PYTHONSTARTUP=$REALHOME/.pystartup

source virtualenvwrapper.sh
