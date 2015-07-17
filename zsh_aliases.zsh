# dos clear (less typing!)
alias cls='clear'

# ls
alias la='ls -la'
alias lh='ls -ld .??*'
alias lt='ls -latr'
alias lr='ls -lat'

lass () {
    la "$@" --color=always | less
}

# zsh config files
alias ez='$EDITOR $REALHOME/.zshrc'
alias eza='$EDITOR $REALHOME/.zsh_aliases'
alias ezau='$EDITOR $REALHOME/.zsh_aliases_ut'
alias eze='$EDITOR $REALHOME/.zshenv'
alias ezeu='$EDITOR $REALHOME/.zshenv_ut'
alias ezeup='$EDITOR $REALHOME/.zshenv_ut_post'
alias sz='source $REALHOME/.zshenv ; source $REALHOME/.zshrc'
alias szc='sz ; clear'

alias update_dotfiles='pushd $REALHOME/.dotfiles > /dev/null 2>&1 ; git pull && git submodule init && git submodule foreach git checkout master > /dev/null 2>&1 && git submodule foreach git pull ; ./install ; echo "" ; sz ; popd > /dev/null 2>&1'
alias u.='update_dotfiles'

# fancy syntax-highlighted cat
alias pyg='pygmentize -g'
pyglet () {
    pyg "$@" | less
}

# more obvious opposite of export
alias unexport='unset'

# make .csh files source-able, for setting up environment variables
source_csh () {
    exec csh -c "source $@; exec zsh"
}

# tmux
alias tl='tmux ls'
alias ta='tmux attach -t'
alias td='tmux detach -t'
alias tn='tmux has -t $1 &> /dev/null && tmux attach -t $1 || tmux new -s $1'

alias htop='TERM=xterm-color htop'

# vim
alias vimrc='vim $REALHOME/.vimrc'

# find an executable file (or symlinked executable file) in the PATH
pathfind () {
    for i in "${(s/:/)PATH}"; do
        find -L $i -maxdepth 1 -type f -executable -name "$@" 2>/dev/null ;
    done
}

# find an executable file in the PATH and execute it with --version appended
pathversion () {
    for i in "${(s/:/)PATH}"; do
        find -L $i -maxdepth 1 -type f -executable -name "$@" 2>/dev/null -exec echo {} \; -exec {} --version \;
    done
}

# progress bar, and generally better in every way
alias cp="rsync -avz --progress"

# move files into dir, auto-creating dir and all intervening dirs if they don't exist
mkmv () {
    local -a arr
    arr=($@)
    #print ${arr[-1]}
    mkdir -p ${arr[-1]}
    #print ${arr[1,-2]}
    mv ${arr[1,-2]} ${arr[-1]}
}

# copy files into dir, auto-creating dir and all intervening dirs if they don't exist
mkcp () {
    local -a arr
    arr=($@)
    mkdir -p ${arr[-1]}
    cp ${arr[1,-2]} ${arr[-1]}
}

switchdir () {
    cd `pwd | sed 's|'$1'|_mhc_switchdir|;s|'$2'|'$1'|' | sed 's|_mhc_switchdir|'$2'|'`
}

# make which also look at aliases
alias which='alias | /usr/bin/env which --tty-only --read-alias --show-dot --show-tilde'

# fancy formatted git log
# format placeholders: http://git-scm.com/docs/pretty-formats
alias glog='git log --oneline --decorate --graph --color --date=relative \
    --pretty=format:"%C(auto)%h %C(cyan)(%ad)%C(auto)%d%C(reset) %s %C(blue)<%an>"'
alias glogd='glog --date=short'

# kill a background job
alias killbg='kill ${${(v)jobstates#*:*:}%=*}'
function killjob()
{
    emulate -L zsh
    for jobnum in $@ ; do
        kill ${${jobstates[$jobnum]#*:*:}%=*}
    done
}

# todo.txt
export TODOTXT_DEFAULT_ACTION=ls
export TODOTXT_SORT_COMMAND='env LC_COLLATE=C sort -k 2,2 -k 1,1n'
alias t='todo.sh -d $DOTFILES/ignored/todo.cfg'

# perforce aliases
# use sed to colour p4 grep output similar to standard grep colouring, then use standard grep to colour the matches themselves
p4grep() {
          # depot path¦#¦revision¦  :/-  ¦line num ¦ :/-|purple ¦dep¦cyan ¦#¦yellow¦rev¦cyan¦:/-¦green ¦line¦cyan¦:/-¦reset
    p4 grep -n -e $* | sed \
     -e "s|^\(//[^#]*\)#\([0-9]*\)\([:-]\)\([0-9]*\)[:-]|\x1B[35m\1\x1B[36m#\x1B[33m\2\x1B[36m\3\x1B[32m\4\x1B[36m\3\x1B[0m|" \
     -e "s|^--$|\x1B[36m--\x1B[0m|" \
    | grep -E ${*[1,-2]}
}

# man for python modules
alias pyman='$REALHOME/.dotfiles/ignored/commands/pyman.py'

# clean out all cmake generated files from the current directory
alias cmake-clean='$REALHOME/.dotfiles/ignored/commands/cmake-clean.py'

# test colour theme with some tables and ascii art
alias ansi-colours='$REALHOME/.dotfiles/ignored/commands/ansi-colours.sh ; $REALHOME/.dotfiles/ignored/commands/ansi-table.sh ; $REALHOME/.dotfiles/ignored/commands/ansi-pacman.sh ; $REALHOME/.dotfiles/ignored/commands/ansi-invaders.sh'

if [[ `uname -o` == Cygwin ]]; then
	alias cyg-ports='cyg-apt --no-verify --mirror="ftp://ftp.cygwinports.org/pub/cygwinports/"'
fi

# Call virtualenvwrapper's "workon" if .venv exists.  This is modified from--
# http://justinlilly.com/python/virtualenv_wrapper_helper.html
# which is linked from--
# http://virtualenvwrapper.readthedocs.org/en/latest/tips.html#automatically-run-workon-when-entering-a-directory
check_virtualenv() {
    if [ -e .venv ]; then
	venv=`cat .venv`
        if [ "$venv" != "${VIRTUAL_ENV##*/}" ]; then
            unset SKIPZSH
            echo "Found .venv in directory. Calling: workon ${venv}"
            workon $venv
        fi
    fi
}
venv_cd () {
    builtin cd "$@" && check_virtualenv
}
# Call check_virtualenv in case opening directly into a directory (e.g
# when opening a new tab in Terminal.app).
check_virtualenv

# Add the following to ~/.bash_aliases:
alias cd="venv_cd"

# screen
alias sl='screen -ls'
alias sls='screen -ls'
alias sr='screen -r'
alias swipe='screen -wipe'

sshs () {
	screen -RR $1 ssh $1
}

ruge() {
    compinit
    local f
    f=($REALHOME/.dotfiles/ignored/omz-custom/plugins/uge/*(.))
    unfunction $f:t 2> /dev/null
    autoload -U $f:t
}

# source untracked environment or machine specific aliases, if they exist
if [[ -e $REALHOME/.zsh_aliases_ut ]]; then
    source $REALHOME/.zsh_aliases_ut
fi
