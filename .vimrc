"set t_Co=256
set shiftwidth=4
set tabstop=4
set autoindent
set encoding=utf-8
set number
set timeoutlen=5
set laststatus=2
set background=dark
set splitright
set splitbelow
set showcmd

" Highlight functions using Java style
let java_highlight_functions="style"
" Don't flag C++ keywords as errors
let java_allow_cpp_keywords=1

"let g:Powerline_symbols = 'fancy'
"set nocompatible   " Disable vi-compatibility

filetype plugin on
syntax enable

" air-line
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

" Could have a small performance penalty
let g:airline_skip_empty_sections = 1

" Set what is displayed in the airline bar
let g:airline_section_z = airline#section#create(['windowswap', '%3p%% ', 'linenr', ':%3v'])

" Disbale whitespace detection
let g:airline#extensions#whitespace#enabled = 0

" Airline theme
let g:airline_theme='solarized'
let g:airline_solarized_bg='dark'
let g:solarized_termcolors=256

" Vim colorscheme
colorscheme molokai
