#!/bin/bash

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# I want coredump :)
ulimit -c unlimited

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
HISTCONTROL=$HISTCONTROL${HISTCONTROL+:}ignoredups
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

shopt -s cdspell                # autocorrects cd misspellings
shopt -s nocaseglob             # pathname expansion will be treated
                                # as case-insensitive

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

if [ -f /usr/local/share/gtags/globash.rc ]; then
    alias globash='. /usr/local/share/gtags/globash.rc'
fi

# export MAKEFLAGS='-j 2'
export FIGNORE=".o:~"
# Emacs en mode serveur - client
export ALTERNATE_EDITOR=""	# If not running start Emacs server
alias emacs='emacs -nw -Q'
# alias ne='emacsclient -t'
# Emacs
# ne () {
#     EMACSVERSION="$(emacs --version | head -1)"
#     printf "\033]2;$EMACSVERSION\007\r";
#     if [ $TERM = "rxvt-unicode" ] ; then
#	  env TERM="rxvt" emacsclient -t $*
#     else
#	emacsclient -t $*
#     fi
# }
if [ $TERM = "rxvt-unicode" ] ; then
    alias ne='env TERM="rxvt" emacsclient -t'
elif [ $TERM = "xterm" ] ; then
    # Fix S-<up>
    alias ne='env TERM="xterm-vt220" emacsclient -t'
else
    alias ne='emacsclient -t'
fi

# Open Org-Mode files with completion
alias org='ne'
complete -o dirnames -f -X '!*.org' org

export EDITOR='emacsclient -t'

export PAGER=less

alias re='make clean ; make'
alias lynx='lynx -accept_all_cookies'

# Complete .pdf and directory
complete -o dirnames -f -X '!*.pdf' zathura evince xpdf

bind 'set match-hidden-files off'

alias reload='. ~/.bashrc'
export GREP_COLORS='mt=01;34:fn=01;34:ln=04;31:bn=30:se=33'
alias grep='grep --color=auto'

alias ls='ls -F --color=auto --hide="*~"'
alias ll='ls -sh1'
alias lh='ls -sh1'
alias df='df -h'
alias du='du -h'
alias la='ls -a'
alias j='jobs'
alias cp='cp -v'
alias randr='xrandr --output PANEL --mode 1680x1050 --output VGA_1 --mode 1280x1024 --right-of PANEL ; sleep 1 ; nitrogen --restore'
alias randr2='xrandr --output LVDS --mode 1680x1050 --output VGA-0 --mode 1280x1024 --right-of LVDS ; sleep 1 ; nitrogen --restore'
alias offrandr='xrandr --output VGA_1 --off'
alias bc='bc -lq'

# Dired like alias :)
alias +='mkdir'
alias D='rm -I'

clean()
{
    SEARCH='.'
    if [ ${1} ]
    then
	SEARCH=${1}
    fi
    find ${SEARCH} \( -name "*~" -or -name ".*~" -or -name "*\#" -or -name "core" -or -name "*.core" \) -exec rm -fv {} \;
}

# Easy extract
extract () {
  if [ -f $1 ] ; then
      case $1 in
	  *.tar.bz2)   tar xvjf "$*"	;;
	  *.tar.gz)    tar xvzf "$*"	;;
	  *.bz2)       bunzip2 "$*"	;;
	  *.rar)       unrar x "$*"	;;
	  *.gz)	       gunzip "$*"	;;
	  *.tar)       tar xvf "$*"	;;
	  *.tbz2)      tar xvjf "$*"	;;
	  *.tgz)       tar xvzf "$*"	;;
	  *.zip)       unzip "$*"	;;
	  *.Z)	       uncompress "$*"	;;
	  *.7z)	       7z x "$*"	;;
	  *)	       echo "don't know how to extract '"$*"'..." ;;
      esac
  else
      echo "'$*' is not a valid file!"
  fi
}

