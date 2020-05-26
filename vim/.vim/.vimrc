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

noremap $ J
noremap h w
noremap H K
noremap O D
noremap o d
noremap W s
noremap w O
noremap s o
noremap A I
noremap a i
noremap D A
noremap d a
noremap I H
noremap K L
noremap i k
noremap k j
noremap j h
noremap J ^
noremap L $
vnoremap Y :w !xclip -i -sel c<CR><CR>
nmap <space>e :CocCommand explorer<CR>

noremap T <NOP>
noremap t <NOP>
noremap + <NOP>
nnoremap [[  :<c-u>execute 'move -1-'. v:count1<cr>
nnoremap ]]  :<c-u>execute 'move +'. v:count1<cr>

inoremap <C-S>   <ESC>:w<CR>
noremap  <C-S>   :w<CR>
inoremap <C-Q>   <ESC>:q<CR>
noremap  <C-Q>   :q<CR>
noremap  <C-X>   <NOP>
noremap  <C-w>   <NOP>
noremap  <C-w>   <NOP>
noremap  <C-w>   <NOP >



"Compile fuction
noremap <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
    exec "w"
    if &filetype == 'c'
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





map <C-n> :NERDTreeToggle<CR>
call plug#begin('~/.vim/plugged')
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'jackguo380/vim-lsp-cxx-highlight'
"Plug 'luochen1990/rainbow'
"Plug 'kana/vim-textobj-user'
"Plug 'tpope/vim-fugitive'
"Plug 'liuchengxu/vista.vim'
"Plug 'easymotion/vim-easymotion'
"Plug 'AndrewRadev/splitjoin.vim'
"Plug ''
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
autocmd CursorHold * silent call CocActionAsync('highlight')
