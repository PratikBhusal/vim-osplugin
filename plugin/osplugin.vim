" Linux Checks {{{1
if !exists('g:linux')
    let g:linux = has('unix') && !has('macunix') && !has('win32unix')
endif
"  1}}}

" MacOS Checks {{{1
if !exists('g:macOS')
    let g:macOS = has('macunix')
endif
"  1}}}

" Windows Checks {{{1
if !exists('g:windows')
    let g:windows = has('win32') || has('win64')
endif
"  1}}}

" OS Filename Settings {{{
if !exists('g:linux_filename')
    let g:linux_filename = "linux.vim"
endif

if !exists('g:macOS_filename')
    let g:macOS_filename = "macOS.vim"
endif

if !exists('g:windows_filename')
    let g:windows_filename = "windows.vim"
endif
" }}}

" Directory Settings {{{1
if !exists('g:auto_create_directory')
    let g:auto_create_directory = 0
endif

if !exists('g:osplug_dir')
    let g:osplug_dir = expand("$HOME/.vim/osplugin")
endif

if g:auto_create_directory && !isdirectory(expand(g:osplug_dir))
    call mkdir(expand(g:osplug_dir), "p")
endif
"  1}}}

" File Sourcing Settings {{{
if g:linux && filereadable(expand(g:osplug_dir) . "\/" . expand(g:windows_filename))
    execute "source" expand(g:osplug_dir) . "\\" . expand(g:windows_filename)
endif
if g:macOS && filereadable(expand(g:osplug_dir) . "\/" . expand(g:windows_filename))
    execute "source" expand(g:osplug_dir) . "\/" . expand(g:windows_filename)
endif
if g:windows && filereadable(expand(g:osplug_dir) . "\/" . expand(g:windows_filename))
    execute "source" expand(g:osplug_dir) . "\/" . expand(g:windows_filename)
endif
" }}}
