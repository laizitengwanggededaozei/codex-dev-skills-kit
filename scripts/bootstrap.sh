#!/usr/bin/env bash
set -euo pipefail

KIT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TARGET=""
INSTALL_MODE="copy"
FORCE=""

usage() {
  cat <<'EOF'
Usage: bash scripts/bootstrap.sh --target <project-root> [--copy|--link] [--force]

One-command migration helper:
  1. Install bundled skills into the Codex skills directory.
  2. Initialize the target project with AGENTS.md, docs/ai-dev/, and scripts/ai-dev/.

Existing project files are skipped unless --force is used.
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --target)
      TARGET="$2"
      shift
      ;;
    --copy)
      INSTALL_MODE="copy"
      ;;
    --link)
      INSTALL_MODE="link"
      ;;
    --force)
      FORCE="--force"
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown option: $1" >&2
      usage
      exit 1
      ;;
  esac
  shift
done

if [[ -z "$TARGET" ]]; then
  echo "Missing required --target <project-root>" >&2
  usage
  exit 1
fi

bash "$KIT_DIR/scripts/install.sh" "--$INSTALL_MODE" ${FORCE:+"$FORCE"}
bash "$KIT_DIR/scripts/init-project.sh" --target "$TARGET" ${FORCE:+"$FORCE"}

echo "Bootstrap completed."
echo "Verify:"
echo "  - Skills directory: \${CODEX_SKILLS_DIR:-\${CODEX_HOME:-\$HOME/.codex}/skills}"
echo "  - Project rules: $TARGET/AGENTS.md"
echo "  - Workflow rules: $TARGET/docs/ai-dev/02_WORKFLOW_RULES.md"
echo "  - Communication rules: $TARGET/docs/ai-dev/04_COMMUNICATION_RULES.md"
