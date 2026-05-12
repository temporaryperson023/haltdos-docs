#!/bin/bash

# ═══════════════════════════════════════════════
#  Haltdos Docs — GitHub Pages Deploy Script
#  Usage: ./deploy.sh
# ═══════════════════════════════════════════════

set -e  # exit immediately on any error

# ── Colors for output ──
RED='\033[0;31m'
GREEN='\033[0;32m'
AMBER='\033[0;33m'
BLUE='\033[0;34m'
BOLD='\033[1m'
RESET='\033[0m'

# ── Config — UPDATE THESE ──
GITHUB_USERNAME="your-github-username"
REPO_NAME="haltdos-docs"
BRANCH="gh-pages"
COMMIT_MSG="docs: update $(date '+%Y-%m-%d %H:%M')"

# ════════════════════════════════════════
echo ""
echo -e "${BOLD}  🚀 Haltdos Docs — Deploy to GitHub Pages${RESET}"
echo -e "  ${BLUE}────────────────────────────────────────${RESET}"
echo ""

# ── Step 1: Check git is installed ──
echo -e "  ${AMBER}[1/6]${RESET} Checking git..."
if ! command -v git &> /dev/null; then
  echo -e "  ${RED}✗ git is not installed. Install it first.${RESET}"
  exit 1
fi
echo -e "  ${GREEN}✓ git found${RESET}"

# ── Step 2: Init repo if needed ──
echo -e "  ${AMBER}[2/6]${RESET} Checking repository..."
if [ ! -d ".git" ]; then
  echo -e "         No git repo found — initializing..."
  git init
  git remote add origin "https://github.com/${GITHUB_USERNAME}/${REPO_NAME}.git"
  echo -e "  ${GREEN}✓ Repository initialized${RESET}"
  echo -e "         Remote set to: https://github.com/${GITHUB_USERNAME}/${REPO_NAME}.git"
else
  echo -e "  ${GREEN}✓ Git repo found${RESET}"
  # ensure remote exists
  if ! git remote get-url origin &> /dev/null; then
    git remote add origin "https://github.com/${GITHUB_USERNAME}/${REPO_NAME}.git"
    echo -e "         Remote added: https://github.com/${GITHUB_USERNAME}/${REPO_NAME}.git"
  fi
fi

# ── Step 3: Stage all files ──
echo -e "  ${AMBER}[3/6]${RESET} Staging files..."
git add -A
CHANGED=$(git diff --cached --name-only | wc -l | tr -d ' ')
if [ "$CHANGED" -eq "0" ]; then
  echo -e "  ${GREEN}✓ No changes detected — already up to date${RESET}"
  echo ""
  echo -e "  ${BOLD}Nothing to deploy. Make some changes first!${RESET}"
  echo ""
  exit 0
fi
echo -e "  ${GREEN}✓ ${CHANGED} file(s) staged${RESET}"

# ── Step 4: Commit ──
echo -e "  ${AMBER}[4/6]${RESET} Committing..."
git commit -m "$COMMIT_MSG"
echo -e "  ${GREEN}✓ Committed: \"${COMMIT_MSG}\"${RESET}"

# ── Step 5: Push to gh-pages ──
echo -e "  ${AMBER}[5/6]${RESET} Pushing to GitHub..."

# check if gh-pages branch exists remotely
if git ls-remote --heads origin "$BRANCH" | grep -q "$BRANCH"; then
  git push origin "HEAD:${BRANCH}"
else
  # first push — create the branch
  git push -u origin "HEAD:${BRANCH}"
fi
echo -e "  ${GREEN}✓ Pushed to ${BRANCH}${RESET}"

# ── Step 6: Done ──
echo -e "  ${AMBER}[6/6]${RESET} Finalizing..."
echo ""
echo -e "  ${BLUE}────────────────────────────────────────${RESET}"
echo -e "  ${GREEN}${BOLD}✓ Deploy complete!${RESET}"
echo ""
echo -e "  ${BOLD}Your site will be live at:${RESET}"
echo -e "  ${BLUE}https://${GITHUB_USERNAME}.github.io/${REPO_NAME}${RESET}"
echo ""
echo -e "  ${AMBER}Note:${RESET} GitHub Pages can take 1–2 minutes to update."
echo -e "  Check status at: https://github.com/${GITHUB_USERNAME}/${REPO_NAME}/actions"
echo ""