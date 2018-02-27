if exists("g:loaded_osplugin") || &compatible
    finish
endif
let g:loaded_osplugin = '0.6.0'

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

if !exists('g:linux_filename')
    let g:linux_filename = "linux.vim"
endif

if !exists('g:windows_filename')
    let g:windows_filename = "windows.vim"
endif

if !exists('g:macOS_filename')
    let g:macOS_filename = "macOS.vim"
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

if !exists('g:auto_create_directory')
    let g:auto_create_directory = 0
endif

if !exists('s:osplugin_custom_config')
    let s:osplugin_custom_config = 0
endif
if !exists('s:osplugin_custom_name')
    let s:osplugin_custom_name = ''
endif
" }}}

" Function to Call outside of the autload file {{{1
function! osplugin#begin(...)
    if s:osplugin_custom_config == 1
        call osplugin#main(s:osplugin_custom_name)
        if exists('a:1')
            let s:osplugin_custom_name = a:1
        endif
    elseif exists('a:1')
        let s:osplugin_custom_config = 1
        let s:osplugin_custom_name = a:1
    else
        call osplugin#main()
    endif
endfunction
"  1}}}

" Main Function {{{1
function! osplugin#main(...)
    if g:auto_create_directory
        call osplugin#make_osplugin_directory()
    endif

    if exists('a:1')
        call osplugin#initilize_os(a:1)
    elseif g:linux
        call osplugin#initilize_os(g:linux_filename)
    elseif g:macOS
        call osplugin#initilize_os(g:macOS_filename)
    elseif g:windows
        call osplugin#initilize_os(g:windows_filename)
    elseif g:osplugin_debug
        call osplugin#error(1)
    endif
endfunction
"  1}}}

" Automatic Folder Creation {{{
function! osplugin#make_osplugin_directory()
    if !isdirectory(expand(g:osplugin_dir))
        call mkdir(expand(g:osplugin_dir), 'p')
    endif
endfunction
" }}}

" Automatic File Creation {{{
function! osplugin#make_osplugin_file(os_filename)
    let l:slash = ( (g:windows) ? '\' : '/' )
    if !filereadable(expand(g:osplugin_dir) . l:slash . expand(a:os_filename))
        silent execute 'edit '  . expand(g:osplugin_dir) . l:slash . expand(a:os_filename)
        silent execute 'write ' . expand(g:osplugin_dir) . l:slash . expand(a:os_filename)
        silent execute 'bdelete'
    endif
endfunction
" }}}

" OS Config File Sourcing {{{
function! osplugin#initilize_os(os_filename)
    if g:auto_create_file
        call osplugin#make_osplugin_file(a:os_filename)
    endif

    let l:slash = ( (g:windows) ? '\' : '/' )
    if filereadable(  expand(g:osplugin_dir) . l:slash .expand(a:os_filename) )
        let &runtimepath .= ',' . g:osplugin_dir

        execute 'verbose runtime '
            \. get(split(g:osplugin_dir, l:slash), -1, 'osplugin')
            \. l:slash . expand(a:os_filename)

        " execute 'source ' . expand(g:osplugin_dir) . l:slash . expand(a:os_filename)
    elseif g:osplugin_debug
        call osplugin#error(2, a:os_filename)
    endif
endfunction
" }}}

" Error Function {{{1
function! osplugin#error(error_number, ...)
    if a:error_number == 1
        echoe "Could not determine operating system."
    elseif a:error_number == 2
        echoe "Error 2: Could not source " . a:1 . ". Is the file readable?"
    endif
endfunction
"  1}}}

" vim: set expandtab softtabstop=4 shiftwidth=4 foldmethod=marker:
