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
#### Step 1: Install the plugin with your preferred plugin manager
| Plugin Manager | Install with... |
| -------------- | --------------- |
| [Dein]     | `call dein#add('PratikBhusal/vim-osplugin')` |
| [Pathogen] | `git clone https://github.com/PratikBhusal/vim-osplugin ~/.vim/bundle/vim-osplugin`|
| [Plug]     | `Plug 'PratikBhusal/vim-osplugin'`           |
| [Vundle]   | `Plugin 'PratikBhusal/vim-osplugin'`         |
| Manual     | Put the files into your `~/.vim` directory   |

#### Step 2: Put your os-specific configurations into a \*.vim file
By default, the filenames will be windows.vim, macOS.vim, and linux.vim. If you
want to change the names or have the files automatically generated for you to
edit out of the box, see the [options](#options) section.

#### Step 3: Put your OS-specific \*.vim file into the designated directory
By default, the default directory is `$HOME/.vim/osplugin` on Unix systems and
`$HOME/vimfiles/osplugin` on Windows. If you want to change the directory or
have it automatically generated for you, see the [options](#options) section. If
your OS of choice is not recognized by default, see the [custom file sourcing](
#custom-file-sourcing) section on how to fix the issue.

#### Step 4: ???
Do vim stuff?

#### Step 5: Contribute
It's always a good idea to give back!


Options
--------------------------------------------------------------------------------

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
