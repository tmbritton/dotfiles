# dotfiles

Personal config for Bluefin + zsh + starship + ghostty.

## install on a fresh machine

```sh
git clone https://github.com/tmbritton/dotfiles.git ~/dotfiles
cd ~/dotfiles
./bootstrap.sh
```

Then create `~/.zshenv.local` (mode 600) for any API keys and other secrets.

## what lives where

- `zsh/`      — shell config
- `starship/` — prompt
- `git/`      — git config + global ignore
- `ghostty/`  — terminal
- `bin/`      — personal scripts (auto-added to $PATH)
- `Brewfile`  — `brew bundle install` to restore packages
- `flatpaks.txt` — `flatpak install < flatpaks.txt` to restore GUI apps

## secrets

`~/.zshenv.local` is sourced at the end of `.zshrc`. It is NOT in this repo.
Keep API keys, tokens, and anything else sensitive there. `chmod 600`.
