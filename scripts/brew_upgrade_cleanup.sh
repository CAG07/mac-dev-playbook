#!/usr/bin/env bash
#
# Interactively runs the routine Homebrew maintenance commands:
#   brew update, brew upgrade, brew cleanup, brew doctor
#
# Prompts for confirmation before doing anything, so it's safe to trigger
# from cron/launchd without risking an unattended run.

set -euo pipefail

# Ensure brew is on PATH even in a non-login shell (e.g. launched directly
# by a cron/AppleScript trigger rather than an interactive login session).
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:/usr/local/bin:/usr/local/sbin:$PATH"

cat <<'BANNER'
==========================================================
 Homebrew maintenance reminder:

 This runs on a cron job every 6 months:
 brew update
 brew upgrade
 brew cleanup
 brew doctor
==========================================================
BANNER

read -r -p "Run brew update/upgrade/cleanup/doctor now? [y/N] " confirm
case "$confirm" in
  y|Y|yes|YES)
    ;;
  *)
    echo "Aborted."
    read -r -p "Press Enter to close this window... "
    exit 0
    ;;
esac

echo "==> brew update"
brew update

echo "==> brew upgrade"
brew upgrade

echo "==> brew cleanup"
brew cleanup

echo "==> brew doctor"
brew doctor || true

echo "==> Done."
read -r -p "Press Enter to close this window... "
