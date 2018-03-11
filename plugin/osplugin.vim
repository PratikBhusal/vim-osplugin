" Global Variables {{{
let g:osplugin_debug = get(g:, 'osplugin_debug' , 0)

let g:osplugin_auto_create_dir = get(g:, 'osplugin_auto_create_dir', 0)

let g:osplugin_auto_create_file = get(g:, 'osplugin_auto_create_file' , 0)

let g:linux = get( g:, 'linux', has('unix') && !has('macunix') && !has('win32unix') )

let g:windows = get( g:, 'windows' , has('win32') || has('win64') )

let g:macOS = get( g:, 'macOS', has('macunix') )

let g:linux_filename = get(g:, 'linux_filename', 'linux.vim')

let g:windows_filename = get(g:, 'windows_filename', 'windows.vim')

let g:macOS_filename = get(g:, 'macOS_filename', 'macOS.vim')

let g:osplugin_dir = get(g:, 'osplugin_dir',
        \( (g:windows)
            \? expand('$HOME/vimfiles/osplugin')
            \: expand('$HOME/.vim/osplugin')
        \)
    \)

let g:osplugin_auto_create_directory = get(g:, 'osplugin_auto_create_directory', 0)

let g:osplugin_custom_config = get(g:, 'osplugin_custom_config', 0)

let g:osplugin_custom_name = get(g:, 'osplugin_custom_name', '')
" }}}

call osplugin#begin()
