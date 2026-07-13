export ZSH="$HOME/.oh-my-zsh"

export PATH="$HOME/.local/bin:$PATH"
command -v mise >/dev/null 2>&1 && eval "$(mise activate zsh)"

plugins=(z zsh-autosuggestions fzf)

source "$ZSH/oh-my-zsh.sh"
