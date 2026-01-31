[ -n "$ZSH_VERSION" ] && {
    precmd() {
        local _git=$(git symbolic-ref HEAD 2> /dev/null | awk 'BEGIN{FS="/"} {print $NF}')
        PROMPT=''
        if [[ $_git == "" ]]; then
            PROMPT+="%F{blue}%3~ "
        else
            PROMPT+="%F{blue}%1d "
            PROMPT+="%F{magenta}${_git} "
        fi
        PROMPT+='%(?.%F{green}.%F{red})%(!.#.$)%f '
    }
}

[ -n "$BASH_VERSION" ] && {
    __prompt_command() {
        local _exit="$?"
        local _green="\[$(tput setaf 2)\]"
        local _blue="\[$(tput setaf 4)\]"
        local _red="\[$(tput setaf 1)\]"
        local _purple="\[$(tput setaf 5)\]"
        local _reset="\[$(tput sgr0)\]"
        local _git=$(git symbolic-ref HEAD 2> /dev/null | awk 'BEGIN{FS="/"} {print $NF}')

        PS1=''
        if [[ $_git == "" ]]; then
            PS1+="${_blue}"
            PS1+="${PWD#"${PWD%/*/*/*}/"} "
            PS1+="${_reset}"
        else
            PS1+="${_blue}"
            PS1+="${PWD#"${PWD%/*}/"} "
            PS1+="${_reset}"
            PS1+="${_purple}"
            PS1+="$_git "
            PS1+="${_reset}"
        fi

        if [ $_exit != 0 ]; then
            PS1+="${_red}\$${_reset} "
        else
            PS1+="${_green}\$${_reset} "
        fi
    }

    PROMPT_COMMAND=__prompt_command
}
