case $USER in
	*mhc*)		REALHOME=/user/mhc ;;
	*sim*)		REALHOME=/user/mhc ;;
	*)		REALHOME=${HOME}
esac

source $REALHOME/.zshenv_ut

PATH=$REALHOME/bin:$PATH
