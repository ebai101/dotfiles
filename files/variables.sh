export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export STARSHIP_CONFIG=~/.starship

case $OSTYPE in
    darwin*)
        export HOMEBREW_NO_ANALYTICS=1
        export HOMEBREW_VERBOSE=1
        export EDITOR=/opt/homebrew/bin/nvim

        # add system library to path (big sur broke this)
        # https://apple.stackexchange.com/questions/408999/gfortran-compiler-error-on-mac-os-big-sur
        if [ -z "${LIBRARY_PATH}" ]; then
            export LIBRARY_PATH="/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/lib"
        else
            export LIBRARY_PATH="$LIBRARY_PATH:/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/lib"
        fi
        ;;
    linux*)
        export EDITOR=/bin/vim
        if [ $SHELL = "/bin/zsh" ]; then
            source /usr/share/doc/fzf/examples/key-bindings.zsh
            source /usr/share/doc/fzf/examples/completion.zsh
            [ -f ~/.fzf.bash ] && source ~/.fzf.bash
        fi
        ;;
esac

# source virtualenvs
if [ -n "$VIRTUAL_ENV" ]; then
    source $VIRTUAL_ENV/bin/activate;
fi
