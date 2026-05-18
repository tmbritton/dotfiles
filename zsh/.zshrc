# .zshrc — interactive shell config

# ---------- history ----------
HISTFILE="$XDG_STATE_HOME/zsh/history"
HISTSIZE=50000
SAVEHIST=50000
mkdir -p "$(dirname "$HISTFILE")"

setopt EXTENDED_HISTORY          # timestamps in history
setopt HIST_EXPIRE_DUPS_FIRST    # drop dupes first when trimming
setopt HIST_IGNORE_DUPS          # don't record consecutive dupes
setopt HIST_IGNORE_SPACE         # commands starting with space are ephemeral
setopt HIST_VERIFY               # !! expansions show before executing
setopt SHARE_HISTORY             # share history across running shells
setopt INC_APPEND_HISTORY        # append immediately, not on exit

# ---------- navigation / shell behavior ----------
setopt AUTO_CD                   # `cd` is optional; bare dir names work
setopt AUTO_PUSHD                # cd pushes the old dir onto the stack
setopt PUSHD_IGNORE_DUPS
setopt INTERACTIVE_COMMENTS      # allow # comments in interactive shell
setopt NO_BEEP

# ---------- completion ----------
autoload -Uz compinit
# only rebuild compdump once a day — speeds up shell startup
if [[ -n "$XDG_CACHE_HOME/zsh/zcompdump"(#qN.mh+24) ]]; then
  compinit -d "$XDG_CACHE_HOME/zsh/zcompdump"
else
  compinit -C -d "$XDG_CACHE_HOME/zsh/zcompdump"
fi
mkdir -p "$XDG_CACHE_HOME/zsh"

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'   # case-insensitive
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# ---------- plugins via antidote ----------
ANTIDOTE_DIR="${HOMEBREW_PREFIX:-/home/linuxbrew/.linuxbrew}/opt/antidote/share/antidote"
if [ -f "$ANTIDOTE_DIR/antidote.zsh" ]; then
  source "$ANTIDOTE_DIR/antidote.zsh"
  antidote load ~/.zsh_plugins.txt
fi

# ---------- prompt ----------
if command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
fi

# ---------- key bindings ----------
bindkey -e                                # emacs-style (ctrl-a, ctrl-e, etc.)
bindkey '^[[A' history-search-backward    # up-arrow: prefix search
bindkey '^[[B' history-search-forward     # down-arrow: prefix search

# ---------- aliases ----------

# ---------- eza (modern ls) ----------
if command -v eza >/dev/null 2>&1; then
  # base flags shared across all eza aliases
  EZA_BASE="--group-directories-first --icons=auto --git --color=always"

  alias ls="eza $EZA_BASE"
  alias l="eza $EZA_BASE"                                          # short list
  alias ll="eza $EZA_BASE --long --header --git --time-style=long-iso"
  alias la="eza $EZA_BASE --long --header --git --all --time-style=long-iso"
  alias lt="eza $EZA_BASE --tree --level=2"                        # tree, 2 deep
  alias lta="eza $EZA_BASE --tree --level=2 --all"                 # tree w/ hidden
  alias lr="eza $EZA_BASE --long --header --git --sort=modified --reverse"  # newest last
  alias lS="eza $EZA_BASE --long --header --git --sort=size --reverse"      # biggest first
else
  alias ls='ls --color=auto'
  alias ll='ls -lah'
  alias la='ls -A'
  alias l='ls -CF'
fi

# ---------- bat (cat with syntax highlighting) ----------
if command -v bat >/dev/null 2>&1; then
  # use bat as cat. --paging=never so piping & short files don't open less.
  alias cat='bat --paging=never --style=plain'

  # full bat with line numbers + git gutter for reading files
  alias batp='bat --style=numbers,changes,header'

  # use bat as the pager for man pages — colored, syntax-aware
  export MANPAGER="sh -c 'col -bx | bat --language=man --style=plain --paging=always'"
  export MANROFFOPT="-c"

  # help text gets the bat treatment too
  alias bathelp='bat --plain --language=help'
  help() {
    "$@" --help 2>&1 | bat --plain --language=help
  }
fi

alias grep='grep --color=auto'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# git
alias g='git'
alias gs='git status'
alias gd='git diff'
alias gco='git checkout'
alias gp='git pull'
alias gl='git log --oneline --graph --decorate -20'

# safer mv/cp/rm
alias mv='mv -i'
alias cp='cp -i'
alias rm='rm -i'

# bluefin / rpm-ostree shortcuts
alias rpm-search='rpm-ostree search'
alias rpm-install='rpm-ostree install'
alias rpm-status='rpm-ostree status'

# tailscale shortcuts
alias ts='tailscale'
alias tss='tailscale status'

# ---------- functions ----------
# mkdir + cd in one
mkcd() { mkdir -p "$1" && cd "$1"; }

# extract any archive
extract() {
  case "$1" in
    *.tar.bz2|*.tbz2) tar xjf "$1" ;;
    *.tar.gz|*.tgz)   tar xzf "$1" ;;
    *.tar.xz)         tar xJf "$1" ;;
    *.tar)            tar xf  "$1" ;;
    *.bz2)            bunzip2 "$1" ;;
    *.gz)             gunzip  "$1" ;;
    *.zip)            unzip   "$1" ;;
    *.rar)            unrar x "$1" ;;
    *.7z)             7z x    "$1" ;;
    *) echo "extract: don't know how to handle '$1'" ;;
  esac
}

# ---------- tools that need init ----------
# direnv (uncomment after `brew install direnv`)
command -v direnv >/dev/null 2>&1 && eval "$(direnv hook zsh)"

# zoxide — smarter cd (uncomment after `brew install zoxide`)
# command -v zoxide >/dev/null 2>&1 && eval "$(zoxide init zsh)"

# fzf — fuzzy finder (uncomment after `brew install fzf`)
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# ---------- machine-local overrides + secrets ----------
# NOT in dotfiles repo. mode 600. API keys, machine-specific tweaks, etc.
[ -f ~/.zshenv.local ] && source ~/.zshenv.local
