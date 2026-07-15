export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="devcontainers"

export PATH="$HOME/.local/bin:$PATH"
command -v mise >/dev/null 2>&1 && eval "$(mise activate zsh)"

[ -f /etc/profile.d/ona-secrets.sh ] && . /etc/profile.d/ona-secrets.sh

plugins=(z zsh-autosuggestions fzf zsh-syntax-highlighting)

source "$ZSH/oh-my-zsh.sh"

test -e "$HOME/.iterm2_shell_integration.zsh" && source "$HOME/.iterm2_shell_integration.zsh"
