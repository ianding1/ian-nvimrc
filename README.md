# Ian's Vim Configuration

## Installation

```
git clone https://github.com/iandingx/ian-nvimrc.git ~/.config/nvim
nvim +PluginInstall +qa
```

There will be a warning that the colorscheme gruvbox is not found when
starting Vim. It can be safely ignored, for gruvbox is about to be installed
by that command.

Furthermore, this vim configuration requires the following external programs:

1. universal-ctags: required.
2. gtags: optional.

This configuration should be used with vim-plugged.

## Customization

The following three files can be created for customization. They are ignored by Git:
1. ~/.config/nvim/before.local.vim : loaded at the beginning of startup
2. ~/.config/nvim/plugin.local.vim : extra plugins to use
3. ~/.config/nvim/after.local.vim : loaded at the end of startup

## Cheatsheet

Many plugins are bundled in this configuration. Hence it is a good idea to
collect the shortcuts and commands into this cheatsheet for convenience.

### Shortcuts

| Shortcut | Mode | Plugin | Usage |
| -------- | ---- | ------ | ----- |
| `<space>` `f` | N | LeaderF | recursively list files |
| `<space>` `b` | N | LeaderF | list buffers |
| `<space>` `r` | N | LeaderF | list recent files |
| `<space>` `c` | N | vim-togglelist | toggle quickfix window |
| `<space>` `l` | N | vim-togglelist | toggle location window |
| `<space>` `u` | N | undotree | toggle undo tree |
| `<space>` `*` | N | ack.vim | ack the word under the cursor |
| `<alt-]>` | N | vim-preview | go to tag in preview window |
| `<alt-u>` | N I | vim-preview | scroll up in preview window |
| `<alt-d>` | N I | vim-preview | scroll down in preview window |
| `p` | in quickfix | vim-preview | open the item in preview window |
| `P` | in quickfix | vim-preview | close the preview window |
| `<ctrl-w>` `z` | N | vim | close the preview window |
| `[a` ... [1] | N | unimpaired | previous/next/first/last argument |
| `[b` ... | N | unimpaired | previous/next/first/last buffer |
| `[l` ... | N | unimpaired | previous/next/first/last location |
| `[q` ... | N | unimpaired | previous/next/first/last quickfix item |
| `[t` ... | N | unimpaired | previous/next/first/last tag |
| `[<ctrl-t>` ... | N | unimpaired | previous/next tag in preview |
| `[h` ... | N | git-gutter | previous/next hunk |
| `<c-j>` | I | ultisnips | expand snippet / next snippet candidate |
| `<c-k>` | I | ultisnips | previous snippet candidate |
| `<space>` `s` `e` | N | ultisnips | edit the snippet file of this file type|
| `<space>` `s` `a` | N | ultisnips | add file types |
| `x` and `X` | far | far.vim | exclude this line / exclude all lines |
| `i` and `I` | far | far.vim  buffer | add this line / add all lines |
| `t` and `T` | far | far.vim  buffer | toggle this line / toggle all lines |
| `<ctrl-]>` | N | vim | jump to the tag |
| `<ctrl-w>` `]` | N | vim | jump to the tag in new window |
| `<ctrl-w>` `}` | N | vim | jump to the tag in preview window |
| `<ctrl-t>` | N | vim | jump to the previous tag in stack |
| `<space>` `c` `s` | N | gutentags\_plus | Cscope search: symbol |
| `<space>` `c` `g` | N | gutentags\_plus | Cscope search: definition |
| `<space>` `c` `d` | N | gutentags\_plus | Cscope search: called by this function |
| `<space>` `c` `c` | N | gutentags\_plus | Cscope search: calling this function |
| `<space>` `c` `t` | N | gutentags\_plus | Cscope search: text string |
| `<space>` `c` `e` | N | gutentags\_plus | Cscope search: egrep pattern |
| `<space>` `c` `f` | N | gutentags\_plus | Cscope search: file |
| `<space>` `c` `i` | N | gutentags\_plus | Cscope search: file #including this file |
| `<space>` `c` `a` | N | gutentags\_plus | Cscope search: where this symbol is assigned a value |

### Commands

| Command | Plugin | Usage |
| ------- | ------ | ----- |
| `:Ack! [pattern]` | ack.vim | Search recursively the pattern |
| `:Far <pattern> <replace> <filepattern>` | far.vim | Find the text to replace |
| `:Fardo` | far.vim | Do the replacement |
| `:IronPromptRepl` | iron.nvim | Prompt the REPL and open it in terminal |
| `:IronRepl` | iron.nvim | open a REPL of current file type in terminal |
| `:GscopeFind [0\|s] <name>` | gutentags\_plus | Cscope search: symbol |
| `:GscopeFind [1\|g] <name>` | gutentags\_plus | Cscope search: definition |
| `:GscopeFind [2\|d] <name>` | gutentags\_plus | Cscope search: called by this function |
| `:GscopeFind [3\|c] <name>` | gutentags\_plus | Cscope search: calling this function |
| `:GscopeFind [4\|t] <name>` | gutentags\_plus | Cscope search: text string |
| `:GscopeFind [6\|e] <name>` | gutentags\_plus | Cscope search: egrep pattern |
| `:GscopeFind [7\|f] <name>` | gutentags\_plus | Cscope search: file |
| `:GscopeFind [8\|i] <name>` | gutentags\_plus | Cscope search: file #including this file |
| `:GscopeFind [9\|a] <name>` | gutentags\_plus | Cscope search: where this symbol is assigned a value |

[1]: `[a` ... means `[a`, `]a`, `[A` and `]A`, and likewise.
