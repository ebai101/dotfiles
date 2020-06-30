#!/usr/bin/env bash

dotdir="$(whoami)@$(hostname)"
echo -- INSTALLING DOTFILES for $dotdir

# touch config dir
mkdir -p ~/.config

# global files
echo -- linking global dotfiles
for file in ~/.dotfiles/global/dots/**; do 
   dotfile=".$(echo $(basename $file))"
   ln -svf $file ~/$dotfile
done

# global config dirs
echo -- linking global config dirs
for dir in ~/.dotfiles/global/config/*/; do
    ln -svf $dir ~/.config
done

# local files
if [ -d ~/.dotfiles/$dotdir/dots ]; then
    echo -- linking local dotfiles
    for file in ~/.dotfiles/$dotdir/dots/**; do
        dotfile=".$(echo $(basename $file))"
        ln -svf $file ~/$dotfile
    done
fi

# local config dirs
if [ -d ~/.dotfiles/$dotdir/config ]; then    
    echo -- linking local config dirs
    for dir in ~/.dotfiles/$dotdir/config/*/; do
        ln -svf $dir ~/.config
    done
fi

# run install script
echo -- running local install script
local_inst="$HOME/.dotfiles/$dotdir/scripts/install.sh"
[ -f $local_inst ] && exec $local_inst
