# PROMPT BASICS
PROMPT='%{$fg[green]%}%<\s< $(prompt_dir)%(?.%{$fg[white]%}.%{$fg[red]%})%B $%b '
RPROMPT='%{$fg[green]%}%B$(conda_info)%b$(git_prompt_info)%(?:%{$fg_bold[white]%}:%{$fg_bold[red]%})'

# GIT PROMPT
function git_prompt_info() {
  local ref
  if [[ "$(command git config --get oh-my-zsh.hide-status 2>/dev/null)" != "1" ]]; then
    ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
    ref=$(command git rev-parse --short HEAD 2> /dev/null) || return 0
    echo "$(parse_git_dirty)${ref#refs/heads/}"
  fi
}

ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%}"

# CONDA
function conda_info() {
    if [[ -n "$CONDA_DEFAULT_ENV" ]]; then
        echo " (${CONDA_DEFAULT_ENV}) "
    fi
}

prompt_dir() {
    # Get the path from home, root, or git repo to the working directory
    if [ -d .git ]; then
        # If the current directory is the top level of a git repo,
        # just add the name of the repo to the prompt and exit.
        print -Pn "$(basename $(pwd))"
        return 0
    elif $(git rev-parse > /dev/null 2>&1); then
        # If we're in a git repo, get the path from the top of the repo to the
        # working directory.
        local abs_path_=$(pwd)
        local git_toplevel="$(git rev-parse --show-toplevel)"
        local path_=${abs_path_#$git_toplevel}
    else
        # If we aren't in a git repo, get the path from either root or home to
        # the working directory.
        local abs_path_=$(pwd)
        local path_=${abs_path_#$HOME}

        if [[ $abs_path_ != $path_ ]]; then
            local path_="~/$path_"
        else
            local from_root=1
        fi
    fi

    # Shorten the path by truncating each directory (except the current one) to
    # only one letter.
    local path_as_array=(${(s:/:)path_})  # Split the path at forward slashes
    local length_of_path=${#path_as_array[@]}
    local shrunken_path=""
    if [[ $length_of_path != 0 ]]; then
        for i in {1..$length_of_path}; do
            if [[ $i != 1 || $git_toplevel ]]; then
                # Add a separating slash
                shrunken_path+="/"
            fi

            # Truncate the dir name to the first letter, unless it is the
            # current dir
            if [[ $i != $length_of_path ]]; then
                local elem="$path_as_array[$i]"
                shrunken_path+="${elem[0,1]}"
            else
                local elem="$path_as_array[$i]"
                shrunken_path+="$elem"
            fi
        done
    fi

    if [[ $from_root ]]; then
        local shrunken_path="/"$shrunken_path
    elif [[ $git_toplevel ]]; then
        local shrunken_path="$(basename $git_toplevel)$shrunken_path"
    fi

    # Draw the prompt
    print -Pn "$shrunken_path"
}
