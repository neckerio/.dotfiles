# The following lines were added by compinstall

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' expand suffix
zstyle ':completion:*' format '`Completing %d'\'''
zstyle ':completion:*' group-name ''
zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-suffixes true
zstyle ':completion:*' matcher-list '+' 'm:{[:lower:]}={[:upper:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|[._-]=** r:|=**'
zstyle ':completion:*' menu select=1
zstyle ':completion:*' original true
zstyle ':completion:*' preserve-prefix '//[^/]##/'
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
zstyle ':completion:*' use-compctl true
zstyle ':completion:*' verbose true
zstyle :compinstall filename '~/.zshrc'

# loads .zfunc, for Rust tab completion
fpath+=~/.zfunc

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd extendedglob
unsetopt beep
# End of lines configured by zsh-newuser-install

# add tab complete to include dot files
_comp_options+=(globdots)


# Enable colors
autoload -U colors && colors

# Vi-mode && Use Vim keys in tab-complete menu && make Backspace delete beyond insert character
bindkey -v
zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M viins '^?' backward-delete-char
bindkey -M viins '^H' backward-delete-char


# ls colors
LS_COLORS='*.pdf=01;96:*.md=01;32:rs=0:di=01;31:ln=01;93:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;36:*.tgz=01;36:*.arc=01;36:*.arj=01;36:*.taz=01;36:*.lha=01;36:*.lz4=01;36:*.lzh=01;36:*.lzma=01;36:*.tlz=01;36:*.txz=01;36:*.tzo=01;36:*.t7z=01;36:*.zip=01;36:*.z=01;36:*.dz=01;36:*.gz=01;36:*.lrz=01;36:*.lz=01;36:*.lzo=01;36:*.xz=01;36:*.zst=01;36:*.tzst=01;36:*.bz2=01;36:*.bz=01;36:*.tbz=01;36:*.tbz2=01;36:*.tz=01;36:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;36:*.rz=01;36:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;94:*.mpg=01;94:*.mpeg=01;94:*.m2v=01;94:*.mkv=01;94:*.webm=01;94:*.webp=01;94:*.ogm=01;94:*.mp4=01;94:*.m4v=01;94:*.mp4v=01;94:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;94:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;94:*.avi=01;94:*.fli=01;35:*.flv=01;94:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;94:*.m4a=00;94:*.mid=00;36:*.midi=00;36:*.mka=00;94:*.mp3=00;94:*.mpc=00;94:*.ogg=00;36:*.ra=00;36:*.wav=00;94:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:'; 
export LS_COLORS

# Aliases for builtin colored output
alias ls='ls --color=auto'
alias ll='ls -lah --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias pgrep='pgrep --color=auto'

cd_ls (){
	declare CHANGE_DIR="cd"
	DIRECTORY="$1"
	$CHANGE_DIR $DIRECTORY && ls
}
alias cd='cd_ls'

alias awk='gawk'

# Use viman script for man
alias man='viman'

# set up xterm-256 for Terminfo during ssh. This is needed for alacritty to work properly. Below is a oneliner that can be installed on a remote server
# $ toe -a (to see terminfo)

# wget https://raw.githubusercontent.com/alacritty/alacritty/master/extra/alacritty.info && tic -xe alacritty,alacritty-direct alacritty.info && rm alacritty.info 
alias ssh='TERM=xterm-256color ssh'

# Vim
export EDITOR=vim

# Opener to vim, to stop LF from opening every goddamn thing in a browser
export OPENER=vim

# add bin to path
export PATH=$PATH:~/bin

# add XDG_CONFIG_HOME
export XDG_CONFIG_HOME=~/.config

# nnn env vars
# source ~/.config/nnn/nnn.config

# ZSH-SYNTAX-HIGHLIGHTING
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# LF config
source ~/.config/lf/lfrc 2> /dev/null
source ~/.config/lf/iconslf 2> /dev/null


# FZF Keybindings, colors, cmdline CTRL-T/A/R, completions and extras
source ~/.config/fzf/fzf_mods.sh
source /usr/share/fzf/completion.zsh

# Prompt
# Autoload zsh add-zsh-hook and vcs_info functions (-U autoload w/o substition, -z use zsh style)
autoload -Uz add-zsh-hook vcs_info
# Enable substitution in the prompt.
setopt prompt_subst
# Run vcs_info just before a prompt is displayed (precmd)
add-zsh-hook precmd vcs_info
# add ${vcs_info_msg_0} to the prompt
# e.g. here we add the Git information in red
PROMPT='%1~ %F{red}${vcs_info_msg_0_}%f %# '
PS1='%U%F{blue}[%n@%m]%f%u%F{red}%~%f%B%F{white}%f%b %F{yellow}${vcs_info_msg_0_}%f:: '

# Enable checking for (un)staged changes, enabling use of %u and %c
zstyle ':vcs_info:*' check-for-changes true
# Set custom strings for an unstaged vcs repo changes (*) and staged changes (+)
zstyle ':vcs_info:*' unstagedstr ' *'
zstyle ':vcs_info:*' stagedstr ' +'
# Set the format of the Git information for vcs_info
zstyle ':vcs_info:git:*' formats       '(%b%u%c)'
zstyle ':vcs_info:git:*' actionformats '(%b|%a%u%c)'
