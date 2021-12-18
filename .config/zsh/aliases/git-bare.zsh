# GIT-BARE ALIASES (for .dotfiles)

alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias ca='config add'
alias ccm='config commit -v'
alias ccm!='config commit -v --amend'
alias ccma='config commit -v -a'
alias ccmam='config commit -v -a -m'
alias cdiff='config diff'
alias cmv='config mv'
alias cpull='config pull --recurse-submodules -v'
alias cpush='config push -v'
alias cs='config status -s'
alias csu='config submodule update --remote --merge'
alias cup='config pull --rebase -v'
function csa() { config submodule add ssh://git@github.com/"$*" }

# lazy updates
alias cpac='config commit ~/.config/pkglist-pacman.txt -m "Update pacman package list"'
alias cyay='config commit ~/.config/pkglist-yay.txt -m "Update yay package list"'
alias ccv='config commit ~/.config/vim -m "Update Vim module"'
