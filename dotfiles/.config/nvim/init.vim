call plug#begin()
  Plug 'lifepillar/vim-solarized8'
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
  Plug 'preservim/nerdcommenter'
  Plug 'Xuyuanp/nerdtree-git-plugin'
  Plug 'airblade/vim-gitgutter'
  Plug 'tpope/vim-fugitive'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'HerringtonDarkholme/yats.vim'
  Plug 'maxmellon/vim-jsx-pretty'
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

" colors
set termguicolors
set bg=dark
colorscheme solarized8
let g:airline_theme='solarized'

" navigation
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
let NERDTreeShowHidden=1
let NERDTreeShowBookmarks=1
set updatetime=100
nmap <C-n> :NERDTreeToggle<CR>
nmap <C-f> :NERDTreeFind<CR>
nmap <C-h> :tabp<CR>
nmap <C-l> :tabn<CR>

" git
nmap <Leader>gb :Gblame<CR>
nmap <Leader>gd :Gdiff<CR>
nmap <Leader>hn <Plug>(GitGutterNextHunk)
nmap <Leader>hp <Plug>(GitGutterPrevHunk)
nmap <Leader>ha <Plug>(GitGutterStageHunk)
nmap <Leader>hu <Plug>(GitGutterUndoHunk)

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
nmap <Leader>p :tabe $DOTFILES/.config/nvim/snippets/%:e.snippets<CR>

" language specific
autocmd FileType go nmap <buffer> <Leader>z :!time go run % < %:h/in<CR>
autocmd FileType go nmap <buffer> <Leader>l :!goimports -w %<CR>
autocmd FileType go nmap <buffer> <Leader>t :!go test -v -count=1 %:p:h<CR>
autocmd FileType go set shiftwidth=4
autocmd FileType typescript,typescriptreact nmap <buffer> <Leader>t :!npx react-scripts test %<CR>
autocmd FileType typescript,typescriptreact nmap <buffer> <Leader>l :!npx eslint --fix %<CR>
autocmd FileType typescript,typescriptreact set shiftwidth=2
autocmd FileType html set shiftwidth=2
autocmd FileType css,scss set shiftwidth=2
