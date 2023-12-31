alias c='echo "control L"'
alias cgb='cargo build'
alias cgr='cargo run -q'
alias cmc='cmake -Bbuild -H. -GNinja'
alias cmb='ninja -Cbuild'
alias t='tmux'
alias tls='tmux ls'
alias g='git'
alias lg='lazygit'
alias lights="$HOME/go/bin/lights"
alias dup="docker compose up --remove-orphans"
alias ddn="docker compose down --remove-orphans"
alias dlg="docker logs -f"
alias drs="docker compose restart"

case $OSTYPE in
    darwin*)
        alias vim='nvim'
        alias f='open -a Finder ./' # opens cd in finder
        alias ls='gls --color=auto -h --group-directories-first'
        alias lt='gls --color=auto -lAtrh --group-directories-first'
        alias la='gls --color=auto -lAh --group-directories-first'
        alias l='gls --color=auto -lh --group-directories-first'
        alias lpo='gstat --printf="%A %a %n\n" *'
        alias nuke-dsstore='find . -name '.DS_Store' -type f -exec rm -vf {} \;'
        alias fast_sshrs='rsync -aHxv --numeric-ids --delete --progress -e "ssh -T -o Compression=no -x"'

        d() {
            cd /Users/ethan/dev/$1;
        }
        compctl -W /Users/ethan/dev/ -/ d
        ;;
    linux*)
        alias ls='ls --color=auto -h --group-directories-first'
        alias lt='ls --color=auto -lAtrh --group-directories-first'
        alias la='ls --color=auto -lAh --group-directories-first'
        alias l='ls --color=auto -lh --group-directories-first'
        alias lpo='stat --printf="%A %a %n\n" *'
        alias fast_sshrs='rsync -aHAXxv --numeric-ids --delete --progress -e "ssh -T -o Compression=no -x"'
        alias hostname='cat /etc/hostname'
        ;;
esac

sshl() {
    local dest="$1"
    shift
    local ports="$@"
    for port in $(echo $ports); do
        local portstring=$(printf "$portstring -L $port\:localhost:$port" | sed 's/\\//g')
    done
    command=$(printf "ssh$portstring $dest")
    eval $command
}

yta() {
    url="$1"
    yt-dlp -x --audio-format wav "$url"
}

ytd() {
    url="$1"
    yt-dlp -x --audio-format wav -o "%(id)s.%(ext)s" "$url" && open -a "Reason 11" output.wav
}


# vim tmux session
v() {
    # auto-source python venv
    [ -d "venv" ] && . venv/bin/activate

    # start session
    name="vim-$(basename "${PWD##*/.}")"
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
    source venv/bin/activate &&
    tmux set-environment VIRTUAL_ENV $VIRTUAL_ENV
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

# ffmpeg flat convert
ffc() {
    filename=$(basename -- "$1")
    filename="${filename%.*}"
    ffmpeg -i "$1" -b:a 320k "${filename}.mp4"
}

# ffmpeg twitter convert
fftw() {
    filename=$(basename -- "$1")
    filename="${filename%.*}"
    ffmpeg -i "$1" -c:v libx264 -crf 20 -preset slow -vf format=yuv420p -c:a aac -movflags +faststart "${filename}.mp4"
}