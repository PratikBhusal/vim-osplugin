if exists('g:loaded_osplugin') || &compatible
    finish
endif
let g:loaded_osplugin = '0.6.3'

" Function to Call outside of the autload file {{{
function! osplugin#begin(...)

    if s:osplugin_custom_config == 1
        call <sid>main(s:osplugin_custom_name)
        if exists('a:1')
            let s:osplugin_custom_name = a:1
        endif
    elseif exists('a:1')
        let s:osplugin_custom_config = 1
        let s:osplugin_custom_name = a:1
    else
        call <sid>main()
    endif
endfunction
"  }}}

" Main Function {{{1
function! s:main(...)
    if g:osplugin_auto_create_directory
        call osplugin#make_osplugin_directory()
    endif

    if exists('a:1')
        call <sid>initilize_os(a:1)
    elseif g:linux
        call <sid>initilize_os(g:linux_filename)
    elseif g:macOS
        call <sid>initilize_os(g:macOS_filename)
    elseif g:windows
        call <sid>initilize_os(g:windows_filename)
    elseif g:osplugin_debug
        call <sid>error(1)
    endif
endfunction
"  1}}}

" Automatic Folder Creation {{{
function! s:make_osplugin_directory()
    if !isdirectory( expand(g:osplugin_dir) )
        call mkdir(expand(g:osplugin_dir), 'p')
    endif
endfunction
" }}}

" Automatic File Creation {{{
function! s:make_osplugin_file(os_filename)
    let l:slash = ( (g:windows) ? '\' : '/' )
    if !filereadable( expand(g:osplugin_dir) . l:slash . expand(a:os_filename) )
        silent execute 'edit '  . expand(g:osplugin_dir) . l:slash . expand(a:os_filename)
        silent execute 'write ' . expand(g:osplugin_dir) . l:slash . expand(a:os_filename)
        silent execute 'bdelete'
    endif
endfunction
" }}}

" OS Config File Sourcing {{{
function! s:initilize_os(os_filename)
    if g:auto_create_file
        call <sid>make_osplugin_file(a:os_filename)
    endif

    let l:slash = ( (g:windows) ? '\' : '/' )
    if filereadable(  expand(g:osplugin_dir) . l:slash .expand(a:os_filename) )
        let &runtimepath .= ',' . g:osplugin_dir

        execute 'verbose runtime '
            \. get(split(g:osplugin_dir, l:slash), -1, 'osplugin')
            \. l:slash . expand(a:os_filename)

        " execute 'source ' . expand(g:osplugin_dir) . l:slash . expand(a:os_filename)
    elseif g:osplugin_debug
        call <sid>error(2, a:os_filename)
    endif
endfunction
" }}}

" Error Function {{{1
function! s:error(error_number, ...)
    if a:error_number == 1
        echoe 'Could not determine operating system.'
    elseif a:error_number == 2
        echoe 'Error 2: Could not source ' . a:1 . '. Is the file readable?'
    endif
endfunction
"  1}}}

" vim: set expandtab softtabstop=4 shiftwidth=4 foldmethod=marker:
