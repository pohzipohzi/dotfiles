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
Plug 'neoclide/coc.nvim', {'tag': '*', 'branch': 'release'}
Plug 'davidhalter/jedi-vim'
Plug 'ternjs/tern_for_vim', { 'do': 'npm install' }
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
map <C-p> :tabe $MYVIMRC<CR>
map <C-s> :so $MYVIMRC<CR>
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
nmap <Leader>hn <Plug>GitGutterNextHunk
nmap <Leader>hp <Plug>GitGutterPrevHunk
nmap <Leader>ha <Plug>GitGutterStageHunk
nmap <Leader>hu <Plug>GitGutterUndoHunk

" vim-airline
let g:airline_theme='solarized'

" coc
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif
nmap <Leader>d :call CocAction('jumpDefinition')<CR>
nmap <Leader>e :call CocAction('jumpDefinition', 'tab drop')<CR>
nmap <Leader>q :call CocAction('doHover')<CR>
nmap <Leader>r <Plug>(coc-references)
nmap <Leader>n <Plug>(coc-rename)

" coc-snippets
imap <C-l> <Plug>(coc-snippets-expand)
vmap <C-j> <Plug>(coc-snippets-select)
let g:coc_snippet_next = '<c-j>'
let g:coc_snippet_prev = '<c-k>'
imap <C-j> <Plug>(coc-snippets-expand-jump)
map <Leader>s :tabe $DOTFILES/.config/nvim/snippets/%:e.snippets<CR>

" language specific
autocmd FileType c map <buffer> <Leader><Leader> :!gcc % -o %:p:r && %:p:r < %:h/in<CR>
autocmd FileType go map <buffer> <Leader><Leader> :!go build -o %:p:r % && %:p:r < %:h/in<CR>
autocmd FileType python map <buffer> <Leader><Leader> :!python3 % < %:h/in<CR>

autocmd FileType c map <buffer> <Leader>z :!gcc % -o %:p:r && %:p:r<CR>
autocmd FileType python let g:jedi#rename_command = "<leader>n"
autocmd FileType python let g:jedi#usages_command = "<leader>r"
autocmd FileType python map <buffer> <Leader>z :!python3 %<CR>
autocmd FileType javascript map <buffer> <Leader>n :TernRename<CR>
autocmd FileType javascript map <buffer> <Leader>r :TernRefs<CR>
autocmd FileType javascript map <buffer> <Leader>q :TernType<CR>
autocmd FileType javascript map <buffer> <Leader>t :!npm test<CR>
autocmd FileType javascript map <buffer> <Leader>l :!npm run lint<CR>
autocmd FileType javascript map <buffer> <Leader>z :!node %<CR>
autocmd FileType go map <C-i> :!goimports -w %<CR>

autocmd FileType html set shiftwidth=2
autocmd FileType scss set shiftwidth=2
autocmd FileType javascript set shiftwidth=2
