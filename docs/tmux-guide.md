# tmux Guide

tmux is a terminal multiplexer: run multiple terminal sessions in one window,
split into panes, and detach/reattach sessions that survive disconnects.

## Prefix Key

All tmux commands start with the **prefix**: `Ctrl-\`

Press `Ctrl-\`, release, then press the command key. For example,
`Ctrl-\ c` means: press `Ctrl-\`, release, then press `c`.

## Sessions

Sessions persist in the background, even if you close your terminal.

| Command | Description |
|---|---|
| `tmux` | Start a new session |
| `tmux new -s name` | Start a named session |
| `tmux attach` / `tmux a` | Attach to last session |
| `tmux a -t name` | Attach to a named session |
| `tmux ls` | List sessions |
| `tmux kill-session -t name` | Kill a named session |
| `Ctrl-\ d` | Detach from current session |
| `Ctrl-\ $` | Rename current session |
| `Ctrl-\ s` | Switch between sessions |

## Windows

Windows are like tabs within a session. They are numbered starting at 1.

| Command | Description |
|---|---|
| `Ctrl-\ c` | Create new window |
| `Ctrl-\ ,` | Rename current window |
| `Ctrl-\ w` | List all windows (interactive picker) |
| `Ctrl-\ n` | Next window |
| `Ctrl-\ p` | Previous window |
| `Ctrl-\ 1-9` | Jump to window by number |
| `Ctrl-\ Ctrl-\` | Toggle to last active window |
| `Ctrl-\ &` | Kill window (confirms first) |

When you close a window, the remaining windows renumber automatically
so there are no gaps.

## Panes

Panes split a window into multiple terminals side by side.

### Splitting

| Command | Description |
|---|---|
| `Ctrl-\ \|` | Split vertically (left/right) |
| `Ctrl-\ -` | Split horizontally (top/bottom) |

New panes open in the same directory as the current pane.

### Navigating

| Command | Description |
|---|---|
| `Ctrl-\ h` | Move left |
| `Ctrl-\ j` | Move down |
| `Ctrl-\ k` | Move up |
| `Ctrl-\ l` | Move right |

### Managing

| Command | Description |
|---|---|
| `Ctrl-\ z` | Zoom/unzoom pane (fullscreen toggle) |
| `Ctrl-\ x` | Kill pane (confirms first) |
| `Ctrl-\ o` | Cycle through panes |
| `Ctrl-\ {` | Swap pane left |
| `Ctrl-\ }` | Swap pane right |
| `Ctrl-\ Space` | Cycle through pane layouts |

### Resizing

Hold the mouse and drag a pane border, or use the command line:

    Ctrl-\ :resize-pane -D 5    " 5 rows down
    Ctrl-\ :resize-pane -U 5    " 5 rows up
    Ctrl-\ :resize-pane -L 10   " 10 columns left
    Ctrl-\ :resize-pane -R 10   " 10 columns right

## Copy Mode (Scrollback)

Copy mode lets you scroll through output and copy text using vi keys.

| Command | Description |
|---|---|
| `Ctrl-\ [` | Enter copy mode |
| `q` | Exit copy mode |
| `j` / `k` | Move down / up |
| `Ctrl-d` / `Ctrl-u` | Half-page down / up |
| `g` / `G` | Jump to top / bottom |
| `/` | Search forward |
| `?` | Search backward |
| `n` / `N` | Next / previous search result |
| `Space` | Start selection |
| `Enter` | Copy selection and exit |
| `Ctrl-\ ]` | Paste |

## Mouse

Mouse support is enabled. You can:

- Click a pane to focus it
- Drag pane borders to resize
- Scroll with the mouse wheel (enters copy mode automatically)
- Select text by clicking and dragging

## Other

| Command | Description |
|---|---|
| `Ctrl-\ r` | Reload tmux config |
| `Ctrl-\ :` | Enter command mode |
| `Ctrl-\ ?` | Show all key bindings |
| `Ctrl-\ t` | Show clock |

## Config

The config file is `~/.tmux.conf`. After editing, reload with `Ctrl-\ r`.
