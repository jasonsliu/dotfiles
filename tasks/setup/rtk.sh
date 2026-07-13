#!/usr/bin/env bash
#MISE description="Install rtk and wire it into Claude Code"
set -euo pipefail

if command -v rtk >/dev/null 2>&1 || [[ -x "$HOME/.local/bin/rtk" ]]; then
  echo "= rtk already installed"
else
  echo "+ installing rtk"
  curl -fsSL https://raw.githubusercontent.com/rtk-ai/rtk/refs/heads/master/install.sh | sh
fi

export PATH="$HOME/.local/bin:$PATH"

echo "+ rtk init -g"
if ! rtk init -g; then
  echo "! rtk init -g failed (is Claude Code installed?) — continuing" >&2
fi
