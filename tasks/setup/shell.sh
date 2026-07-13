#!/usr/bin/env bash
#MISE description="Install oh-my-zsh and the zsh-autosuggestions plugin"
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
