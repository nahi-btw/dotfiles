let g:startify_custom_header = [
    \ '   ____  __.__        __               ',
    \ '  |    |/ _|__| ____ |  | __ ____     ',
    \ '  |      < |  |/ ___\|  |/ // __ \    ',
    \ '  |    |  \|  / /_/  >    <\  ___/    ',
    \ '  |____|__ \__\___  /|__|_ \\___  >   ',
    \ '        \/     /_____/     \/    \/    ',
    \ '                                ',
    \ 'Hello, Nehemiah! Welcome to Vim.',
    \ ]
    \ { 'i': '~/.vim' },
    \ { 'c': '~/.config/nvim/init.vim' },
    \ ]
let g:startify_bookmarks = [
let g:startify_lists = [
    \ { 'type': 'files',     'header': ['   MRU']            },
    \ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
    \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
    \ { 'type': 'commands',  'header': ['   Commands']      },
    \ ]
