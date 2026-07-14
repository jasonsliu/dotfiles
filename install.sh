#!/usr/bin/env bash
set -euo pipefail

dry_run=0
for arg in "$@"; do
  case "$arg" in
    --dry-run | -n) dry_run=1 ;;
    *) echo "unknown argument: $arg" >&2; exit 2 ;;
  esac
done

cd "$(dirname "${BASH_SOURCE[0]}")"

if ! command -v mise >/dev/null 2>&1 && [[ ! -x "$HOME/.local/bin/mise" ]]; then
  echo "Installing mise…"
  curl -fsSL https://mise.run | sh
fi

export PATH="$HOME/.local/bin:$PATH"
mise --version

mise trust .

if [[ "$dry_run" -eq 1 ]]; then
  mise run setup --dry-run
else
  mise run setup
fi
