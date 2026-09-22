# vim: set ft=sh :

__prompt_git_branch() {
  local _branch

  __prompt_branch=
  _branch=$(git symbolic-ref --quiet --short HEAD 2>/dev/null) || return
  __prompt_branch="$_branch"
}

__prompt_directory() {
  local _path _root _relative _prefix _part _count

  __prompt_read_only=
  _path=$PWD
  [ "$_path" = "$HOME" ] && {
    __prompt_directory='~'
    return
  }
  case $_path in
  "$HOME"/*) __prompt_directory="~/${_path#"$HOME"/}" ;;
  *) __prompt_directory="$_path" ;;
  esac

  _root=$(git rev-parse --show-toplevel 2>/dev/null) || _root=
  if [ -n "$_root" ] && [ "$_path" = "$_root" ]; then
    __prompt_directory=$(basename "$_root")
  elif [ -n "$_root" ]; then
    case $_path in
    "$_root"/*) _relative=${_path#"$_root"/} ;;
    *) _relative= ;;
    esac
    if [ -n "$_relative" ]; then
      _count=0
      _prefix=
      while [ "$_relative" != "${_relative#*/}" ]; do
        _part=${_relative%%/*}
        _relative=${_relative#*/}
        _prefix="$_prefix/$_part"
        _count=$((_count + 1))
      done
      _prefix="$_prefix/$_relative"
      _count=$((_count + 1))
      while [ "$_count" -gt 3 ]; do
        _prefix=${_prefix#*/}
        _count=$((_count - 1))
      done
      __prompt_directory="$(basename "$_root")$_prefix"
    else
      __prompt_directory=$(basename "$_root")
    fi
  else
    _relative=${__prompt_directory#*/}
    _count=0
    _prefix=
    while [ "$_relative" != "${_relative#*/}" ]; do
      _part=${_relative%%/*}
      _relative=${_relative#*/}
      _prefix="$_prefix/$_part"
      _count=$((_count + 1))
    done
    _prefix="$_prefix/$_relative"
    _count=$((_count + 1))
    while [ "$_count" -gt 3 ]; do
      _prefix=${_prefix#*/}
      _count=$((_count - 1))
    done
    case $__prompt_directory in
    ~/*) __prompt_directory="~$_prefix" ;;
    /*) __prompt_directory="$_prefix" ;;
    *) __prompt_directory="$_prefix" ;;
    esac
  fi

  [ ! -w "$PWD" ] && __prompt_read_only=1
}

__prompt_hostname() {
  local _host
  case ${SSH_CONNECTION-}${SSH_CLIENT-}${SSH_TTY-} in
  '') __prompt_hostname= ;;
  *)
    _host=${HOSTNAME:-$(hostname)}
    __prompt_hostname="🌐 ${_host%%.*}"
    ;;
  esac
}

__prompt_python() {
  if [ -n "${VIRTUAL_ENV-}" ]; then
    __prompt_python="($(basename "$VIRTUAL_ENV")) "
  else
    __prompt_python=
  fi
}

__prompt_collect() {
  __prompt_python
  __prompt_hostname
  __prompt_directory
  __prompt_git_branch
}

[ -n "$ZSH_VERSION" ] && {
  __prompt_zsh_precmd() {
    local _status=$?
    local _cyan='%F{cyan}' _blue='%F{blue}' _purple='%F{magenta}'
    local _green='%F{green}' _red='%F{red}' _bold='%B' _reset='%f%b'

    __prompt_collect
    PROMPT="${_bold}${_green}${__prompt_python}${_reset}"
    if [ -n "$__prompt_hostname" ]; then
      PROMPT+="${_blue}${__prompt_hostname}${_reset} in "
    fi
    PROMPT+="${_cyan}${__prompt_directory}"
    [ -n "$__prompt_read_only" ] && PROMPT+="${_red}🔒"
    PROMPT+="${_reset}"
    if [ -n "$__prompt_branch" ]; then
      PROMPT+=" on ${_purple} ${__prompt_branch}${_reset}"
    fi
    PROMPT+=" "
    if [ "$_status" -eq 0 ]; then
      PROMPT+="${_bold}${_green}❯${_reset} "
    else
      PROMPT+="${_bold}${_red}❯${_reset} "
    fi
  }

  case " ${precmd_functions[*]-} " in
  *' __prompt_zsh_precmd '*) ;;
  *) precmd_functions+=(__prompt_zsh_precmd) ;;
  esac
}

[ -n "$BASH_VERSION" ] && {
  __prompt_bash_precmd() {
    local _status=$?
    local _cyan="\[$(tput setaf 6 2>/dev/null)\]" _blue="\[$(tput setaf 4 2>/dev/null)\]"
    local _purple="\[$(tput setaf 5 2>/dev/null)\]" _green="\[$(tput setaf 2 2>/dev/null)\]"
    local _red="\[$(tput setaf 1 2>/dev/null)\]" _bold="\[$(tput bold 2>/dev/null)\]"
    local _reset="\[$(tput sgr0 2>/dev/null)\]"

    __prompt_collect
    PS1="${_bold}${_green}${__prompt_python}${_reset}"
    if [ -n "$__prompt_hostname" ]; then
      PS1+="${_blue}${__prompt_hostname}${_reset} in "
    fi
    PS1+="${_cyan}${__prompt_directory}"
    [ -n "$__prompt_read_only" ] && PS1+="${_red}🔒"
    PS1+="${_reset}"
    if [ -n "$__prompt_branch" ]; then
      PS1+=" on ${_purple} ${__prompt_branch}${_reset}"
    fi
    PS1+=" "
    if [ "$_status" -eq 0 ]; then
      PS1+="${_bold}${_green}❯${_reset} "
    else
      PS1+="${_bold}${_red}❯${_reset} "
    fi
  }

  case ";${PROMPT_COMMAND-};" in
  *';__prompt_bash_precmd;'*) ;;
  *) PROMPT_COMMAND="__prompt_bash_precmd${PROMPT_COMMAND:+;$PROMPT_COMMAND}" ;;
  esac
}
