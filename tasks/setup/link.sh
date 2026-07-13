#!/usr/bin/env bash
#MISE description="Symlink everything under home/ into $HOME"
set -euo pipefail

ROOT="${MISE_PROJECT_ROOT:-$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)}"
SRC="$ROOT/home"

force=0
[[ "${1:-}" == "--force" || "${1:-}" == "-f" ]] && force=1

linked=0 already=0 skipped=0
while IFS= read -r -d '' src; do
  rel="${src#"$SRC"/}"
  [[ "$rel" == ".gitkeep" || "$rel" == */.gitkeep ]] && continue

  dest="$HOME/$rel"

  if [[ -L "$dest" && "$(readlink "$dest")" == "$src" ]]; then
    already=$((already + 1))
    continue
  fi

  mkdir -p "$(dirname "$dest")"

  if [[ -e "$dest" && ! -L "$dest" ]]; then
    if [[ "$force" -eq 1 ]]; then
      printf '! replacing %s\n' "$dest" >&2
      diff -u "$dest" "$src" || true
      rm -rf "$dest"
    else
      printf '! skip ~/%s (real file exists; use -- --force to replace)\n' "$rel" >&2
      skipped=$((skipped + 1))
      continue
    fi
  fi

  ln -sf "$src" "$dest"
  printf '+ linked ~/%s\n' "$rel"
  linked=$((linked + 1))
done < <(find "$SRC" -type f -print0)

printf 'done: %d linked, %d already current, %d skipped\n' "$linked" "$already" "$skipped"
