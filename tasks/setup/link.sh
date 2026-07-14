#!/usr/bin/env bash
#MISE description="Symlink everything under home/ into $HOME"
set -euo pipefail

ROOT="${MISE_PROJECT_ROOT:-$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)}"
SRC="$ROOT/home"

linked=0 already=0 backed_up=0
while IFS= read -r -d '' src; do
  rel="${src#"$SRC"/}"
  [[ "$rel" == ".gitkeep" || "$rel" == */.gitkeep ]] && continue

  dest="$HOME/$rel"

  if [[ -L "$dest" && "$(readlink "$dest")" == "$src" ]]; then
    already=$((already + 1))
    continue
  fi

  mkdir -p "$(dirname "$dest")"

  if [[ -e "$dest" || -L "$dest" ]]; then
    mv -f "$dest" "$dest.bak"
    echo "~ backed up ~/$rel -> ~/$rel.bak"
    backed_up=$((backed_up + 1))
  fi

  ln -sf "$src" "$dest"
  echo "+ linked ~/$rel"
  linked=$((linked + 1))
done < <(find "$SRC" -type f -print0)

echo "done: $linked linked, $already already current, $backed_up backed up"
