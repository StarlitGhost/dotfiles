# vim:ft=zsh ts=2 sw=2 sts=2
#
# agnoster's Theme - https://gist.github.com/3712874
# A Powerline-inspired theme for ZSH
#
# # README
#
# In order for this theme to render correctly, you will need a
# [Powerline-patched font](https://github.com/Lokaltog/powerline-fonts).
#
# In addition, I recommend the
# [Solarized theme](https://github.com/altercation/solarized/) and, if you're
# using it on Mac OS X, [iTerm 2](http://www.iterm2.com/) over Terminal.app -
# it has significantly better color fidelity.
#
# # Goals
#
# The aim of this theme is to only show you *relevant* information. Like most
# prompts, it will only show git information when in a git working directory.
# However, it goes a step further: everything from the current user and
# hostname to whether the last call exited with an error to whether background
# jobs are running in this shell will all be displayed automatically when
# appropriate.

### Segment drawing
# A few utility functions to make it easy and re-usable to draw segmented prompts

CURRENT_BG='NONE'
if [[ `uname` == 'Darwin' ]]; then
    SEGMENT_SEPARATOR='\ue0b0'
    SAME_COL_SEG_SEP='\ue0b1'
    RSEGMENT_SEPARATOR='\ue0b2'
    RSAME_COL_SEG_SEP='\ue0b3'
else
    SEGMENT_SEPARATOR=''
    SAME_COL_SEG_SEP=''
    RSEGMENT_SEPARATOR=''
    RSAME_COL_SEG_SEP=''
fi

# Begin a segment
# Takes two arguments, background and foreground. Both can be omitted,
# rendering default background/foreground.
prompt_segment() {
  local bg fg
  [[ -n $1 ]] && bg="%K{$1}" || bg="%k"
  [[ -n $2 ]] && fg="%F{$2}" || fg="%f"
  if [[ $CURRENT_BG != 'NONE' && $1 != $CURRENT_BG ]]; then
    echo -n " %{$bg%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR%{$fg%} "
  else
    if [[ $1 == $CURRENT_BG ]]; then
      if [[ $CURRENT_BG != "black" ]]; then
        echo -n " %{$bg%}%{%F{black}%}$SAME_COL_SEG_SEP%{$fg%} "
      else
        echo -n " %{$bg%}%{%F{white}%}$SAME_COL_SEG_SEP%{$fg%} "
      fi
    else
      echo -n "%{$bg%}%{$fg%} "
    fi
  fi
  CURRENT_BG=$1
  [[ -n $3 ]] && echo -n $3
}

# End the prompt, closing any open segments
prompt_end() {
  if [[ -n $CURRENT_BG ]]; then
    echo -n " %{%k%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR%{%f%}"
  else
    echo -n "%{%k%f%}"
  fi
  CURRENT_BG=''
}

# Begin an rprompt segment
# Takes two arguments, background and foreground. Both can be omitted,
# rendering default background/foreground.
rprompt_segment() {
  local bg fg
  [[ -n $1 ]] && bg="%K{$1}" || bg="%k"
  [[ -n $2 ]] && fg="%F{$2}" || fg="%f"
  if [[ $CURRENT_BG != 'NONE' && $1 != $CURRENT_BG ]]; then
    echo -n " %{$fg%}$RSEGMENT_SEPARATOR%{$bg%} "
  else
    if [[ $1 == $CURRENT_BG ]]; then
      if [[ $CURRENT_BG != "black" ]]; then
        echo -n " %{$fg%}%{%F{black}%}$RSAME_COL_SEG_SEP%{$bg%} "
      else
        echo -n " %{$fg%}%{%F{white}%}$RSAME_COL_SEG_SEP%{$bg%} "
      fi
    else
      echo -n "%{%F{$1}%}$RSEGMENT_SEPARATOR%{$fg%}%{$bg%} "
    fi
  fi
  CURRENT_BG=$1
  [[ -n $3 ]] && echo -n $3
}

