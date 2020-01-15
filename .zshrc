export PATH=$HOME/bin:$HOME/go/bin:/usr/local/bin:$PATH
source  ~/.bash_path
source  ~/.aliases
source  ~/.functions

# Show OS info when opening a new terminal
neofetch

plugins=(
  git
  npm
  nvm
  colored-man-pages
  github
  heroku
)

# Path to your oh-my-zsh installation.
export ZSH="~/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh

ZSH_THEME="powerlevel9k/powerlevel9k"

HYPHEN_INSENSITIVE="true"

DISABLE_AUTO_UPDATE="true"

ENABLE_CORRECTION="true"

source ~/.zsh_prompt

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f /Users/caiokf/development/indebted/finance/node_modules/tabtab/.completions/serverless.zsh ]] && . /Users/caiokf/development/indebted/finance/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f /Users/caiokf/development/indebted/finance/node_modules/tabtab/.completions/sls.zsh ]] && . /Users/caiokf/development/indebted/finance/node_modules/tabtab/.completions/sls.zsh
# tabtab source for slss package
# uninstall by removing these lines or running `tabtab uninstall slss`
[[ -f /Users/caiokf/development/indebted/finance/node_modules/tabtab/.completions/slss.zsh ]] && . /Users/caiokf/development/indebted/finance/node_modules/tabtab/.completions/slss.zsh

source ~/.zsh_prompt
