" Plugin Configuration Variables {{{
let g:osplugin_verbose = get(g:, 'osplugin_verbose' , 0)

let g:osplugin_dir = get(g:, 'osplugin_dir',
        \( ( has('win32') || has('win64') )
            \? expand('$HOME/vimfiles/osplugin')
            \: expand('$HOME/.vim/osplugin')
        \)
    \)

let g:osplugin_auto_create_dir = get(g:, 'osplugin_auto_create_dir', 0)

let g:osplugin_auto_create_file = get(g:, 'osplugin_auto_create_file' , 0)
" }}}

" Script Specific Variables {{{
let s:files_to_initilize = []
let s:slash = ( ( has('win32') || has('win64') ) ? '\' : '/' )

if g:osplugin_verbose
    let g:osplugin_initilized_files = []
endif
" }}}

" Select which files to source {{{
function! osplugin#init(os_filename)
    if g:osplugin_auto_create_file
        call s:make_osplugin_directory()
        call s:make_osplugin_file(a:os_filename)
    endif

    if filereadable(g:osplugin_dir . s:slash . a:os_filename)
        call add(s:files_to_initilize, g:osplugin_dir . s:slash . a:os_filename)
    elseif g:osplugin_verbose
        call s:error(1, a:os_filename)
    endif
endfunction
" }}}

" Initilize OS configuration(s) {{{
function! osplugin#begin()
    if g:osplugin_auto_create_dir
        call s:make_osplugin_directory()
    endif

    let s:files_to_initilize = sort(s:files_to_initilize)
    let s:files_to_initilize = ( exists("*uniq()") )
        \? uniq(s:files_to_initilize)
        \: s:uniq(s:files_to_initilize)

    for l:os_filename in s:files_to_initilize
        execute 'verbose runtime '
            \. get(split(g:osplugin_dir, s:slash), -1, 'osplugin')
            \. s:slash . split(l:os_filename, s:slash)[-1]
        if g:osplugin_verbose
            call add(g:osplugin_initilized_files, l:os_filename)
        endif
    endfor

    if g:osplugin_verbose && empty(s:files_to_initilize)
        call s:error(2)
    endif

endfunction
"  }}}

" Automatic Folder Creation {{{
function! s:make_osplugin_directory()
    if !isdirectory( expand(g:osplugin_dir) )
        call mkdir(expand(g:osplugin_dir), 'p')
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

" Custom Fuction to find unique elements in list {{{
function! s:uniq(file_list)
    let l:index = 0
    while l:index < len(a:file_list)
       while a:file_list[l:index] ==# get(a:file_list, index+1, '')
            call remove(a:file_list, index+1)
        endwhile

        let l:index += 1
    endwhile

    return a:file_list
endfunction
" }}}

" Error Function {{{
function! s:error(error_number, ...)
    if a:error_number == 1
        echoe 'E1: File' . a:1 . ' does not exists or is not readable.'
    elseif a:error_number == 2
        echoe 'E2: No valid files sourced'
    endif
endfunction
"  }}}

" vim: set expandtab tabstop=8 softtabstop=4 shiftwidth=4 foldmethod=marker:
