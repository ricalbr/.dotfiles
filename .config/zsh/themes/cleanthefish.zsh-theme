# load version control information
autoload -Uz vcs_info
precmd() { vcs_info }

# format the vcs_info_msg_0_ variable
zstyle ':vcs_info:git:*' formats ' %b'

# PROMPT BASICS
PROMPT='%F{green}%<\s< $(prompt_dir)%(?.%F{white}.%F{red})%B $%b '
RPROMPT='%F{magenta}%B$(python_env_info)%b%f%B$(parse_git_dirty)${vcs_info_msg_0_}%f%b'

# GIT PROMPT
ZSH_THEME_GIT_PROMPT_DIRTY="%F{red}"
ZSH_THEME_GIT_PROMPT_CLEAN="%F{green}"

# checks if working tree is dirty
parse_git_dirty() {
  # ref=$(git symbolic-ref HEAD 2> /dev/null)
  if [[ -n $(git status -s --ignore-submodules=dirty 2> /dev/null) ]]; then
    echo "$ZSH_THEME_GIT_PROMPT_DIRTY"
  else
    echo "$ZSH_THEME_GIT_PROMPT_CLEAN"
  fi
}

# Python virtual environment info
export VIRTUAL_ENV_DISABLE_PROMPT=1 # do not add anything to the prompt
function python_env_info() {
    if [[ -n "$VIRTUAL_ENV" ]]; then
        # Extract the environment name from the path
        local env_name=$(basename "$VIRTUAL_ENV")
        echo " (${env_name}) "
    fi
}

prompt_dir() {
    # Get the path from home, root, or git repo to the working directory
    if [ -d .git ]; then
        # If the current directory is the top level of a git repo,
        # just add the name of the repo to the prompt and exit.
        print -Pn "  $(basename $(pwd))"
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
        local shrunken_path="  $(basename $git_toplevel)$shrunken_path"
    fi

    # Draw the prompt
    print -Pn "$shrunken_path"
}
