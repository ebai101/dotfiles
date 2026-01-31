alias cgb='cargo build'
alias cgr='cargo run -q'
alias cmc='cmake -Bbuild -H. -GNinja'
alias cmb='ninja -Cbuild'
alias t='tmux'
alias tls='tmux ls'
alias g='git'
alias lg='lazygit'
alias dup="docker compose up --remove-orphans"
alias dupd="docker compose up --remove-orphans -d && docker compose logs -f"
alias drc="docker compose up -d --remove-orphans --force-recreate"
alias ddn="docker compose down --remove-orphans"
alias dlg="docker logs -f"
alias drs="docker compose restart"
alias dcp="docker compose pull"
alias openports='sudo lsof -PiTCP -sTCP:LISTEN'
alias k='kubectl'

case $OSTYPE in
    darwin*)
        alias c='arr=(`find ./ -maxdepth 1 -name "*.code-workspace"`); if [ ${#arr[@]} -gt 0 ]; then open ${arr[1]}; else; code .; fi'
        alias vim='nvim'
        alias f='open -a Finder ./'
        alias ls='gls --color=auto -h --group-directories-first'
        alias lt='gls --color=auto -lAtrh --group-directories-first'
        alias la='gls --color=auto -lAh --group-directories-first'
        alias l='gls --color=auto -lh --group-directories-first'
        alias lpo='gstat --printf="%A %a %n\n" *'
        alias nuke-dsstore='find . -name '.DS_Store' -type f -exec rm -vf {} \;'
        alias fast-sshrs='rsync -aHxv --numeric-ids --delete --progress -e "ssh -T -o Compression=no -x"'


        if [ -n "$ZSH_VERSION" ]; then
            d() {
                cd /Users/ethan/dev/$1;
            }
            compctl -W /Users/ethan/dev/ -/ d
        fi
        ;;
    linux*)
        alias ls='ls --color=auto -h --group-directories-first'
        alias lt='ls --color=auto -lAtrh --group-directories-first'
        alias la='ls --color=auto -lAh --group-directories-first'
        alias l='ls --color=auto -lh --group-directories-first'
        alias lpo='stat --printf="%A %a %n\n" *'
        alias fast-sshrs='rsync -aHAXxv --numeric-ids --delete --progress -e "ssh -T -o Compression=no -x"'
        alias hostname='cat /etc/hostname'
        ;;
esac


# ssh w/ port forwarding from args
# e.g. `ssh 8080 9000` forwards 8080 and 9000 to localhost
sshl() {
    local dest ports portstring command

    dest="$1"
    shift
    ports="$@"
    for port in $(echo $ports); do
        portstring=$(printf "$portstring -L $port\:localhost:$port" | sed 's/\\//g')
    done
    command=$(printf "ssh$portstring $dest")
    eval $command
}

# youtube-dl audio as wav
yta() {
    local url="$1"
    yt-dlp -x --audio-format wav "$url"
}

# create vim tmux session
# vim tab 1, shell tab 2, lazygit tab 3
v() {
    # auto-source python venv
    [ -d "venv" ] && . venv/bin/activate

    # start session
    local name="vim-$(basename "${PWD##*/.}")"
    tmux new-session -Ads "$name"
    tmux set-environment VIRTUAL_ENV $VIRTUAL_ENV
    tmux new-window -t "$name:2"
    tmux new-window -t "$name:3"

    # open apps
    tmux send-keys -t "$name:1" "vim" Enter
    tmux send-keys -t "$name:3" "lg" Enter

    # attach
    tmux select-window -t "$name:1"
    tmux attach -t "$name"
}

# smart tmux attach
ta() {
    if [ -z "$1" ]; then tmux attach; else tmux attach -t $1; fi
}

# smart tmux kill-session
tk() {
    if [ -z "$1" ]; then tmux kill-session; else tmux kill-session -t $1; fi
}

# source virtualenv
sv() {
    local venv_dirs=("venv" ".venv" "env" ".env" ".python-venv")
    local found=0
    if [[ -n "$VIRTUAL_ENV" ]]; then
        echo "Already in virtual environment: $VIRTUAL_ENV"
        return 0
    fi
    for vdir in "${venv_dirs[@]}"; do
        if [[ -f "./$vdir/bin/activate" ]]; then
            source "./$vdir/bin/activate"
            tmux set-environment VIRTUAL_ENV $VIRTUAL_ENV
            found=1
            break
        fi
    done
    if [[ $found -eq 0 ]]; then
        local current_dir="$PWD"
        while [[ "$current_dir" != "/" ]]; do
            for vdir in "${venv_dirs[@]}"; do
                if [[ -f "$current_dir/$vdir/bin/activate" ]]; then
                    source "$current_dir/$vdir/bin/activate"
                    tmux set-environment VIRTUAL_ENV $VIRTUAL_ENV
                    found=1
                    break 2
                fi
            done
            current_dir=$(dirname "$current_dir")
        done
    fi
    if [[ $found -eq 0 ]]; then
        echo "No virtual environment found"
        return 1
    fi
}

# load nvm (slow)
nvm_init() {
    export NVM_DIR="$HOME/.nvm"
    # shellcheck source=/dev/null
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    # shellcheck source=/dev/null
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
}

# load pyenv and pyenv-virtualenv (slow)
pyenv_init() {
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
}

# get pid of process listening on a port
pidport() {
    sudo lsof -n -i4TCP:$1 | grep LISTEN
}

# capture process output
capture() {
    sudo dtrace -p "$1" -qn '
        syscall::write*:entry
        /pid == $target && arg0 == 1/ {
            printf("%s", copyinstr(arg1, arg2));
        }
    '
}

# ffmpeg basic convert
ffc() {
    local filename
    filename=$(basename -- "$1")
    filename="${filename%.*}"
    ffmpeg -i "$1" -b:a 320k "${filename}.mp4"
}

# ffmpeg twitter convert
fftw() {
    local filename
    filename=$(basename -- "$1")
    filename="${filename%.*}"
    ffmpeg -i "$1" -c:v libx264 -crf 20 -preset slow -vf format=yuv420p -c:a aac -movflags +faststart "${filename}.mp4"
}
