function toon {
  case "$OSTYPE" in
    "darwin"*) echo -n "" ;;              # macOS
    "msys"*) echo -n "" ;;                # Windows (Git Bash / MSYS)
    "linux-gnu"*) 
      if [[ -f /etc/os-release ]]; then
        . /etc/os-release
        case "$ID" in
          "ubuntu") echo -n "" ;;         # Ubuntu
          "gentoo") echo -n "" ;;         # Gentoo
          *) echo -n "" ;;                # Other Linux
        esac
      else
        echo -n ""                        # Fallback for unknown Linux
      fi
      ;;
    *) echo -n "" ;;                      # Fallback for other/unknown OS
  esac
}


autoload -Uz vcs_info
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr '%F{red}*'   # display this when there are unstaged changes
zstyle ':vcs_info:*' stagedstr '%F{yellow}+'  # display this when there are staged changes
zstyle ':vcs_info:*' actionformats '%F{5}[%F{2}%b%F{3}|%F{1}%a%c%u%F{5}]%f '
zstyle ':vcs_info:*' formats '%F{5}[%F{2}%b%c%u%F{5}]%f '
zstyle ':vcs_info:svn:*' branchformat '%b'
zstyle ':vcs_info:svn:*' actionformats '%F{5}[%F{2}%b%F{1}:%F{3}%i%F{3}|%F{1}%a%c%u%F{5}]%f '
zstyle ':vcs_info:svn:*' formats '%F{5}[%F{2}%b%F{1}:%F{3}%i%c%u%F{5}]%f '
zstyle ':vcs_info:*' enable git cvs svn

theme_precmd () {
  vcs_info
}

setopt prompt_subst
PROMPT='%{$fg[magenta]%}$(toon)%{$reset_color%} %~/ %{$reset_color%}${vcs_info_msg_0_}%{$reset_color%}'

autoload -U add-zsh-hook
add-zsh-hook precmd theme_precmd

RPROMPT="%D{%L:%M:%S %p}"
