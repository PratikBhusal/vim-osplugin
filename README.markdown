vim-osplugin: Easily source OS-specific configuration files
================================================================================

Table of Contents
--------------------------------------------------------------------------------
- [Installation](#installation)
- [Feature Summary](#feature-summary)
- [Todo](#todo)
- [Options](#options)
- [Functions](#functions)
- [Custom File Sourcing](#custom-file-sourcing)
- [FAQ](#faq)
- [License](#license)

Feature Summary
--------------------------------------------------------------------------------

Installation
--------------------------------------------------------------------------------
**Step 1: Install the plugin with your preferred plugin manager**

| Plugin Manager | Install with... |
| -------------- | --------------- |
| [Dein]     | `call dein#add('PratikBhusal/vim-osplugin')` |
| [Pathogen] | `git clone https://github.com/PratikBhusal/vim-osplugin ~/.vim/bundle/vim-osplugin`|
| [Plug]     | `Plug 'PratikBhusal/vim-osplugin'`           |
| [Vundle]   | `Plugin 'PratikBhusal/vim-osplugin'`         |
| Manual     | Put the files into your `~/.vim` directory   |

**Step 2: Put your os-specific configurations into a \*.vim file**

By default, the filenames will be windows.vim, macOS.vim, and linux.vim. If you
want to change the names or have the files automatically generated for you to
edit out of the box, see the [options](#options) section.

**Step 3: Put your OS-specific \*.vim file into the designated directory**

By default, the default directory is `$HOME/.vim/osplugin` on Unix systems and
`$HOME/vimfiles/osplugin` on Windows. If you want to change the directory or
have it automatically generated for you, see the [options](#options) section. If
your OS of choice is not recognized by default, see the [custom file sourcing](
#custom-file-sourcing) section on how to fix the issue.

**Step 4: ???**

Do vim stuff?

**Step 5: Contribute**

It's always a good idea to give back!

Options
--------------------------------------------------------------------------------
After following the isntallation instructions and (hopefully) don't have any
problems, you should be good to go. If you do face issues or want to customize
how the plugin works, see the rest of this section.

### `g:osplugin_debug`
If for some reason you do face issues, you should consider enabling it.
Otherwise, leave it to it's default value. With it enabled, you will see
messages telling you how the plugin initilzation process went. It's fairly basic
so far, but I plan to improve on it once I get a better understanding of vim
script.

**Default:**
```viml
let g:osplugin_debug = 0
```

### `g:linux`
(Insert text here)

**Default:**
```viml
let g:osplugin_debug = has('unix') && !has('macunix') && !has('win32unix')
```

### `g:windows`
(Insert text here)

**Default:**
```viml
let g:windows = has('win32') || has('win64')
```

### `g:macOS`
(Insert text here)

**Default:**
```viml
let g:macOS = has('macunix')
```

### `g:linux_filename`
(Insert text here)

**Default:**
```viml
let g:linux_filename = "linux.vim"
```

### `g:windows_filename`
(Insert text here)

**Default:**
```viml
let g:windows_filename = "windows.vim"
```

### `g:macOS_filename`
(Insert text here)

**Default:**
```viml
let g:macOS_filename = "macOS.vim"
```

### `g:auto_create_file`
(Insert text here)

**Default:**
```viml
let g:auto_create_file = 0
```

### `g:osplugin_dir`
(Insert text here)

**Default (On Unix Systems):**
```viml
let g:osplugin_dir = expand("$HOME/.vim/osplugin")
```

**Default (On Windows):**
```viml
let g:osplugin_dir = expand("$HOME/vimfiles/osplugin")
```

### `g:auto_create_directory`
(Insert text here)

**Default:**
```viml
let g:auto_create_directory = 0
```

Functions
--------------------------------------------------------------------------------

Custom File Sourcing
--------------------------------------------------------------------------------

FAQ
--------------------------------------------------------------------------------
None (so far).

Todo
--------------------------------------------------------------------------------
- Bugfix on Linux and MacOS
- Add documentation
- Complete remaining README sections

License
--------------------------------------------------------------------------------
MIT License. Copyright © 2017 Pratik Bhusal & Contributors.

[Dein]: https://github.com/Shougo/dein.vim
[Pathogen]: https://github.com/tpope/vim-pathogen
[Plug]: https://github.com/junegunn/vim-plug
[Vundle]: https://github.com/VundleVim/Vundle.vim
