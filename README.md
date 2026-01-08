# dotfiles

Personal dotfiles managed with [dotbot](https://github.com/anishathalye/dotbot).

## Structure

```
dotfiles/
├── config/                 # Dotfiles to be symlinked
│   ├── shell/              # Shell configuration (zsh, bash)
│   ├── git/                # Git config and global ignore
│   ├── ssh/                # SSH config
│   ├── vscode/             # VS Code / Cursor settings
│   ├── ghostty/            # Ghostty terminal config
│   ├── starship/           # Starship prompt config
│   ├── mise/               # mise version manager config
│   └── editorconfig        # Editor config
├── steps/                  # Modular installation steps
│   ├── link/               # Symlink dotfiles
│   ├── brew/               # Homebrew packages
│   ├── vscode/             # VS Code/Cursor extensions
│   └── macos/              # macOS system defaults
└── install                 # Main entry point
```

## Installation

```bash
git clone https://github.com/caiokf/dotfiles ~/development/dotfiles
cd ~/development/dotfiles
./install
```

### Run specific steps

```bash
./install link          # Symlink dotfiles only
./install brew          # Install Homebrew packages only
./install vscode        # Install VS Code/Cursor extensions only
./install macos         # Apply macOS defaults only
./install link brew     # Run multiple steps
```

## Steps

### link

Symlinks all config files to their destinations, for example:

- `~/.zshrc`, `~/.bash_profile` - Shell configs
- `~/.config/shell/` - Shell init, aliases, exports, functions
- `~/.config/git/` - Git config and ignore
- `~/.ssh/config` - SSH config
- `~/.config/ghostty/` - Terminal config
- `~/.config/starship/` - Prompt config
- `~/.config/mise/` - Version manager config
- `~/Library/Application Support/Code/User/` - VS Code settings
- `~/Library/Application Support/Cursor/User/` - Cursor settings (shared with VS Code)

### brew

Installs Homebrew packages from modular Brewfiles:

- `Brewfile.core` - Essential CLI tools (git, fzf, ripgrep, bat, eza, etc.)
- `Brewfile.dev` - Development tools (mise, docker, vim, neovim, etc.)
- `Brewfile.apps` - GUI applications (Ghostty, Raycast, VS Code, etc.)
- `Brewfile.fonts` - Nerd Fonts

### vscode

Installs VS Code and Cursor extensions from `extensions.txt`.

### macos

Applies macOS system defaults (Dock, Finder, keyboard settings, etc.).

## Tools

- **Shell**: zsh + [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh)
- **Prompt**: [Starship](https://starship.rs/)
- **Version Manager**: [mise](https://mise.jdx.dev/) (node, python, ruby, go, rust, terraform, awscli, pulumi)
- **Terminal**: [Ghostty](https://ghostty.org/)

## Local Configuration

Machine-specific configs (not tracked in git):

- `~/.ssh/config.local` - SSH keys and hosts
- `~/.config/git/config.local` - Git user settings (included by main config)
- `~/.shell_local` - Shell environment variables, tokens, etc.

## License

[WTFPL](https://en.wikipedia.org/wiki/WTFPL)
