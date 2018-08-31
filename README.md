# Ian's Vim Configuration

## Installation

```
git clone https://github.com/iandingx/ian-nvimrc.git ~/.config/nvim
nvim +PluginInstall +qa
```

There will be a warning that the colorscheme gruvbox is not found when
starting Vim. It can be safely ignored, for gruvbox is about to be installed
by that command.

## Cheatsheet

Many plugins are bundled in this configuration. Hence it is a good idea to
collect the shortcuts and commands into this cheatsheet for convenience.

### Shortcuts

`[N]` means the shortcut works in the Normal mode.  And `[I]` means the
shortcut works in the Insert mode.

| Shortcut | Mode | Plugin | Usage |
| -------- | ---- | ------ | ----- |
| `<space>` `f` | N | LeaderF | recursively list files |
| `<space>` `b` | N | LeaderF | list buffers |
| `<space>` `r` | N | LeaderF | list recent files |
| `<space>` `F` | N | LeaderF | list functions in this file |

### Commands
