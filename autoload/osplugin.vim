" Plugin configuration variables {{{
let g:osplugin_verbose = get(g:, 'osplugin_verbose' , 0)

let g:osplugin_dir = get(g:, 'osplugin_dir',
        \( ( has('win32') || has('win64') )
            \? expand('$HOME/vimfiles/osplugin')
            \: expand('$HOME/.vim/osplugin')
        \)
    \)

let g:osplugin_auto_create_dir = get(g:, 'osplugin_auto_create_dir', 0)
let g:osplugin_auto_create_os_dir = get(g:, 'osplugin_auto_create_os_dir' , 0)
let g:osplugin_auto_create_os_file = get(g:, 'osplugin_auto_create_os_file' , 0)
" }}}

" Script specific variables {{{
let s:slash = ( ( has('win32') || has('win64') ) ? '\' : '/' )

if g:osplugin_verbose
    let g:osplugin_initilized_files   = []
    let g:osplugin_initilized_folders = []
endif
" }}}

" Initilize os configuration(s) {{{
function! osplugin#init(os)
    if g:osplugin_auto_create_os_file
        call s:make_osplugin_directory()
        call s:make_osplugin_file(a:os . '.vim')
    endif
    if  g:osplugin_auto_create_os_dir
        call s:make_osplugin_directory()
        call s:make_os_directory(a:os)
    endif

    if !filereadable(g:osplugin_dir . s:slash . a:os . '.vim') &&
        \ !isdirectory(g:osplugin_dir . s:slash . a:os)
        if g:osplugin_verbose
            call s:error(1, a:os)
        endif
    else
        if filereadable(g:osplugin_dir . s:slash . a:os . '.vim')
            call s:init_file(g:osplugin_dir . s:slash . a:os . '.vim')
        endif

        if isdirectory(g:osplugin_dir . s:slash . a:os)
            call s:init_folder(g:osplugin_dir . s:slash . a:os)
        endif
    endif
endfunction
" }}}

" Initilize os config file {{{ -------------------------------------------------
function! s:init_file(os_filename)
    execute 'verbose runtime '
        \. get(split(a:osplugin_dir, s:slash), -1, 'osplugin')
        \. s:slash . split(a:os_filename, s:slash)[-1]

    if g:osplugin_verbose
        call add(g:osplugin_initilized_files, a:os_filename)
    endif
endfunction
" Initilize os config file }}} -------------------------------------------------

" Initilize os config folder {{{ -----------------------------------------------
function! s:init_folder(os_folder)
    let &runtimepath .= ',' . a:os_folder

    if g:osplugin_verbose
        call add(g:osplugin_initilized_folders, a:os_folder)
    endif
endf
" Initilize os config folder }}} -----------------------------------------------

" Automatic osplugin folder creation {{{
function! s:make_osplugin_directory()
    if !isdirectory( expand(g:osplugin_dir) )
        call mkdir(expand(g:osplugin_dir), 'p')
    endif
endfunction
" }}}

" Automatic os folder Creation {{{
function! s:make_os_directory(os)
    if !isdirectory( expand(g:osplugin_dir . s:slash . expand(a:os) )
        call mkdir(expand( g:osplugin_dir . s:slash . expand(a:os) ), 'p')
    endif
endfunction
" }}}

" Automatic File Creation {{{
function! s:make_osplugin_file(os_filename)
    if !filereadable( expand(g:osplugin_dir) . s:slash . expand(a:os_filename) )
        silent execute 'edit '  . expand(g:osplugin_dir) . s:slash . expand(a:os_filename)
        silent execute 'write ' . expand(g:osplugin_dir) . s:slash . expand(a:os_filename)
        silent execute 'bdelete'
    endif
endfunction
" }}}

" Error function {{{
function! s:error(error_number, ...)
    if a:error_number == 1
        echoe 'E1: File ' . a:1 . '.vim nor folder ' . a:1 . '/ '
            \. 'is readable or exists'
    endif
endfunction
"  }}}

" vim: set expandtab tabstop=8 softtabstop=4 shiftwidth=4 foldmethod=marker:
