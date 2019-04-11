# Ian's Vim Configuration

![Preview][preview]

## Installation

```
git clone https://github.com/ianding1/ian-nvimrc.git ~/.config/nvim
nvim +PluginInstall +qa
```

This configuration depends on
[vim-plugged][vim-plugged] (which is shipped with
NeoVim) and [universal ctags][uctags].

## Customization

The following three files can be created for customization.
1. ~/.config/nvim/before.local.vim : loaded at the beginning of initialization
2. ~/.config/nvim/plugin.local.vim : extra plugins to use
3. ~/.config/nvim/after.local.vim : loaded at the end of initialization

## Cheatsheet

|  Shortcut/Command  |  Usage                                                            |
|  --------          |  -----                                                            |
|  `<space>f`        |  find files                                                       |
|  `<space>b`        |  find buffers                                                     |
|  `<space>j`        |  find tags                                                        |
|  `<space>cc`       |  comment the line or selected region                              |
|  `<space>c<space>` |  toggle the comment of the line or selected region                |
|  `<space>1`        |  toggle the NERDTree window                                       |
|  `<space>2`        |  toggle the quickfix window                                       |
|  `<space>3`        |  toggle the location window                                       |
|  `<space>u`        |  toggle the UndoTree window                                       |
|  `<alt-u>`         |  scroll up the preview window                                     |
|  `<alt-d>`         |  scroll down the preview window                                   |
|  `p`               |  (Quickfix only) view the item under cursor in the preview window |
|  `P`               |  (Quickfix only) close the preview window                         |
|  `<ctrl-w>z`       |  close the preview window                                         |
|  `[b` `]b`         |  previous/next buffer                                             |
|  `[l` `]l`         |  previous/next location item                                      |
|  `[q` `]q`         |  previous/next quickfix item                                      |
|  `[t` `]t`         |  previous/next tag                                                |
|  `<c-j>`           |  expand the snippet under cursor/next snippet candidate           |
|  `<c-k>`           |  previous snippet candidate                                       |
|  `<ctrl-]>`        |  jump to the tag under cursor                                     |
|  `<ctrl-w>]`       |  jump to the tag under cursor in a new window                     |
|  `<ctrl-w>}`       |  jump to the tag under cursor in the preview window               |
|  `<ctrl-t>`        |  jump to the previous tag in the tag stack                        |
|  `:Ack [pattern]`  |  Search the pattern in the current directory                      |
|  `:Tabularize /\|` |  Align the Markdown table by '|'                                  |
|  `:Tabularize /=`  |  Align the assignments by `=`                                     |

[preview]: https://i.ibb.co/pKVyP3v/Screen-Shot-2019-04-11-at-15-34-48.png
[vim-plugged]: https://github.com/junegunn/vim-plug
[uctags]: https://ctags.io
