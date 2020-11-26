" ===============
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

noremap hl <C-w>v
noremap hk <C-w>s
noremap hn <C-w>n


noremap <C-i> <C-w>+
noremap <C-k> <C-w>-
noremap <C-j> <C-w><
noremap <C-l> <C-w>>

noremap <LEADER>w <C-w>w
noremap <LEADER>i <C-w>k
noremap <LEADER>k <C-w>j
noremap <LEADER>j <C-w>h
noremap <LEADER>l <C-w>l

call plug#begin('~/.vim/plugged')
"Plug 'honza/vim-snippets'
Plug 'jackguo380/vim-lsp-cxx-highlight'
Plug 'luochen1990/rainbow'
"Plug 'iamcco/markdown-preview.nvim', {'do': 'cd app & yarn install'  }
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'vim-airline/vim-airline'
"Plug 'puremourning/vimspector', {'do': './install_gadget.py --enable-c --enable-python'}
Plug 'ryanoasis/vim-devicons'
Plug 'dhruvasagar/vim-table-mode'
Plug 'arcticicestudio/nord-vim'
Plug 'jiangmiao/auto-pairs'
Plug 'Chiel92/vim-autoformat'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'skywind3000/asynctasks.vim'
Plug 'skywind3000/asyncrun.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
call plug#end()

colorscheme nord

let g:asyncrun_open = 6
let g:asynctasks_term_pos = 'bottom'
let g:asynctasks_term_rows = 8    " set height for the horizontal terminal split
let g:asynctasks_term_cols = 80    " set width for vertical terminal split
noremap <silent><f4> :AsyncTask file-build<cr>
noremap <silent><f5> :AsyncTask file-run<cr>
"let g:formatterpath = ['/usr/bin/clang-format-10', '/usr/bin/autopep8']
noremap <F3> :Autoformat<CR>
au BufWrite * :Autoformat
let g:formatdef_clangformat_google = '"clang-format-10 --style=\"{BasedOnStyle: google, IndentWidth: 4}\""'
let g:formatters_cpp = ['clangformat_google']

" Compile function
noremap <C-r> :call CompileRunGcc()<CR>
func! CompileRunGcc()
    exec "w"
    if &filetype == 'c'
        exec "!g++ % -o %<"
        exec "!time ./%<"
    elseif &filetype == 'cpp'
        set splitbelow
        exec "!g++ -std=c++11 % -Wall -o %<"
        :sp
        :res -15
        :term ./%<
    elseif &filetype == 'sh'
        :!time bash %
    elseif &filetype == 'python'
        set splitbelow
        :sp
        :term python3 %
    elseif &filetype == 'html'
        silent! exec "!".g:mkdp_browser." % &"
    elseif &filetype == 'markdown'
        exec "MarkdownPreview"
    elseif &filetype == 'javascript'
        set splitbelow
        :sp
        :term export DEBUG="INFO,ERROR,WARNING"; node --trace-warnings .
    endif
endfunc

"=============
"======MarkDown
"===========
"" Snippets
source /home/liwei/.config/nvim/md-snippets.vim

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


"coc


let g:coc_global_extensions = [
            \ 'coc-json',
            \ 'coc-explorer',
            \ 'coc-snippets',
            \ 'coc-clangd',
            \ 'coc-python',
            \ ]

" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)

" Use <leader>x for convert visual selected code to snippet
xmap <leader>x  <Plug>(coc-convert-snippet)

inoremap <silent><expr> <Tab>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<Tab>" :
            \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

nnoremap <silent> K :call <SID>show_documentation()<CR>

autocmd CursorHold * silent call CocActionAsync('highlight')

augroup mygroup
    autocmd!
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder.
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end



nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> zn <Plug>(coc-rename)
