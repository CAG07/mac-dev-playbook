# mac-dev-playbook
Mac setup and config using Brew and Ansible

## Scripts

```
./scripts/brew_upgrade_cleanup.sh
```
Prompts for confirmation, then runs `brew update`, `brew upgrade`, `brew cleanup`, and `brew doctor`.

<br>

```
`scripts/brew_upgrade_prompt.sh`
```
Opens `brew_upgrade_cleanup.sh` in an iTerm2 tab (reusing the current window if one's open, otherwise a new window). Falls back to Terminal.app if iTerm2 isn't installed. Intended to be triggered on a schedule (e.g. cron) so maintenance is offered periodically without running unattended.

If you use a different terminal app (Warp, Kitty, Alacritty, etc.) instead of iTerm2, the prompt will still open — just in Terminal.app rather than your usual terminal, since that's the only other app this script targets.

#### Scheduling with cron
Add a line like this to your crontab (`crontab -e`), using the absolute path to `brew_upgrade_prompt.sh` on your machine. This example runs at 9am on January 1 and July 1 (every ~6 months):

```
0 9 1 1,7 * /path/to/mac-dev-playbook/scripts/brew_upgrade_prompt.sh
```

> **Note:** macOS may require granting `cron`/iTerm2 Automation and Full Disk Access permissions (System Settings → Privacy & Security) the first time this runs. If it doesn't fire reliably, a `launchd` LaunchAgent is a more robust macOS-native alternative.
