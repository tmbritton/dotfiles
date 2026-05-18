#!/usr/bin/env bash
# bootstrap.sh — symlink dotfiles into $HOME and $XDG_CONFIG_HOME
# safe to re-run; existing symlinks are replaced, real files are backed up.

set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
XDG="${XDG_CONFIG_HOME:-$HOME/.config}"
BACKUP="$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"

link() {
  local src="$1" dst="$2"
  if [ -e "$dst" ] && [ ! -L "$dst" ]; then
    mkdir -p "$BACKUP"
    echo "  backing up existing $dst → $BACKUP/"
    mv "$dst" "$BACKUP/"
  fi
  mkdir -p "$(dirname "$dst")"
  ln -sfn "$src" "$dst"
  echo "  linked $dst"
}

echo "==> linking home dotfiles"
link "$DOTFILES/zsh/.zshrc"            "$HOME/.zshrc"
link "$DOTFILES/zsh/.zshenv"           "$HOME/.zshenv"
link "$DOTFILES/zsh/.zsh_plugins.txt"  "$HOME/.zsh_plugins.txt"
link "$DOTFILES/git/.gitconfig"        "$HOME/.gitconfig"
link "$DOTFILES/git/.gitignore_global" "$HOME/.gitignore_global"

echo "==> linking XDG configs"
link "$DOTFILES/starship/starship.toml" "$XDG/starship.toml"
link "$DOTFILES/ghostty/config"         "$XDG/ghostty/config"

# In bootstrap.sh, add a section:
echo "==> neovim config"
if [ ! -d "$XDG/nvim" ]; then
  git clone https://github.com/tmbritton/kickstart.nvim.git "$XDG/nvim"
else
  echo "  $XDG/nvim already exists, skipping clone"
fi

echo ""
echo "done."
echo ""
echo "next steps:"
echo "  1. create ~/.zshenv.local with secrets (chmod 600)"
echo "  2. brew bundle install --file=$DOTFILES/Brewfile"
echo "  3. flatpak install --user < $DOTFILES/flatpaks.txt"
echo "  4. open a new shell (or: exec zsh)"
