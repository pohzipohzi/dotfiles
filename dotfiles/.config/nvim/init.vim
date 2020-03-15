" plugins
call plug#begin()
Plug 'lifepillar/vim-solarized8'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'scrooloose/nerdcommenter'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'HerringtonDarkholme/yats.vim'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'fatih/vim-hclfmt'
call plug#end()

" general
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>
noremap <C-f> <NOP>
noremap <C-b> <NOP>
set nu
set rnu
set colorcolumn=80
set tabstop=4
set shiftwidth=4
set expandtab
set clipboard=unnamedplus
set foldmethod=syntax
set foldnestmax=1
set nofoldenable
set noswapfile
let g:mapleader=","
tnoremap <Esc> <C-\><C-n>
map <Leader><Leader> :tabe $MYVIMRC<CR>
map <Leader>s :so $MYVIMRC<CR>
map <Leader>y :let @+=expand("%:p")<CR>

" vim-solarized8
set termguicolors
set bg=dark
colorscheme solarized8

" nerdtree, nerdtree-git-plugin
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
let NERDTreeShowHidden=1
let NERDTreeShowBookmarks=1
set updatetime=100
map <C-n> :NERDTreeToggle<CR>
map <C-f> :NERDTreeFind<CR>
map <C-h> :tabp<CR>
map <C-l> :tabn<CR>

" vim-gigutter
nmap <Leader>hn <Plug>(GitGutterNextHunk)
nmap <Leader>hp <Plug>(GitGutterPrevHunk)
nmap <Leader>ha <Plug>(GitGutterStageHunk)
nmap <Leader>hu <Plug>(GitGutterUndoHunk)

" vim-airline
let g:airline_theme='solarized'

" coc
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <expr><S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : 
                                           \"\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
nmap <Leader>d :call CocAction('jumpDefinition')<CR>
nmap <Leader>q :call CocAction('doHover')<CR>
nmap <Leader>u <Plug>(coc-references)
nmap <Leader>r <Plug>(coc-rename)

" coc-snippets
imap <C-l> <Plug>(coc-snippets-expand)
vmap <C-j> <Plug>(coc-snippets-select)
let g:coc_snippet_next = '<c-j>'
let g:coc_snippet_prev = '<c-k>'
imap <C-j> <Plug>(coc-snippets-expand-jump)
map <Leader>n :tabe $DOTFILES/.config/nvim/snippets/%:e.snippets<CR>

" language specific
autocmd FileType go map <buffer> <Leader>z :!time go run % < %:h/in<CR>
autocmd FileType cpp map <buffer> <Leader>z :!clang++ -std=c++11 -stdlib=libc++ -Weverything % -o %:p:r && %:p:r < %:h/in<CR>

autocmd FileType go nmap <buffer> <Leader>l :!goimports -w %<CR>
autocmd FileType go nmap <buffer> <Leader>t :!go test -v -count=1 %:p:h<CR>
autocmd FileType typescript,typescriptreact map <buffer> <Leader>t :!npx react-scripts test %<CR>
autocmd FileType typescript,typescriptreact map <buffer> <Leader>l :!npx eslint --fix %<CR>

autocmd FileType html set shiftwidth=2
autocmd FileType scss set shiftwidth=2
autocmd FileType typescriptreact set shiftwidth=2
