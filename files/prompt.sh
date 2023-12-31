function remote_hostname() {
    if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
        echo "$(tput setaf 4)🌐 $(hostname)$(tput sgr0) in "
    fi
}

PS1="$(remote_hostname)$(tput setaf 6)%1/$(tput sgr0)$(tput setaf 2) ❯$(tput sgr0) "