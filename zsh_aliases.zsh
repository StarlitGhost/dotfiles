# dos clear (less typing!)
alias cls='clear'

# ls
alias la='ls -lah' # all info + dotfiles
alias lh='ls -ldh .??*' # just dotfiles
alias lt='ls -latrh' # all info + dotfiles, sorted newest to oldest
alias lr='ls -lath' # all info + dotfiles, sorted oldest to newest

# pipe la into less
lass () {
    la "$@" --color=always | less
}

# zsh config files
alias ez='$EDITOR $HOME/.zshrc'
alias eza='$EDITOR $HOME/.zsh_aliases'
alias ezau='$EDITOR $HOME/.zsh_aliases_ut'
alias eze='$EDITOR $HOME/.zshenv'
alias ezeu='$EDITOR $HOME/.zshenv_ut'
alias ezeup='$EDITOR $HOME/.zshenv_ut_post'
alias sz='source $HOME/.zshenv ; source $HOME/.zshrc'
alias szc='sz ; clear'

# vim
if type "nvim" > /dev/null 2>&1; then
    alias vim=nvim
fi
alias vim='vim -u $HOME/.vimrc'
alias vimrc='$EDITOR $HOME/.vimrc'
alias v='vim'
alias e='$EDITOR'

# i3
alias vi3='$EDITOR $HOME/.config/i3/config'

# bspwm
alias vb='$EDITOR $HOME/.config/bspwm/bspwmrc'
# sxhkd
alias vs='$EDITOR $HOME/.config/sxhkd/sxhkdrc'

# polybar
alias vp='$EDITOR $HOME/.config/polybar/config'

alias update_dotfiles='unsetopt pushd_ignore_dups ; \
    pushd $HOME/.dotfiles > /dev/null 2>&1 ; \
    git pull && \
    git submodule update --init --recursive && \
    git submodule foreach git checkout master > /dev/null 2>&1 && \
    git submodule foreach git pull ; \
    ./install ; \
    echo "" ; \
    sz ; \
    popd > /dev/null 2>&1 ; \
    setopt pushd_ignore_dups'
alias u.='update_dotfiles'

# priviledge aliases
alias pacman='sudo pacman'

# a bit more polite
# 'fuck' attempts to automatically fix the previously entered command
alias oops='fuck'

alias pwd='pwd -P'

# I just like typing yay, ok?!
if type "pikaur" > /dev/null 2>&1; then
    alias yay='pikaur'
fi

# fancy syntax-highlighted cat
if type "bat" > /dev/null 2>&1; then
    alias cat='bat'
elif type "batcat" > /dev/null 2>&1; then
    alias cat='batcat'
    alias bat='batcat'
elif type "pygmentize" > /dev/null 2>&1; then
    echo "cat: bat not available, falling back to pygmentize"
    alias cat='pygmentize -g'
    pyglet () {
        pygmentize "$@" | less
    }
else
    echo "cat: neither bat nor pygmentize are available, falling back to cat"
fi

# fancy ping
if type "prettyping" > /dev/null 2>&1; then
    alias ping='prettyping --nolegend'
else
    echo "ping: PrettyPing not available, falling back to ping"
fi
# a much better name for ping
alias boop='ping'

# fancy du
if type "ncdu" > /dev/null 2>&1; then
    alias du='ncdu -x --exclude .git'
else
    echo "du: ncdu not available, falling back to du"
fi

# w3m checks $TERM for 'xterm' in order to enable mouse controls... dumb, but whatever
if type "w3m" > /dev/null 2>&1; then
    alias w3m='TERM=xterm-256color w3m'
fi

# more obvious opposite of export
alias unexport='unset'

# make .csh files source-able, for setting up environment variables
source_csh () {
    unset LS_COLORS
    exec csh -c "source $@; exec zsh"
}

# tmux
alias tl='tmux ls'
alias ta='tmux attach -t'
alias td='tmux detach -t'
alias tn='tmux has -t $1 &> /dev/null && tmux attach -t $1 || tmux new -s $1'

# find an executable file (or symlinked executable file) in the PATH
pathfind () {
    for i in "${(s/:/)PATH}"; do
        if [[ -d "$i" ]] && [[ -x "$i" ]]; then
            find -L $i -maxdepth 1 -type f -executable -name "$@" \
                2> >(grep -v -E "Permission denied|File system loop" >&2)
        fi
    done
}

# find an executable file in the PATH and execute it with --version appended
pathversion () {
    for i in "${(s/:/)PATH}"; do
        if [[ -d "$i" ]] && [[ -x "$i" ]]; then
            find -L $i -maxdepth 1 -type f -executable -name "$@" \
                -exec echo -e "\x1B[35m{}\x1B[0m" \; -exec {} --version \; \
                2> >(grep -v -E "Permission denied|File system loop" >&2)
        fi
    done
}

# find an executable file in the PATH and execute it with -V appended
pathv () {
    for i in "${(s/:/)PATH}"; do
        if [[ -d "$i" ]] && [[ -x "$i" ]]; then
            find -L $i -maxdepth 1 -type f -executable -name "$@" \
                -exec echo -e "\x1B[35m{}\x1B[0m" \; -exec {} -V \; \
                2> >(grep -v -E "Permission denied|File system loop" >&2)
        fi
    done
}

# progress bar, and generally better in every way
alias cp="rsync -avz --progress"

# move files into dir, auto-creating dir
# and all intervening dirs if they don't exist
mkmv () {
    local -a arr
    arr=($@)
    #print ${arr[-1]}
    mkdir -p ${arr[-1]}
    #print ${arr[1,-2]}
    mv ${arr[1,-2]} ${arr[-1]}
}

