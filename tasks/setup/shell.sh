#!/usr/bin/env bash
#MISE description="Set up zsh: oh-my-zsh, plugins, fzf, default shell"
set -euo pipefail

OMZ="$HOME/.oh-my-zsh"
ZSH_CUSTOM="${ZSH_CUSTOM:-$OMZ/custom}"

if [[ -d "$OMZ" ]]; then
  echo "= oh-my-zsh already installed"
else
  echo "+ installing oh-my-zsh"
  git clone --depth=1 https://github.com/ohmyzsh/ohmyzsh.git "$OMZ"
fi

autosuggest="$ZSH_CUSTOM/plugins/zsh-autosuggestions"
if [[ -d "$autosuggest" ]]; then
  echo "= zsh-autosuggestions already installed"
else
  echo "+ installing zsh-autosuggestions"
  git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions "$autosuggest"
fi

syntax="$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
if [[ -d "$syntax" ]]; then
  echo "= zsh-syntax-highlighting already installed"
else
  echo "+ installing zsh-syntax-highlighting"
  git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting "$syntax"
fi

echo "+ installing fzf (global mise tool)"
mise use -g fzf@latest

zsh_bin="$(command -v zsh || echo /usr/bin/zsh)"
if [[ "$(getent passwd "$(id -un)" | cut -d: -f7)" == "$zsh_bin" ]]; then
  echo "= default shell already $zsh_bin"
else
  echo "+ setting default shell to $zsh_bin"
  sudo chsh "$(id -un)" --shell "$zsh_bin"
fi
