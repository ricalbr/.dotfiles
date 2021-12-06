### ALIASES

# GNU and BSD (macOS) ls flags aren't compatible
ls --version &>/dev/null
if [ $? -eq 0 ]; then
  lsflags="--color --group-directories-first -F"
else
  lsflags="-GF"
  export CLICOLOR=1
fi

# edit config and environment
alias ec="$EDITOR $ZDOTDIR/.zshrc"
alias ee="$EDITOR $HOME/.zshenv"
alias sz="source $ZDOTDIR/.zshrc"

# basic aliases
alias ls="ls ${lsflags}"
alias ll="ls ${lsflags} -lh"
alias la="ls ${lsflags} -lah"
alias h="history"
alias hg="history -1000 | grep -i"
alias ping="ping -c 5"                  # ping stops after 5 requests
alias df='df -h'                        # human-readable sizes
alias free='free -m'                    # show sizes in MB
alias treed='tree -A -C -d'             # print only directories
alias treel='tree -A -C -L'             # use level flag

# navigation
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

# confirm before overwriting something
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -iv'
alias mkdir='mkdir -pv'

# fix typo
alias claer='clear'
alias sl='ls'
alias al='la'
alias dc='cd'

# useful programs
alias node='nodejs'
alias tmux='tmux -f ~/.config/tmux/.tmux.conf'
alias vim='nvim'
alias vimf='vim $(fzf)'
alias ytdl='youtube-dl'
alias yarn='yarn --use-yarnrc "$XDG_CONFIG_HOME/yarn/yarnrc"'
alias vscodium='vscodium --extensions-dir "$XDG_DATA_HOME"/vscode/extensions'

# git aliases
source $ZDOTDIR/aliases/git.zsh
source $ZDOTDIR/aliases/git-bare.zsh

# suckless programs aliases
alias fullclean='git checkout master && make clean && rm -f config.h && git reset --hard origin/master'
alias configinstall='git checkout master && rm -f config.h && make && sudo make clean install'

# quick fixes
alias setkeyb='setxkbmap -model pc104 -layout it -variant ,qwerty -option grp:alt_shift_toggle'
alias resetaudio='systemctl --user restart pulseaudio'
# alias dwdrive='rclone -P sync GoogleDrive: ~/Drive/'
# alias updrive='rclone -P sync ~/Drive/ GoogleDrive:'
alias onesync='onedrive --synchronize'
alias dwone='onedrive --synchronize --download-only'
alias upone='onedrive --synchronize --upload-only'
alias extback='dconf dump /org/gnome/shell/extensions/ > ~/.config/extensions_backup.txt'
alias gnomeback='dconf dump /org/gnome/> ~/.config/gnome_backup.txt'

# functions
function mk () { mkdir -p "$@" && cd "$@" }
