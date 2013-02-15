case "$USER" in
	(mhc)
		export REALHOME='/user/mhc'
	;;
	(sim)
		export REALHOME='/user/mhc'
	;;
esac

source $REALHOME/.zshenv_ut

export PATH=$REALHOME/bin:$PATH
