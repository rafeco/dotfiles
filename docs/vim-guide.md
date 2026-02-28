# Vim Guide

This config targets Vim 8+ and Neovim with sensible defaults
for modern development. No plugins required.

## Appearance

- Color scheme: **desert** on a dark background
- True color (24-bit) enabled when the terminal supports it
- Line numbers: **hybrid** (absolute on current line, relative on others)
- Cursor line highlighted
- Status line always visible

### Status Line

```
 1 filename.py [+][python]           12,45/200 22%
 ^     ^        ^    ^                ^    ^    ^
 |     |        |    |                |    |    |
buf  name   modified filetype       col line  pct
```

## Indentation

Default: **2 spaces**, tabs expanded to spaces.

Per-language overrides:

| Language | Indent |
|---|---|
| Python, PHP, Java, JavaScript | 4 spaces |
| TypeScript, JSON, YAML, Scala | 2 spaces |
| Markdown | Wraps at word boundaries |

Trailing whitespace is stripped automatically on save.

## Navigation

### Finding Files

| Command | Description |
|---|---|
| `:find filename` | Search recursively from project root |
| `:e path/to/file` | Open a file by path |

Completion ignores `node_modules`, `.git`, `__pycache__`, `.class`, and `.pyc` files.

### Tags (ctags)

If a `tags` file exists, you can jump to definitions:

| Command | Description |
|---|---|
| `Ctrl-]` | Jump to definition under cursor |
| `Ctrl-t` | Jump back |
| `:tag name` | Jump to a tag by name |

Vim searches for `tags` files up the directory tree.

## Search

| Setting | Behavior |
|---|---|
| `/pattern` | Highlights all matches, jumps as you type |
| Case | Case-insensitive unless pattern has uppercase |
| `Ctrl-L` | Clear search highlights (and redraw screen) |
| `n` / `N` | Next / previous match |
| `*` / `#` | Search for word under cursor forward / backward |

## Editing

### Motions Quick Reference

| Key | Motion |
|---|---|
| `w` / `b` | Forward / back by word |
| `e` | End of word |
| `0` / `$` | Start / end of line |
| `gg` / `G` | Top / bottom of file |
| `{` / `}` | Previous / next blank line |
| `%` | Matching bracket |

### Common Operations

| Command | Description |
|---|---|
| `dd` | Delete line |
| `yy` | Copy (yank) line |
| `p` / `P` | Paste after / before cursor |
| `ciw` | Change inner word |
| `ci"` | Change inside quotes |
| `>>`  / `<<` | Indent / unindent line |
| `.` | Repeat last change |
| `u` / `Ctrl-R` | Undo / redo |

### Persistent Undo

Undo history is saved to `~/.vim/undo/` and persists across sessions.
You can undo changes even after closing and reopening a file.

## Windows & Splits

| Command | Description |
|---|---|
| `:sp` | Horizontal split (opens below) |
| `:vsp` | Vertical split (opens right) |
| `Ctrl-w h/j/k/l` | Navigate between splits |
| `Ctrl-w =` | Equalize split sizes |
| `Ctrl-w _` | Maximize current split height |
| `Ctrl-w \|` | Maximize current split width |
| `:q` | Close current split |
| `:only` | Close all other splits |

New splits open below (horizontal) and to the right (vertical).

## Buffers

Buffers can be switched without saving (hidden buffers enabled).

| Command | Description |
|---|---|
| `:ls` | List open buffers |
| `:b name` | Switch to buffer (tab-completes) |
| `:bn` / `:bp` | Next / previous buffer |
| `:bd` | Close buffer |

## Tabs

Up to 50 tabs supported.

| Command | Description |
|---|---|
| `:tabnew` | New tab |
| `gt` / `gT` | Next / previous tab |
| `:tabclose` | Close tab |

## Mouse

Mouse is enabled in all modes. You can click to position the cursor,
select text, drag to resize splits, and scroll.

## Completion

| Key | Description |
|---|---|
| `Ctrl-n` / `Ctrl-p` | Next / previous completion match |
| `Ctrl-x Ctrl-f` | Complete file paths |
| `Ctrl-x Ctrl-l` | Complete whole lines |

Tab in command mode (`:`) opens the wildmenu with longest-match-first
completion. Filename completion is case-insensitive.

## Command Mode

| Command | Description |
|---|---|
| `:w` | Save |
| `:q` | Quit |
| `:wq` | Save and quit |
| `:x` | Save and quit (only writes if changed) |
| `:%s/old/new/g` | Replace all in file |
| `:%s/old/new/gc` | Replace all with confirmation |
| `:!command` | Run a shell command |
| `:r !command` | Insert shell command output |

## Templates

New `.py` files are auto-populated from `~/.vim/skel/skeleton.py`
if that file exists.

## GUI Settings (MacVim / GVim)

When running in a GUI:
- Font: Fira Code 16pt
- No toolbar or scrollbars
- Default window: 120 columns x 50 lines

## Codespaces

In GitHub Codespaces, swap and backup files are disabled for
better performance with cloud storage.
