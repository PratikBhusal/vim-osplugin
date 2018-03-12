vim-osplugin: Easily source OS-specific configuration files
================================================================================

Table of Contents
--------------------------------------------------------------------------------
- [Installation](#installation)
- [Options](#options)
- [Functions](#functions)
- [FAQ](#faq)
- [Todo](#todo)
- [License](#license)

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
edit out of the box, see the [options](#glinux_filename) section.

**Step 3: Put your OS-specific \*.vim file into the designated directory**

The default directory is `$HOME/.vim/osplugin` on Unix systems and
`$HOME/vimfiles/osplugin` on Windows. If you want to change the directory or
have it automatically generated for you, see the [options](#gosplugin_dir) section.

**Step 4: ???**

Do vim stuff?

**Step 5: Contribute**

It's always a good idea to give back!

Options
--------------------------------------------------------------------------------
After following the installation instructions and (hopefully) don't have any
problems, you should be good to go. If you do face issues or want to customize
how the plugin works, see the rest of this section.

### `g:osplugin_verbose`
If for some reason you do face issues, you should consider enabling this.
Otherwise, leave it to it's default value. With it enabled, you will see
messages telling you how about any potential issues osplugin faced when sourcing
files.

**Default:**
```viml
let g:osplugin_verbose = 0
```

### `g:osplugin_dir`
Location of osplugin directory.

**Default On Windows:**
```viml
let g:osplugin_dir = expand("$HOME/vimfiles/osplugin")
```
**Default On anything else:**
```viml
let g:osplugin_dir = expand("$HOME/.vim/osplugin")
```

### `g:osplugin_auto_create_dir`
By default the user would have to manually create the directory. If you want the
plugin to automatically create the directory, set this to `1`.

**Default:**
```viml
let g:osplugin_auto_create_dir = 0
```

### `g:osplugin_auto_create_file`
By default the user would have to manually create the files for osplugin to
source the configurations. If you want the plugin to automatically create the
files, set this to `1`.

**Default:**
```viml
let g:osplugin_auto_create_file = 0
```

Functions
--------------------------------------------------------------------------------
### `osplugin#init({os_filename})`
Adds {os_filename} to the list of configuration files to source. If
`g:osplugin_auto_create_file` is enabled and {os_filename} is unreadable, then
it also creates a blank file.

For example, if you want to load cygwin and linux specific configurations:

```viml
if g:cygwin
    call osplugin#init('cygwin.vim')
    call osplugin#init('linux.vim')
endif
```

### `osplugin#begin()`
This function is where all the magic happens. It runs all the provided
configuration files from `osplugin#init()`. If `g:osplugin_verbose` is enabled,
it also initializes a variable called `g:osplugin_initilized_files` that stores
which os configuration files were sources.

**Note:** This command is ran automatically and is only recommended to use outside
of its intended purpose for debugging purposes.

FAQ
--------------------------------------------------------------------------------
None (so far).

Todo
--------------------------------------------------------------------------------
- Bugfix on Linux and MacOS
- After directory support

License
--------------------------------------------------------------------------------
MIT License. Copyright © 2017-2018 Pratik Bhusal

[Dein]: https://github.com/Shougo/dein.vim
[Pathogen]: https://github.com/tpope/vim-pathogen
[Plug]: https://github.com/junegunn/vim-plug
[Vundle]: https://github.com/VundleVim/Vundle.vim
