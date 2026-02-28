# Shell Guide (Zsh & Bash)

Both shells share the same aliases, functions, and general workflow.
Zsh is the primary shell and has additional features noted below.

## Aliases

### File Listing

| Alias | Expands To | Description |
|---|---|---|
| `ls` | `ls --color=auto` | Colorized listing |
| `ll` | `ls -lah` | Long format, all files, human sizes |
| `la` | `ls -A` | All files except `.` and `..` |
| `l` | `ls -CF` | Columns with type indicators |

### Navigation

| Alias | Description |
|---|---|
| `..` | Up one directory |
| `...` | Up two directories |
| `....` | Up three directories |
| `cdp` | Previous directory (`cd -`) |

Zsh only: type a directory name without `cd` to enter it (AUTO_CD).

### Directory Stack (Zsh)

Zsh pushes every `cd` onto a directory stack automatically.

| Command | Description |
|---|---|
| `d` | Show last 10 directories in the stack |
| `1` .. `9` | Jump to that stack entry |

### Git

| Alias | Command |
|---|---|
| `gs` | `git status` |
| `ga` | `git add` |
| `gc` | `git commit` |
| `gd` | `git diff` |
| `gl` | `git log --oneline --decorate --graph` |
| `gp` | `git push` |
| `gpl` | `git pull` |

### History & Utilities

| Alias | Description |
|---|---|
| `h` | Show history |
| `hg` | Search history (`history \| grep`) |
| `c` | Clear screen |
| `now` | Print current timestamp |
| `today` | Print today's date |

### Safety

`rm`, `cp`, and `mv` all prompt before overwriting/deleting (`-i` flag).

### System & Network

| Alias | Description |
|---|---|
| `df` | Disk free (human-readable) |
| `du` | Disk usage (human-readable) |
| `ports` | Show open ports |
| `myip` | Show public IP address |

### macOS Only

| Alias | Description |
|---|---|
| `showfiles` / `hidefiles` | Toggle hidden files in Finder |
| `afk` | Lock screen |
| `brewup` | Update, upgrade, and clean Homebrew |

### Linux Only

| Alias | Description |
|---|---|
| `update` | `apt-get update && upgrade` |
| `install` | `apt-get install` |

### Editing

| Alias | Description |
|---|---|
| `zshrc` | Open `~/.zshrc` in your editor |
| `reload` | Re-source `~/.zshrc` |

## Functions

Defined in `~/.shell_functions`, available in both bash and zsh.

| Function | Usage | Description |
|---|---|---|
| `mkcd` | `mkcd new-dir` | Create a directory and cd into it |
| `extract` | `extract archive.tar.gz` | Auto-detect and extract any archive format |
| `psgrep` | `psgrep nginx` | Search running processes by name |
| `search` | `search config` | Find files matching a name pattern |
| `venv` | `venv` | Toggle Python venv (activate, deactivate, or create) |

## GitHub Account Switching

Configured via `~/.gh-accounts`. Each account gets a `gh-<name>` command
generated automatically at shell startup.

| Command | Description |
|---|---|
| `gh-personal` | Switch to personal GitHub account |
| `gh-work` | Switch to work GitHub account |
| `gh-whoami` | Show current GitHub and git identity |
| `gist` | Shortcut for `gh gist` |

Run `gh-setup` to configure accounts interactively.

## Key Bindings

### Zsh

Zsh uses emacs-style line editing by default.

| Key | Action |
|---|---|
| `Up` / `Down` | Search history filtered by current input |
| `Ctrl-R` | Reverse search history |
| `Ctrl-Left` / `Ctrl-Right` | Jump by word |
| `Home` / `End` | Beginning / end of line |
| `Delete` | Delete character under cursor |

### Bash

| Key | Action |
|---|---|
| `Ctrl-R` | Reverse search history |
| `Tab` | Complete (shows all matches on first press) |

Tab completion is case-insensitive in both shells.

## History

Both shells keep 10,000 commands in memory and 20,000 on disk.

- Commands starting with a space are not saved (useful for secrets)
- Duplicates are removed
- Zsh shares history across all open sessions in real time
- Bash appends to history (no cross-session sharing)

## Zsh-Specific Features

- **Spelling correction**: mistyped commands prompt a suggestion
- **Extended globbing**: `ls **/*.py` (recursive), `ls ^*.txt` (negation)
- **Menu completion**: arrow keys to navigate completion options
- **Plugins** (if installed):
  - `zsh-autosuggestions` - greyed-out suggestions from history (press Right to accept)
  - `zsh-syntax-highlighting` - live syntax coloring as you type

## Prompt

Uses [Starship](https://starship.rs) if installed (`brew install starship`),
configured via `~/.config/starship.toml`. Falls back to a built-in prompt
showing `user@host:directory (git-branch)`.

## Pager

`less` is configured with:
- `-R` - show ANSI colors
- `-F` - quit if output fits on one screen
- `-X` - don't clear screen on exit

## Local Overrides

Machine-specific settings (API keys, work paths, etc.) go in:
- `~/.zshrc.local` (zsh)
- `~/.bashrc.local` (bash)

These files are not tracked in the dotfiles repo.
