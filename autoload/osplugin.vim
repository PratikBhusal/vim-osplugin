if exists("g:loaded_osplugin") || &compatible
  finish
endif
let g:loaded_osplugin = "0.4.0"
let s:keepcpo         = &cpo
set cpo&vim

" Global Variables {{{
if !exists('g:osplugin_debug')
    let g:osplugin_debug = 0
endif

if !exists('g:linux')
    let g:linux = has('unix') && !has('macunix') && !has('win32unix')
endif

if !exists('g:windows')
    let g:windows = has('win32') || has('win64')
endif

if !exists('g:macOS')
    let g:macOS = has('macunix')
endif

if !exists('g:auto_create_directory')
    let g:auto_create_directory = 0
endif

if !exists('g:auto_create_file')
    let g:auto_create_file = 0
endif

if !exists('g:osplugin_dir')
    if g:windows
        let g:osplugin_dir = expand("$HOME/vimfiles/osplugin")
    else
        let g:osplugin_dir = expand("$HOME/.vim/osplugin")
    endif
endif

if !exists('g:linux_filename')
    let g:linux_filename = "linux.vim"
endif

if !exists('g:windows_filename')
    let g:windows_filename = "windows.vim"
endif



if !exists('g:macOS_filename')
    let g:macOS_filename = "macOS.vim"
endif
" }}}

" Main Function {{{1
function! osplugin#initilize()
    if g:auto_create_directory
        call osplugin#make_osplugin_directory()
    endif

    if g:linux
        call osplugin#initilize_linux()
    elseif g:macOS
        call osplugin#initilize_macOS()
    elseif g:windows
        call osplugin#initilize_windows()
    elseif g:osplugin_debug
        call osplugin#error(1)
    endif
endfunction
"  1}}}

" Automatic Folder Creation {{{
function! osplugin#make_osplugin_directory()
    if !isdirectory(expand(g:osplugin_dir))
        call mkdir(expand(g:osplugin_dir), "p")
    endif
endfunction
" }}}

" Automatic File Creation {{{
function! osplugin#make_osplugin_file(os_filename)
    if !filereadable(expand(g:osplugin_dir) . "\/" . expand(a:os_filename))
        silent execute "edit " . expand(g:osplugin_dir) . "\/" . expand(a:os_filename)
        silent execute "write " . expand(g:osplugin_dir) . "\/" . expand(a:os_filename)
        silent execute "bdelete"
    endif
endfunction
" }}}

" Linux Settings {{{1
function! osplugin#initilize_linux()
    if g:auto_create_file
        call osplugin#make_osplugin_file(g:linux_filename)
    endif

    if filereadable(expand(g:osplugin_dir) . "\/" . expand(g:linux_filename))
        execute "source " . expand(g:osplugin_dir) . "\/" . expand(g:linux_filename)
    elseif g:osplugin_debug
        call osplugin#error(2)
    endif
endfunction
"  1}}}

" Windows Settings {{{1
function! osplugin#initilize_windows()
    if g:auto_create_file
        call osplugin#make_osplugin_file(g:windows_filename)
    endif

    if filereadable(expand(g:osplugin_dir) . "\/" . expand(g:windows_filename))
        execute "source " . expand(g:osplugin_dir) . "\/" . expand(g:windows_filename)
    elseif g:osplugin_debug
        call osplugin#error(2)
    endif
endfunction
"  1}}}

" MacOS Settings {{{1
function! osplugin#initilize_macOS()
    if g:auto_create_file
        call osplugin#make_osplugin_file(g:macOS_filename)
    endif

   if g:macOS && filereadable(expand(g:osplugin_dir) . "\/" . expand(g:macOS_filename))
        execute "source " . expand(g:osplugin_dir) . "\/" . expand(g:macOS_filename)
    elseif g:osplugin_debug
        call osplugin#error(2)
    endif
endfunction
"  1}}}

" Error Function {{{1
function! osplugin#error(error_number)
    if a:error_number == 1
        echo "Error 1: Could not determine operating system.\n"
    elseif a:error_number == 2
        echo "Error 2: Could not source the config file. Is the file readable?"
    endif
endfunction
"  1}}}

let &cpo= s:keepcpo
unlet s:keepcpo
