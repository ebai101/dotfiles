# vim: set ft=sh :

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

case $OSTYPE in
darwin*)
  export EDITOR=/opt/homebrew/bin/nvim

  export HOMEBREW_NO_ANALYTICS=1
  export HOMEBREW_VERBOSE=1
  eval export HOMEBREW_PREFIX="/opt/homebrew"
  export HOMEBREW_CELLAR="/opt/homebrew/Cellar"
  export HOMEBREW_REPOSITORY="/opt/homebrew"
  fpath[1,0]="/opt/homebrew/share/zsh/site-functions"
  export FPATH
  eval "$(/usr/bin/env PATH_HELPER_ROOT="/opt/homebrew" /usr/libexec/path_helper -s)"
  [ -z "${MANPATH-}" ] || export MANPATH=":${MANPATH#:}"
  export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}"

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
  fi
  ;;
esac
