#!/usr/bin/env bash
set -euo pipefail

KIT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TEMPLATE_DIR="$KIT_DIR/templates"
TARGET="$(pwd)"
FORCE="false"

usage() {
  cat <<'EOF'
Usage: bash scripts/init-project.sh [--target <project-root>] [--force]

Optional helper for initializing a project for Codex-assisted development.
Creates AGENTS.md, docs/ai-dev/, scripts/ai-dev/, and project-level .agents/skills/.
Existing files are not overwritten unless --force is used.

Recommended flow:
  1. Install skills with scripts/install.sh
  2. Open Codex inside the project
  3. Ask: 使用 Setup Codex Dev Workspace，初始化当前项目
  4. Let Codex inspect the project and fill docs/ai-dev/01_PROJECT_CONTEXT.md
     before coding

This helper creates structure and templates only. It does not inspect or
understand project-specific facts.
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --target)
      TARGET="$2"
      shift
      ;;
    --force)
      FORCE="true"
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

mkdir -p "$TARGET"
cd "$TARGET"

created=()
skipped=()

copy_template() {
  local src="$1"
  local dest="$2"

  if [[ ! -f "$src" ]]; then
    echo "Missing template: $src" >&2
    exit 1
  fi

  if [[ -e "$dest" && "$FORCE" != "true" ]]; then
    skipped+=("$dest")
    return
  fi

  mkdir -p "$(dirname "$dest")"
  cp "$src" "$dest"
  created+=("$dest")
}

ensure_dir() {
  local path="$1"
  mkdir -p "$path"
  created+=("$path/")
}

ensure_dir ".agents/skills"
ensure_dir "scripts/ai-dev"
ensure_dir "docs/ai-dev/10_需求记录"
ensure_dir "docs/ai-dev/20_设计方案"
ensure_dir "docs/ai-dev/30_审查记录"
ensure_dir "docs/ai-dev/40_故障修复"
ensure_dir "docs/ai-dev/50_执行手册"
ensure_dir "docs/ai-dev/60_交接记录"
ensure_dir "docs/ai-dev/90_临时笔记"
ensure_dir "docs/ai-dev/99_归档资料"

copy_template "$TEMPLATE_DIR/AGENTS.md" "AGENTS.md"
copy_template "$TEMPLATE_DIR/project-docs/00_INDEX.md" "docs/ai-dev/00_INDEX.md"
copy_template "$TEMPLATE_DIR/project-docs/01_PROJECT_CONTEXT.md" "docs/ai-dev/01_PROJECT_CONTEXT.md"
copy_template "$TEMPLATE_DIR/project-docs/02_WORKFLOW_RULES.md" "docs/ai-dev/02_WORKFLOW_RULES.md"
copy_template "$TEMPLATE_DIR/project-docs/03_DELIVERY_LOG.md" "docs/ai-dev/03_DELIVERY_LOG.md"
copy_template "$TEMPLATE_DIR/project-docs/04_COMMUNICATION_RULES.md" "docs/ai-dev/04_COMMUNICATION_RULES.md"
copy_template "$TEMPLATE_DIR/project-scripts/README.md" "scripts/ai-dev/README.md"

copy_project_skill() {
  local name="$1"
  local src="$KIT_DIR/skills/$name"
  local dest=".agents/skills/$name"

  if [[ ! -d "$src" ]]; then
    echo "Missing skill: $src" >&2
    exit 1
  fi

  if [[ -e "$dest" && "$FORCE" != "true" ]]; then
    skipped+=("$dest")
    return
  fi

  rm -rf "$dest"
  cp -R "$src" "$dest"
  created+=("$dest/")
}

copy_project_skill "codex-question-aligner"
copy_project_skill "codex-design-alignment"
copy_project_skill "engineering-ai-dev-suite"
copy_project_skill "codex-code-review"
copy_project_skill "setup-codex-dev-workspace"

echo "Created:"
printf "  %s\n" "${created[@]}"

if [[ ${#skipped[@]} -gt 0 ]]; then
  echo "Skipped existing:"
  printf "  %s\n" "${skipped[@]}"
fi

echo "Project initialized at: $TARGET"
echo "Structure initialized only."
echo "Ask Codex to inspect the project and fill docs/ai-dev/01_PROJECT_CONTEXT.md before coding."
