# Brewfile — `brew bundle install --file=~/dotfiles/Brewfile`
# regenerate from current state: `brew bundle dump --force --file=~/dotfiles/Brewfile`

# ===== shell + prompt =====
brew "antidote"           # zsh plugin manager
brew "starship"           # cross-shell prompt
brew "zsh-completions"    # extra completion definitions

# ===== core cli swaps / upgrades =====
brew "eza"                # modern ls (replaces exa, which is unmaintained)
brew "bat"                # cat with syntax highlighting + paging
brew "ripgrep"            # rg — fast recursive grep
brew "fd"                 # find, but sane
brew "fzf"                # fuzzy finder (ctrl-r, ctrl-t bindings)
brew "zoxide"             # smarter cd that learns your habits
brew "tree"               # directory tree printer
brew "jq"                 # json processor
brew "yq"                 # yaml processor (jq for yaml)
brew "htop"               # process viewer
brew "btop"               # prettier htop
brew "ncdu"               # disk usage browser
brew "duf"                # df, but readable

# ===== networking / homelab =====
brew "curl"
brew "wget"
brew "rsync"              # newer than bluefin's stock rsync
brew "nmap"               # network scanning
brew "mtr"                # traceroute + ping in one

# ===== dev: version control + editors =====
brew "git"                # newer than bluefin's stock git
brew "gh"                 # github cli
brew "lazygit"            # tui git client — genuinely great
brew "neovim"             # editor
brew "tmux"               # terminal multiplexer

# ===== dev: languages / runtimes =====
brew "mise"               # polyglot version manager (replaces asdf, nvm, rbenv, etc.)
brew "node"

# ===== secrets / env =====
brew "direnv"             # per-project env via .envrc
# brew "rbw"              # community bitwarden cli — uncomment when vaultwarden is up
# brew "age"              # modern file encryption — uncomment if useful

# ===== misc utilities =====
brew "imagemagick"        # image conversion / batch processing
brew "ffmpeg"             # video / audio everything
brew "pandoc"             # universal document converter
brew "yt-dlp"             # video downloader

# ===== fonts (linux: brew installs to ~/.linuxbrew/share/fonts) =====
# brew "font-jetbrains-mono-nerd-font"  # uncomment for nerd font icons
# brew "font-jetbrains-mono"            # plain version

# ===== GUI apps — leave these to flatpak on bluefin =====
# don't `brew install --cask` on linux. flatpaks integrate better with the OS.
