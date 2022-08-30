#!/bin/zsh


############################# DEFAULT FZF COLORS/CMD  ###############################


# export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
# --color fg:#ebdbb2,bg:#282828,hl:#fabd2f,fg+:#ebdbb2,bg+:#3c3836,hl+:#fabd2f
# --color info:#98971a,prompt:#458588,spinner:#fabd2f,pointer:#83a598,marker:#fe8019,header:#665c54
# --color border:#ea6962 
# --layout=reverse'

# morhetz/gruvbox
export FZF_DEFAULT_OPTS='
--color fg:#ebdbb2,bg:#282828,hl:#928374,fg+:#ebdbb2,bg+:#3c3836,hl+:#fb4934
--color info:#8ec07c,prompt:#fb4934,spinner:#fb4934,pointer:#83a598,marker:#fe8019,header:#928374
--color border:#ea6962 
--layout=reverse'


export FZF_DEFAULT_COMMAND="find -type f"





###################### COPY/SLIGHT MOD OF /usr/share/fzf/keybindings.zsh##############
__fzfcmd() {
  [ -n "$TMUX_PANE" ] && { [ "${FZF_TMUX:-0}" != 0 ] || [ -n "$FZF_TMUX_OPTS" ]; } &&
    echo "fzf-tmux ${FZF_TMUX_OPTS:--d${FZF_TMUX_HEIGHT:-40%}} -- " || echo "fzf"
}


{

fzf-cd-widget() {
  local cmd="${FZF_CTLR_T_COMMAND:-"command find -L . -mindepth 1 \\( -path -o -fstype 'sysfs' -o -fstype 'devfs' -o -fstype 'devtmpfs' -o -fstype 'proc' \\) -prune \
    -o -type d -print 2> /dev/null | cut -b3-"}"
  setopt localoptions pipefail no_aliases 2> /dev/null
  local dir="$(eval "$cmd" | FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} --reverse --bind=ctrl-z:ignore $FZF_DEFAULT_OPTS $FZF_CTLR_T_OPTS" $(__fzfcmd) +m)"
  if [[ -z "$dir" ]]; then
    zle redisplay
    return 0
  fi
  zle push-line # Clear buffer. Auto-restored on next prompt.
  # BUFFER="cd -- ${(q)dir}"
  BUFFER="cd ${(q)dir}"
  zle accept-line
  local ret=$?
  unset dir # ensure this doesn't end up appearing in prompt expansion
  zle reset-prompt
  return $ret
}
zle     -N    fzf-cd-widget
bindkey '' fzf-cd-widget


fzf_editor_widget() {
  local cmd="${FZF_CTLR_A_COMMAND:-"command find -L . -mindepth 1 \\( -path -o -fstype 'sysfs' -o -fstype 'devfs' -o -fstype 'devtmpfs' -o -fstype 'proc' \\) -prune \
    -o -type f -print 2> /dev/null | cut -b3-"}"
  setopt localoptions pipefail no_aliases 2> /dev/null
  local file="$(eval "$cmd" | FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} --reverse --bind=ctrl-z:ignore $FZF_DEFAULT_OPTS $FZF_CTLR_A_OPTS" $(__fzfcmd) +m)"
  if [[ -z "$file" ]]; then
    zle redisplay
    return 0
  fi
  zle push-line # Clear buffer. Auto-restored on next prompt.
  BUFFER="vim -- ${(q)file}"
  zle accept-line
  local ret=$?
  unset file # ensure this doesn't end up appearing in prompt expansion
  zle reset-prompt
  return $ret
}
zle	-N	fzf_editor_widget
bindkey ''	fzf_editor_widget



# CTRL-R - Paste the selected command from history into the command line
fzf-history-widget() {
  local selected num
  setopt localoptions noglobsubst noposixbuiltins pipefail no_aliases 2> /dev/null
  selected=( $(fc -rl 1 | perl -ne 'print if !$seen{(/^\s*[0-9]+\**\s+(.*)/, $1)}++' |
    FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} $FZF_DEFAULT_OPTS -n2..,.. --tiebreak=index --bind=ctrl-r:toggle-sort,ctrl-z:ignore $FZF_CTRL_R_OPTS --query=${(qqq)LBUFFER} +m" $(__fzfcmd)) )
  local ret=$?
  if [ -n "$selected" ]; then
    num=$selected[1]
    if [ -n "$num" ]; then
      zle vi-fetch-history -n $num
    fi
  fi
  zle reset-prompt
  return $ret
}
zle     -N   fzf-history-widget
bindkey '^R' fzf-history-widget

} always {
  eval $__fzf_key_bindings_options
  'unset' '__fzf_key_bindings_options'
}










#################### EXTRA COMMANDS I MIGHT DO SOMETHING WITH #######################



# fkill - kill process
fkill() {
  local pid
  pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

  if [ "x$pid" != "x" ]
  then
    echo $pid | xargs kill -${1:-9}
  fi
}
alias kill=pkill

fmpc() {
  local song_position
  song_position=$(mpc -f "%position%) %artist% - %title%" playlist | \
    fzf-tmux --query="$1" --reverse --select-1 --exit-0 | \
    sed -n 's/^\([0-9]\+\)).*/\1/p') || return 1
  [ -n "$song_position" ] && mpc -q play $song_position
}


