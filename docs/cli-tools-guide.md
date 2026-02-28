# CLI Tools Guide

The setup scripts install modern replacements for standard Unix commands
along with additional development tools. Install them with:

- **macOS**: `~/.dotfiles/brew-setup`
- **Ubuntu**: `~/.dotfiles/ubuntu-setup`

## Modern Replacements

These tools replace or improve on their traditional counterparts.

| Traditional | Replacement | What it does better |
|---|---|---|
| `grep` | [`ripgrep`](https://github.com/BurntSushi/ripgrep) (`rg`) | Much faster, respects `.gitignore`, recursive by default |
| `find` | [`fd`](https://github.com/sharkdp/fd) | Simpler syntax, faster, respects `.gitignore` |
| `cat` | [`bat`](https://github.com/sharkdp/bat) | Syntax highlighting, line numbers, git integration |
| `ls` | [`eza`](https://github.com/eza-community/eza) | Colors, icons, git status, tree view built in |
| `man` | [`tldr`](https://github.com/tldr-pages/tldr) | Community-maintained short examples instead of full manpages |
| `top` | [`htop`](https://github.com/htop-dev/htop) | Interactive, color-coded, sortable process viewer |
| Bash prompt | [`starship`](https://starship.rs) | Fast cross-shell prompt with git, language, and context info |

On Ubuntu, some commands have different names due to package conflicts:
- `bat` is installed as `batcat` (aliased to `bat` in the shell config)
- `fd` is installed as `fdfind` (aliased to `fd` in the shell config)

### ripgrep (`rg`)

Search file contents. Replaces `grep -r`.

```sh
rg "pattern"                 # Search current directory recursively
rg "pattern" src/            # Search in a specific directory
rg -i "pattern"              # Case-insensitive search
rg -l "pattern"              # List matching files only
rg -t py "pattern"           # Search only Python files
rg --glob '!test*' "pattern" # Exclude files matching a glob
rg -C 3 "pattern"            # Show 3 lines of context around matches
```

### fd

Find files by name. Replaces `find`.

```sh
fd "pattern"                 # Find files matching pattern
fd -e py                     # Find all Python files
fd -e py -x wc -l            # Find .py files and count lines in each
fd -H "pattern"              # Include hidden files
fd -t d "pattern"            # Find only directories
fd "pattern" src/            # Search in a specific directory
```

### bat

View files with syntax highlighting. Replaces `cat`.

```sh
bat file.py                  # View file with syntax highlighting
bat -n file.py               # Show line numbers only (no decorations)
bat -l json < data           # Force a specific language for piped input
bat --diff file.py           # Show git diff alongside file content
bat -A file.py               # Show non-printable characters
```

### eza

List files. Replaces `ls`.

```sh
eza                          # Simple listing with color
eza -l                       # Long format
eza -la                      # Long format with hidden files
eza --tree                   # Recursive tree view
eza --tree --level=2         # Tree view limited to 2 levels
eza -l --git                 # Long format with git status per file
eza --icons                  # Show file type icons (needs Nerd Font)
```

### fzf

Interactive fuzzy finder. Pipes into any workflow.

```sh
# Find and open a file
vim $(fzf)

# Search command history interactively (Ctrl-R uses fzf if installed)
history | fzf

# Preview files while browsing
fzf --preview 'bat --color=always {}'

# Find and checkout a git branch
git branch | fzf | xargs git checkout

# Find a process to kill
ps aux | fzf | awk '{print $2}' | xargs kill
```

### htop

Interactive process viewer. Replaces `top`.

```sh
htop                         # Launch interactive viewer
```

Inside htop: `F5` for tree view, `F6` to sort, `/` to search,
`F9` to kill, `q` to quit.

### tldr

Simplified command examples. Complements `man`.

```sh
tldr tar                     # Quick examples for tar
tldr git commit              # Quick examples for git commit
```

## GNU Coreutils (macOS)

On macOS, the setup installs GNU versions of core utilities via Homebrew
to match Linux behavior. These are added to `PATH` ahead of the BSD
versions:

| Package | Provides |
|---|---|
| `coreutils` | `ls`, `cp`, `mv`, `rm`, `sort`, `cut`, `head`, `tail`, etc. |
| `grep` | GNU `grep` (supports `-P` for Perl regexes) |
| `gnu-sed` | GNU `sed` (supports `-i` without backup extension) |
| `gawk` | GNU `awk` |
| `findutils` | GNU `find` and `xargs` |
| `diffutils` | GNU `diff` and `cmp` |

This means flags like `ls --color=auto`, `sed -i ''` vs `sed -i`,
and `grep -P` work the same on macOS as on Linux.

## Development Tools

| Tool | Description |
|---|---|
| [`jq`](https://jqlang.github.io/jq/) | JSON processor for the command line |
| [`shellcheck`](https://www.shellcheck.net/) | Static analysis for shell scripts |
| [`shfmt`](https://github.com/mvdan/sh) | Shell script formatter |
| [`gh`](https://cli.github.com/) | GitHub CLI for PRs, issues, repos |
| [`tree`](https://github.com/Old-Man-Programmer/tree) | Display directory trees |
| [`wget`](https://www.gnu.org/software/wget/) | Download files from the web |
| [`watch`](https://gitlab.com/procps-ng/procps) | Run a command repeatedly and watch the output |

### jq

Parse and transform JSON.

```sh
echo '{"name":"val"}' | jq .name     # Extract a field
cat data.json | jq '.items[].id'     # Extract from array
curl -s api/endpoint | jq .          # Pretty-print API response
```

### shellcheck

Lint shell scripts.

```sh
shellcheck script.sh                  # Check a script for issues
shellcheck -e SC2086 script.sh        # Ignore a specific rule
```

## Zsh Plugins

| Plugin | Description |
|---|---|
| `zsh-autosuggestions` | Grey inline suggestions from history (Right arrow to accept) |
| `zsh-syntax-highlighting` | Live syntax coloring as you type |
| `zsh-completions` | Additional completion definitions |
