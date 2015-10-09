# times every command, and makes the execution time available for the next prompt
# to display, print $timer_show somewhere in your prompt

zmodload zsh/datetime

function preexec()
{
    timer=$EPOCHREALTIME
}

function precmd()
{
    # timer_show is in milliseconds
    timer_show=$((($EPOCHREALTIME - ${timer:=$EPOCHREALTIME}) * 1000))
    unset timer
}
