#!/usr/bin/env bash
set -euo pipefail

KIT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SOURCE_DIR="$KIT_DIR/skills"
DEFAULT_CODEX_HOME="${CODEX_HOME:-$HOME/.codex}"
TARGET_DIR="${CODEX_SKILLS_DIR:-$DEFAULT_CODEX_HOME/skills}"
MODE="copy"
FORCE="false"

usage() {
  cat <<'EOF'
Usage: bash scripts/install.sh [--copy|--link] [--force]

Installs bundled Codex skills into the user-level skills directory:
  ${CODEX_SKILLS_DIR:-${CODEX_HOME:-$HOME/.codex}/skills}

Options:
  --copy   Copy skill directories into the target directory. Default.
  --link   Create symbolic links instead of copying.
  --force  Replace existing skill directories or links.

Environment:
  CODEX_SKILLS_DIR  Explicit target skills directory.
  CODEX_HOME        Codex home directory. Defaults to $HOME/.codex.
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --copy) MODE="copy" ;;
    --link) MODE="link" ;;
    --force) FORCE="true" ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Unknown option: $1" >&2; usage; exit 1 ;;
  esac
  shift
done

mkdir -p "$TARGET_DIR"

for skill in "$SOURCE_DIR"/*; do
  [[ -d "$skill" ]] || continue
  name="$(basename "$skill")"
  dest="$TARGET_DIR/$name"

  if [[ -e "$dest" || -L "$dest" ]]; then
    if [[ "$FORCE" == "true" ]]; then
      rm -rf "$dest"
    else
      echo "SKIP existing: $dest"
      continue
    fi
  fi

  if [[ "$MODE" == "link" ]]; then
    ln -s "$skill" "$dest"
    echo "LINK $name -> $skill"
  else
    cp -R "$skill" "$dest"
    echo "COPY $name -> $dest"
  fi
done

echo "Installed skills in: $TARGET_DIR"
