# Main Brewfile - includes all package categories
#
# Usage:
#   brew bundle                     # Install everything
#   brew bundle --file=packages/Brewfile.core   # Install only core tools
#   brew bundle --file=packages/Brewfile.dev    # Install only dev tools
#   brew bundle --file=packages/Brewfile.apps   # Install only apps
#   brew bundle --file=packages/Brewfile.fonts  # Install only fonts

# Taps
tap "homebrew/bundle"
tap "homebrew/cask-fonts"
tap "homebrew/services"

# Include modular Brewfiles
# Note: `brew bundle` doesn't support includes, so we list everything here
# The separate files exist for selective installation

# === Core CLI Tools ===
brew "zsh"
brew "bash"
brew "starship"
brew "coreutils"
brew "curl"
brew "wget"
brew "tree"
brew "trash"
brew "jq"
brew "ripgrep"
brew "fd"
brew "bat"
brew "eza"
brew "zoxide"
brew "fzf"
brew "htop"
brew "fastfetch"
brew "grep"
brew "sed"
brew "gawk"
brew "git"
brew "gh"
brew "git-delta"
brew "lazygit"
brew "gnupg"
brew "nmap"
brew "zstd"
brew "xz"
brew "mas"
brew "tldr"

# === Development Tools ===
brew "mise"
brew "docker"
brew "lazydocker"
brew "docker-compose"
brew "vim"
brew "neovim"
brew "terraform"
brew "terraform-docs"
brew "awscli"
brew "shellcheck"
brew "ctags"
brew "postgresql@16"
brew "redis"
brew "cmake"
brew "make"

# === GUI Applications ===
cask "ghostty"
cask "raycast"
cask "google-chrome"
cask "visual-studio-code"
cask "postman"
cask "tableplus"
cask "docker"
cask "slack"
cask "zoom"
cask "spotify"
cask "vlc"
cask "the-unarchiver"
cask "karabiner-elements"
cask "dropbox"
cask "calibre"

# === Fonts ===
cask "font-fira-code-nerd-font"
cask "font-jetbrains-mono-nerd-font"
cask "font-hack-nerd-font"
cask "font-meslo-lg-nerd-font"
cask "font-roboto-mono-nerd-font"

# === Mac App Store ===
mas "1Password 7", id: 1333542190
mas "Evernote", id: 406056744