# End the rprompt, closing any open segments
rprompt_end() {
  if [[ -n $CURRENT_BG ]]; then
    echo -n " %{%k%}"
  else
    echo -n "%{%k%}"
  fi
  echo -n "%{%f%}"
  CURRENT_BG=''
}

### Prompt components
# Each component will draw itself, and hide itself if no information needs to be shown

# Context: user@hostname (who am I and where am I)
prompt_context() {
  if [[ "$USER" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
    prompt_segment black default "%(!.%{%F{yellow}%}.)$USER@%m"
  fi
}

# Git: branch/detached head, dirty status
prompt_git() {
  local ref dirty mode repo_path
  repo_path=$(git rev-parse --git-dir 2>/dev/null)

  if $(git rev-parse --is-inside-work-tree >/dev/null 2>&1); then
    dirty=$(parse_git_dirty)
    ref=$(git symbolic-ref HEAD 2> /dev/null) || ref="➦ $(git show-ref --head -s --abbrev |head -n1 2> /dev/null)"
    if [[ -n $dirty ]]; then
      prompt_segment yellow black
    else
      prompt_segment green black
    fi

    if [[ -e "${repo_path}/BISECT_LOG" ]]; then
      mode=" <B>"
    elif [[ -e "${repo_path}/MERGE_HEAD" ]]; then
      mode=" >M<"
    elif [[ -e "${repo_path}/rebase" || -e "${repo_path}/rebase-apply" || -e "${repo_path}/rebase-merge" || -e "${repo_path}/../.dotest" ]]; then
      mode=" >R>"
    fi

    setopt promptsubst
    autoload -Uz vcs_info

    zstyle ':vcs_info:*' enable git
    zstyle ':vcs_info:*' get-revision true
    zstyle ':vcs_info:*' check-for-changes true
    zstyle ':vcs_info:*' stagedstr '✚'
    zstyle ':vcs_info:git:*' unstagedstr '●'
    zstyle ':vcs_info:*' formats ' %u%c'
    zstyle ':vcs_info:*' actionformats ' %u%c'
    vcs_info
    echo -n "${ref/refs\/heads\// }${vcs_info_msg_0_%% }${mode}"
  fi
}

prompt_p4() {
  if $(p4 where >/dev/null 2>&1); then
    prompt_segment green black

    setopt promptsubst
    autoload -Uz vcs_info

    zstyle ':vcs_info:*' enable p4
    zstyle ':vcs_info:*' check-for-changes true
    zstyle ':vcs_info:*' stagedstr '✚'
    zstyle ':vcs_info:*' unstagedstr '●'
    zstyle ':vcs_info:*' formats ' %b%u%c'
    zstyle ':vcs_info:*' actionformats ' %u%c'
    vcs_info
    echo -n "℗${vcs_info_msg_0_%% }"
  fi
}

prompt_hg() {
  local rev status
  if $(hg id >/dev/null 2>&1); then
    if $(hg prompt >/dev/null 2>&1); then
      if [[ $(hg prompt "{status|unknown}") = "?" ]]; then
        # if files are not added
        prompt_segment red white
        st='±'
      elif [[ -n $(hg prompt "{status|modified}") ]]; then
        # if any modification
        prompt_segment yellow black
        st='±'
      else
        # if working copy is clean
        prompt_segment green black
      fi
      echo -n $(hg prompt "☿ {rev}@{branch}") $st
    else
      st=""
      rev=$(hg id -n 2>/dev/null | sed 's/[^-0-9]//g')
      branch=$(hg id -b 2>/dev/null)
      if `hg st | grep -q "^\?"`; then
        prompt_segment red black
        st='±'
      elif `hg st | grep -q "^[MA]"`; then
        prompt_segment yellow black
        st='±'
      else
        prompt_segment green black
      fi
      echo -n "☿ $rev@$branch" $st
    fi
  fi
}

# Dir: current working directory
prompt_dir() {
  prompt_segment blue black '%~'
}

# Virtualenv: current working virtualenv
prompt_virtualenv() {
  local virtualenv_path="$VIRTUAL_ENV"
  if [[ -n $virtualenv_path && -n $VIRTUAL_ENV_DISABLE_PROMPT ]]; then
    prompt_segment cyan black "(`basename $virtualenv_path`)"
  fi
}

# Status:
# - was there an error
# - am I root
# - are there background jobs?
prompt_status() {
  local symbols
  symbols=()
  #[[ $RETVAL -ne 0 ]] && symbols+="%{%F{red}%}✘"
  #[[ $UID -eq 0 ]] && symbols+="%{%F{yellow}%}⚡"
  [[ $(jobs -l | wc -l) -gt 0 ]] && symbols+="%{%F{cyan}%}⚙"

  [[ -n "$symbols" ]] && prompt_segment black default "$symbols"
}

prompt_time() {
  prompt_segment black default "%{$FG[081]%}%D{%H}%{$FG[075]%}%D{%M}%{$FG[069]%}%D{%S}"
}

prompt_date() {
  prompt_segment black default "%{$FG[040]%}%D{%y}%{$FG[034]%}%D{%m}%{$FG[028]%}%D{%d}"
}

prompt_datetime() {
  prompt_segment black default "%{$FG[040]%}%D{%y}%{$FG[034]%}%D{%m}%{$FG[028]%}%D{%d} %{$FG[081]%}%D{%H}%{$FG[075]%}%D{%M}%{$FG[069]%}%D{%S}"
}

convert_secs() {
  ((h=(${1}/1000)/3600))
  ((m=((${1}/1000)%3600)/60))
  ((s=(${1}/1000)%60))
  ((ms=${1}%1000))
  printf "%02d:%02d:%02d.%03d" $h $m $s $ms
}
prompt_timer() {
  local fg
  fg=red
  if [[ $timer_show -gt 60000 ]]; then
    prompt_segment black $fg "◷ $(convert_secs $timer_show)"
  fi
}

prompt_marker() {
  local marker
  local bg fg
  marker=""
  bg=""
  fg=""
  if [[ $UID -eq 0 ]]; then
    marker=" "
    bg=yellow
    fg=black
  else
    marker="$"
    bg=black
    fg=white
  fi
  if [[ $RETVAL -ne 0 ]]; then
    marker="✘"
    fg=red
  fi
  prompt_segment $bg $fg "$marker"
}

## Main prompt
build_preprompt() {
  RETVAL=$?
  prompt_timer
  prompt_time
  prompt_status
  prompt_virtualenv
  #prompt_context
  prompt_dir
  prompt_git
  prompt_p4
  prompt_end
}

## Input-line prompt
build_prompt() {
  RETVAL=$?
  prompt_context
  prompt_marker
  prompt_end
}

print_preprompt() { print -rP '%{%f%b%k%}$(build_preprompt)' }
add-zsh-hook precmd print_preprompt
PROMPT='%{%f%b%k%}$(build_prompt) '

ZLE_RPROMPT_INDENT=0

rprompt_date() {
  rprompt_segment black default
  echo -n "%{$FG[040]%}%D{%y}%{$FG[034]%}%D{%m}%{$FG[028]%}%D{%d}"
}

rprompt_time() {
  rprompt_segment black default
  echo -n "%{$FG[081]%}%D{%H}%{$FG[075]%}%D{%M}%{$FG[069]%}%D{%S}"
}

rprompt_datetime() {
  rprompt_segment black default
  echo -n "%{$FG[040]%}%D{%y}%{$FG[034]%}%D{%m}%{$FG[028]%}%D{%d} %{$FG[081]%}%D{%H}%{$FG[075]%}%D{%M}%{$FG[069]%}%D{%S}"
}

rprompt_timer() {
  local fg
  fg=default
  if [[ $timer_show -gt 60000 ]]; then
    fg=red
  fi
  rprompt_segment black $fg "◷ $(convert_secs $timer_show)"
}


## Right prompt
build_rprompt() {
  rprompt_timer
  rprompt_date
  rprompt_end
}

# Don't bother putting it on the line above for now, there are some cursor position issues
#RPROMPT='%{$(echotc UP 1)%}$(build_rprompt)%{$(echotc DOWN 1)%}'
#RPROMPT='$(build_rprompt)'
