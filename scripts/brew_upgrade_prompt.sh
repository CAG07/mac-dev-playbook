#!/usr/bin/env bash
#
# Meant to be triggered by cron/launchd on a schedule. Opens brew_upgrade_cleanup.sh
# in an iTerm2 tab (reusing the current window if one is open), which then prompts
# the user before doing anything — so a scheduled check-in never runs unattended or
# interrupts other work happening in the current terminal. Falls back to Terminal.app
# (bundled with every Mac) if iTerm2 isn't installed.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET="$SCRIPT_DIR/brew_upgrade_cleanup.sh"

# brew_upgrade_cleanup.sh pauses for Enter at the end, so this tab/window
# stays open for review instead of closing the moment the script exits.
CMD="\"$TARGET\""
ESCAPED_CMD=$(printf '%s' "$CMD" | sed 's/\\/\\\\/g; s/"/\\"/g')

if osascript -e 'id of application "iTerm"' >/dev/null 2>&1; then
  osascript <<EOF
tell application "iTerm"
    activate
    if (count of windows) = 0 then
        create window with default profile command "$ESCAPED_CMD"
    else
        tell current window
            create tab with default profile command "$ESCAPED_CMD"
        end tell
    end if
end tell
EOF
else
  osascript <<EOF
tell application "Terminal"
    activate
    do script "$ESCAPED_CMD"
end tell
EOF
fi
