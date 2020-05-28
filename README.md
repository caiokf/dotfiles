# caiokf's dotfiles

![caiokf's dotfiles](https://raw.githubusercontent.com/caiokf/dotfiles/master/media/prompt.png)

## Contents

What's in there?

- my `brew` dependencies including: applications, fonts, etc. See [`Brewfile`](https://github.com/caiokf/dotfiles/blob/master/Brewfile)
- my `macOS` configuration. See [`macos`](https://github.com/caiokf/dotfiles/blob/master/macos)
- all my [shell configuration]. See [`shell/`](https://github.com/caiokf/dotfiles/tree/master/shell) and [`config/zshrc`](https://github.com/caiokf/dotfiles/blob/master/config/zshrc)
- all my `vscode` configuration. See [`vscode/`](https://github.com/caiokf/dotfiles/tree/master/vscode)

## Installation

I am using [`dotbot`](https://github.com/anishathalye/dotbot/)
to set things up. Steps:

1. Clone this repo
2. `cd` into `dotfiles/` folder
3. Run: `./install`

## CLI

I am using `zsh` with [`oh-my-zsh`](https://github.com/robbyrussell/oh-my-zsh)
as a main shell.

## Apps

I am using `brew` to install all free apps for my mac.
I also sync apps from AppStore with `brew`,
so the resulting [`Brewfile`](https://github.com/caiokf/dotfiles/blob/master/Brewfile) should contain everything.

## Local configuration

Some of the used tools requires local configuration. Such as `git` with username and email.

Here's the full list:

1. `~/.gitconfig_local` to store any user-specific data
2. `~/.shell_env_local` to store local shell config, like: usernames, passwords, tokens and so on

## License

[WTFPL](https://en.wikipedia.org/wiki/WTFPL): do the fuck you want. Enjoy!