# copy files into dir, auto-creating dir
# and all intervening dirs if they don't exist
mkcp () {
    local -a arr
    arr=($@)
    mkdir -p ${arr[-1]}
    cp ${arr[1,-2]} ${arr[-1]}
}

# prepend _rm_ to file/dir name then rm it (to allow the old name to be used immediately)
mvrm () {
    mv $@ _rm_$@
    rm -rf _rm_$@
}

# rm with progress bar, using pv
rmp () {
    rm -rfv $@ | pv -l -s `find $@ | wc -l` > /dev/null
}

# sed replace on the current dir and go to the result
switchdir () {
    cd `pwd | sed 's|'$1'|_hc_switchdir|;s|'$2'|'$1'|' | sed 's|_hc_switchdir|'$2'|'`
}
alias swdir='switchdir'

# lists files that are common between all given directories
commonfiles () {
    find "$@" -maxdepth 1 -type f -name "*" -printf '%f\n' | sort | uniq -c | sed -n "s/^ *$# //p"
}

# make which also look at aliases
if which --version &> /dev/null; then
    alias which='alias | /usr/bin/env which --tty-only --read-alias --show-dot --show-tilde'
fi

# wrap xargs to automatically expand aliases
xargs () {
    local expandalias
    if [[ "$(type -w $1)" =~ "alias" ]]; then
        expandalias=$aliases[$1]
    else
        expandalias=$1
    fi
    command xargs ${(z)expandalias} "${(z)@[2,-1]}"
}

# fancy formatted git log
# format placeholders: http://git-scm.com/docs/pretty-formats
alias glog='git log --oneline --decorate --graph --color --date=relative \
    --pretty=format:"%C(auto)%h %C(cyan)(%ad)%C(auto)%d%C(reset) %s %C(blue)<%an>"'
alias glogd='glog --date=short'
alias gd='git diff --color'
alias gds='git diffs --color'

# wait for a process to finish before executing something else
# usage: waitforpid <process id>; other-command
function waitforpid()
{
    echo "Waiting for \"$(ps -p $1 -o cmd=)\" (PID $1)..."
    while ps -p $1 > /dev/null; do
        sleep 5
    done
}
# search for a process by name then wait on its pid
function waitfor()
{
    local pid
    pid=$(pgrep -nf $1) ;
    waitforpid $pid ;
}

# kill a background job
alias killbg='kill ${${(v)jobstates#*:*:}%=*}'
function killjob()
{
    emulate -L zsh
    local jobnum
    for jobnum in $@ ; do
        kill ${${jobstates[$jobnum]#*:*:}%=*}
    done
}

# todo.txt
export TODOTXT_DEFAULT_ACTION=ls
export TODOTXT_SORT_COMMAND='env LC_COLLATE=C sort -k 2,2 -k 1,1n'
alias t='todo.sh -d $DOTFILES/ignored/todo.cfg'

# perforce aliases
# use sed to colour p4 grep output similar to standard grep colouring,
# then use standard grep to colour the matches themselves
p4grep() {
          # depot path¦#¦revision¦  :/-  ¦line num ¦ :/-|purple ¦dep¦cyan ¦#¦yellow¦rev¦cyan¦:/-¦green ¦line¦cyan¦:/-¦reset
    p4 grep -n -e $* | sed \
     -e "s|^\(//[^#]*\)#\([0-9]*\)\([:-]\)\([0-9]*\)[:-]|\x1B[35m\1\x1B[36m#\x1B[33m\2\x1B[36m\3\x1B[32m\4\x1B[36m\3\x1B[0m|" \
     -e "s|^--$|\x1B[36m--\x1B[0m|" \
    | grep -E ${*[1,-2]}
}
# sync all directories under the current one that have a .p4config file
p4syncall() {
    local -a p4confs
    local p4conf
    local p4dir
    p4confs=($(find -name ".p4config"))
    for p4conf in $p4confs ; do
        p4dir=$(dirname $(realpath $p4conf)) ;
        echo -e "\x1B[35m$p4dir\x1B[0m" ;
        pushd $p4dir 1>/dev/null && p4 sync ; popd 1>/dev/null ;
    done
}

# sed to color zgrep output like grep --colour=auto
# to use just pipe zgrep into it
alias color-zgrep='sed -e "s|^\([^:]*\)\(:\)\([0-9]*\)\(:\)|\x1B[35m\1\x1B[36m\2\x1B[32m\3\x1B[36m\4\x1B[0m|"'

# man for python modules
alias pyman='$HOME/.dotfiles/ignored/commands/pyman.py'

# clean out all cmake generated files from the current directory
alias cmake-clean='$HOME/.dotfiles/ignored/commands/cmake-clean.py'

# generate completion for commands that follow standard gnu --help output,
# but for some reason don't already have completions
compdef _gnu_generic watch progress bat

# generate completions for some scripts that wrap other commands and pass on all args
compdef _valgrind colour-valgrind

# test colour theme with some tables and ascii art
alias ansi-colours='$HOME/.dotfiles/ignored/commands/ansi-colours.sh ;\
    $HOME/.dotfiles/ignored/commands/ansi-table.sh ;\
    $HOME/.dotfiles/ignored/commands/ansi-pacman.sh ;\
    $HOME/.dotfiles/ignored/commands/ansi-invaders.sh'

# source untracked environment or machine specific aliases, if they exist
if [[ -e $HOME/.zsh_aliases_ut ]]; then
    source $HOME/.zsh_aliases_ut
fi
