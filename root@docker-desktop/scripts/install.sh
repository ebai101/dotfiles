#!/usr/bin/env bash

wget -O ~/.dotfiles/git-completion.bash https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
apt-get update && apt-get install -y neovim nodejs npm curl tmux
curl -fsSL https://starship.rs/install.sh | bash
