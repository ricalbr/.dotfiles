### ALIASES

# GNU and BSD (macOS) ls flags aren't compatible
ls --version &>/dev/null
if [ $? -eq 0 ]; then
  lsflags="--color --group-directories-first -F"
else
  lsflags="-GF"
  export CLICOLOR=1
fi

# Basic aliases
alias ls="ls ${lsflags}"
alias ll="ls ${lsflags} -lh"
alias la="ls ${lsflags} -lah"
alias nnn='n'
alias h="history"
alias hg="history -1000 | grep -i"

# navigation
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

# confirm before overwriting something
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
fucntion mvf() { mv "$(fzf)" "$*" }

# adding flags
alias df='df -h'        # human-readable sizes
alias free='free -m'    # show sizes in MB

# typo
alias claer='clear'
alias sl='ls'
alias al='la'
alias dc='cd'

# useful programs
alias sz='source $ZDOTDIR/.zshrc'
alias node='nodejs'
alias tmux='tmux -f ~/.config/tmux/.tmux.conf'
alias vim='nvim'
alias fvim='vim $(fzf)'
alias ytdl='youtube-dl'
alias yarn='yarn --use-yarnrc "$XDG_CONFIG_HOME/yarn/yarnrc"'
alias vscodium='vscodium --extensions-dir "$XDG_DATA_HOME"/vscode/extensions'

# GIT
# Do this: git config --global url.ssh://git@github.com/.insteadOf https://github.com
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias ca='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME add'
alias ccm='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME commit'
alias cdiff='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME diff'
alias cpull='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME pull'
alias cpush='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME push'
alias cs='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME status'
alias cu='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME submodule update --remote --merge'
alias cyay='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME commit ~/.config/pkglist-yay.txt -m "Update yay package list"'
alias cpac='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME commit ~/.config/pkglist-pacman.txt -m "Update pacman package list"'
alias ga='git add'
alias gb='git branch'
alias gc='git commit'
alias gd='git diff'
alias gp='git push'
alias gs='git status 2>/dev/null'
alias pull='git pull --recurse-submodules'
function gcl() { git clone ssh://git@github.com/"$*" }
function gsa() { git submodule add ssh://git@github.com/"$*" }
function gg() { git commit -am "$*" }

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