if [ "$SHELL" != "dumb" ] ; then
    LS_COLORS='rs=0:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.lzma=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.rar=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.axv=01;35:*.anx=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*akefile=01;34:*.c=00;31:*.org=00;33:*.lua=00;34:*.cpp=00;31:*.cc=00;31:*.o=00;34:*.oga=00;36:*.spx=00;36:*.h=00;32:*.hh=00;32:*.hpp=00;32:';
    export LS_COLORS
fi

# Bash Color
txtblk='\033[0;30m' # Black - Regular
txtred='\033[0;31m' # Red
txtgrn='\033[0;32m' # Green
txtylw='\033[0;33m' # Yellow
txtblu='\033[0;34m' # Blue
txtpur='\033[0;35m' # Purple
txtcyn='\033[0;36m' # Cyan
txtwht='\033[0;37m' # White
bldblk='\033[1;30m' # Black - Bold
bldred='\033[1;31m' # Red
bldgrn='\033[1;32m' # Green
bldylw='\033[1;33m' # Yellow
bldblu='\033[1;34m' # Blue
bldpur='\033[1;35m' # Purple
bldcyn='\033[1;36m' # Cyan
bldwht='\033[1;37m' # White
unkblk='\033[4;30m' # Black - Underline
undred='\033[4;31m' # Red
undgrn='\033[4;32m' # Green
undylw='\033[4;33m' # Yellow
undblu='\033[4;34m' # Blue
undpur='\033[4;35m' # Purple
undcyn='\033[4;36m' # Cyan
undwht='\033[4;37m' # White
bakblk='\033[40m'   # Black - Background
bakred='\033[41m'   # Red
badgrn='\033[42m'   # Green
bakylw='\033[43m'   # Yellow
bakblu='\033[44m'   # Blue
bakpur='\033[45m'   # Purple
bakcyn='\033[46m'   # Cyan
bakwht='\033[47m'   # White
txtrst='\033[0m'    # Text Reset

PS1="\[$txtred\]\u\[$txtgrn\] ~/\[$txtylw\]\W > \[$txtrst\]"

search ()
{
    SEARCH="."
    if [ $# = 0 ]
    then
	echo -e "Usage: search PATTERN [DIRECTORY]"
    else
	if [ $# = 2 ]
	then
	    SEARCH=${2}
	fi

	# grep --color=always -nI ${1} `find ${SEARCH} -type f 2>/dev/null` 2>/dev/null |\
	grep --color=always -nI ${1} `find ${SEARCH} -type f ` |\
	grep '\'${SEARCH} |\
	# grep '^\'${SEARCH} |\
	grep -v '/\.' |\
	awk -F: ' {print "\033[1m\033[7;33m"$2 "\033[0;34m" "\033[3m\033[1m " $1 "\033[0;31m \033[3m\n\t" $3"\033[0;39m"}'
	# awk -F: ' {print "\033[1m\033[7;33m"$2 "\033[0;39m" "\033[3m\033[1m " $1 "\033[0;31m \033[3m\n\t" $3"\033[0;39m"}'
    fi
}

# TTY Colors
if [ "$TERM" = "linux" ]; then
    echo -en "\e]P0222222" #black
    echo -en "\e]P8222222" #darkgrey
    echo -en "\e]P1803232" #darkred
    echo -en "\e]P9982b2b" #red
    echo -en "\e]P25b762f" #darkgreen
    echo -en "\e]PA89b83f" #green
    echo -en "\e]P3aa9943" #brown
    echo -en "\e]PBefef60" #yellow
    echo -en "\e]P4324c80" #darkblue
    echo -en "\e]PC2b4f98" #blue
    echo -en "\e]P5706c9a" #darkmagenta
    echo -en "\e]PD826ab1" #magenta
    echo -en "\e]P692b19e" #darkcyan
    echo -en "\e]PEa1cdcd" #cyan
    echo -en "\e]P7ffffff" #lightgrey
    echo -en "\e]PFdedede" #white
    clear		   #for background artifacting
fi
