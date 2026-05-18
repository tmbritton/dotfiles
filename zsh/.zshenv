# .zshenv — sourced on every shell invocation (interactive or not)
# keep this lean. anything UI/prompt/alias related goes in .zshrc.

# XDG base directories — explicit so apps stop scattering files in $HOME
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"

# editor + pager
export EDITOR="nvim"
export VISUAL="nvim"
export PAGER="less"
export LESS="-FRX"  # quit if one screen, raw control chars, no init

# locale
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# personal scripts on PATH
export PATH="$HOME/dotfiles/bin:$HOME/.local/bin:$PATH"

# homebrew (bluefin ships with brew at /home/linuxbrew/.linuxbrew)
if [ -d /home/linuxbrew/.linuxbrew ]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# Go
export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$PATH"
