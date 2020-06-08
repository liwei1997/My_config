" ==============
" ====System====
" ==============
set nocompatible
syntax on
syntax enable
let &t_ut=''
filetype on
filetype indent on
filetype plugin on
filetype plugin indent on


set autoindent
set backspace=indent,eol,start
set encoding=utf-8
set expandtab
set list
set listchars=tab:>-,trail:-,eol:<
set number
set relativenumber
set ruler
set hidden
set nobackup
set nowritebackup
set cmdheight=2
set shortmess+=c
set signcolumn=yes
set scrolloff=5
set shiftwidth=4
set showmatch
set showcmd
set history=256

" Timing
" ------
set ttimeout
set ttimeoutlen=100
set updatetime=300

set smartindent
set tabstop=4
set wrap
set wildmenu
set hlsearch
set incsearch
set ignorecase
set smartcase

noremap < Nzz
noremap > nzz
exec "nohlsearch"

map Q gq
let g:mapleader = " "

noremap j h
noremap i k
noremap k j

noremap O D
noremap o d

noremap S O
noremap s o
noremap A I
noremap a i
noremap D A
noremap d a

noremap I H
noremap K L
noremap J ^
noremap L $
noremap H K

vnoremap Y :w !xclip -i -sel c<CR><CR>
nmap <LEADER>e :CocCommand explorer<CR>

noremap T <NOP>
noremap t <NOP>
noremap + <NOP>

noremap <h> <NOP>

noremap hj <C-w>v
noremap hk <C-w>s
noremap hi <C-w>n


noremap <C-i> <C-w>+
noremap <C-k> <C-w>-
noremap <C-j> <C-w><
noremap <C-l> <C-w>>

noremap <LEADER>w <C-w>w
noremap <LEADER>k <C-w>k
noremap <LEADER>i <C-w>j
noremap <LEADER>j <C-w>h
noremap <LEADER>l <C-w>l


"Compile fuction
noremap <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
exec "w"
if &filetype == 'c'
set splitbelow
exec "!gcc -std=c99 % -Wall -g -lm -o %<"
exec "!time ./%<"
elseif &filetype == 'cpp'
set splitbelow
exec "!g++ -std=c++11 % -Wall -o %<"
:sp
:res -15
:term ./%<
elseif &filetype == 'java'
exec "!javac %"
exec "!time java %<"
elseif &filetype == 'sh'
:!time bash %
elseif &filetype == 'python'
:set splitbelow
        :sp
        :term python3 %
    elseif &filetype == 'html'
        silent! exec "!".g:mkdp_browser."% &"
    elseif &filetype == 'markdown'
        exec "MarkdownPreview"
    endif
endfunc





call plug#begin('~/.vim/plugged')
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'jackguo380/vim-lsp-cxx-highlight'
Plug 'luochen1990/rainbow'
Plug 'iamcco/markdown-preview.nvim', {'do': 'cd app & yarn install'  }
Plug 'vim-airline/vim-airline'
"Plug 'puremourning/vimspector', {'do': './install_gadget.py --enable-c --enable-python'}
Plug 'ryanoasis/vim-devicons'
Plug 'dhruvasagar/vim-table-mode'
Plug 'arcticicestudio/nord-vim'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()
colorscheme nord



"=============
"======MarkDown
"===========
source /home/liwei/.vim/md-snippets.vim

let g:table_mode_corner='|'
function! s:isAtStartOfLine(mapping)
    let text_before_cursor = getline('.')[0 : col('.')-1]
    let mapping_pattern = '\V' . escape(a:mapping, '\')
    let comment_pattern = '\V' . escape(substitute(&l:commentstring, '%s.*$', '', ''), '\')
    return (text_before_cursor =~? '^' . ('\v(' . comment_pattern . '\v)?') . '\s*\v' . mapping_pattern . '\v$')
endfunction

inoreabbrev <expr> <bar><bar>
            \ <SID>isAtStartOfLine('\|\|') ?
            \'<c-o>:TableModeEnable<cr><bar><space><bar><left><left>' : '<bar><bar>'
inoreabbrev <expr> __
            \ <SID>isAtStartOfLine('__') ?
            \ '<c-o>:silent! TableModeDisable<cr>' : '__'
"==================
"====Vimspector====
"==================
"let g:vimspector_enable_mappings = 'HUMAN'
"==================
"====Ultisnips=====
"==================
let g:UltiSnipsExpandTrigger="<c-e>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"


"coc
let g:coc_global_extensions = [
    \ 'coc-json', 
    \ 'coc-explorer',
    \ ]

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <leader>rn <Plug>(coc-rename)
autocmd CursorHold * silent call CocActionAsync('highlight')