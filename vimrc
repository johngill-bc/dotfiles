filetype plugin on  "Enable filetype plugin
filetype indent on  "Enable filetype indent
"filetype on

set nocompatible    "Prevents vim from emulating the original vi's bugs and limitations
set history=500     "Lines of history VIM has to remember
syntax enable       "Syntax highlighting
set expandtab       "Insert space characters whenever the tab key is pressed
set tabstop=4       "Tab length
set shiftwidth=4    "Number of space characters inserted for indentation
set softtabstop=4   "makes the spaces feel like real tabs
set number          "Display line numbers
set autoindent      "Use current line's indent level to set that for new lines
set cindent         "Not only indent, but insert space characters before
set showmatch       "Cursor will briefly jump to the matching brace when inserting one
set matchtime=5     "How many tenths of a second to blink the matching brace
set ruler           "Always show current positions along the bottom
set laststatus=2    "Always show the status line
set ignorecase      "Ignore case when searching
set wrapscan        "Searches wrap around the end of the file
set incsearch       "Move to the search match while typing
set scrolloff=5     "Keep 5 lines (top/bottom) for scope
set nowrap          "Do not wrap the line
"set tags=/vob/dbsv2/src/tags    "Enable ctags
"set hlsearch        "Highlight all search matches
"color desert
set background=dark
let g:solarized_termcolors=256
colorscheme solarized

autocmd FileType make setlocal noexpandtab
autocmd FileType release_names setlocal noexpandtab
autocmd BufRead,BufNewFile *.bteq set filetype=sql

" Functions
let mapleader='\'
function! MarkWindowSwap()
    let g:markedWinNum = winnr()
endfunction

function! DoWindowSwap()
    "Mark destination
    let curNum = winnr()
    let curBuf = bufnr( "%" )
    exe g:markedWinNum . "wincmd w"
    "Switch to source and shuffle dest->source
    let markedBuf = bufnr( "%" )
    "Hide and open so that we aren't prompted and keep history
    exe 'hide buf' curBuf
    "Switch to dest and shuffle source->dest
    exe curNum . "wincmd w"
    "Hide and open so that we aren't prompted and keep history
    exe 'hide buf' markedBuf 
endfunction

noremap <silent> <leader>mw :call MarkWindowSwap()<CR>
noremap <silent> <leader>pw :call DoWindowSwap()<CR>
