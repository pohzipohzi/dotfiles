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
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': './install.sh'}
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'davidhalter/jedi-vim'
Plug 'ternjs/tern_for_vim', { 'do': 'npm install' }
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
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

" vim-solarized8
set termguicolors
set bg=dark
colorscheme solarized8

" nerdtree, nerdtree-git-plugin, vim-gitgutter
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
let NERDTreeShowHidden=1
let NERDTreeShowBookmarks=1
set updatetime=100
map <C-n> :NERDTreeToggle<CR>
map <C-f> :NERDTreeFind<CR>
map <C-h> :tabp<CR>
map <C-l> :tabn<CR>

" vim-airline
let g:airline_theme='solarized'

" coc
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

" neosnippet
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
let g:neosnippet#snippets_directory='$DOTFILES/.config/nvim/snippets/visible,$DOTFILES/.config/nvim/snippets/hidden'

" language specific
autocmd FileType c map <buffer> <Leader><Leader> :!gcc-9 % -o %:p:r && %:p:r < %:h/in<CR>
autocmd FileType cpp map <buffer> <Leader><Leader> :!g++-9 % -o %:p:r && %:p:r < %:h/in<CR>
autocmd FileType go map <buffer> <Leader><Leader> :!go build -o %:p:r % && %:p:r < %:h/in<CR>
autocmd FileType java map <buffer> <Leader><Leader> :!javac % && java -cp %:p:h %:t:r < %:h/in<CR>
autocmd FileType python map <buffer> <Leader><Leader> :!python3 % < %:h/in<CR>

autocmd FileType c map <buffer> <Leader>z :!gcc % -o %:p:r && %:p:r<CR>
autocmd FileType cpp map <buffer> <Leader>z :!g++ % -o %:p:r && %:p:r<CR>
autocmd FileType python let g:jedi#rename_command = "<leader>n"
autocmd FileType python let g:jedi#usages_command = "<leader>r"
autocmd FileType python map <buffer> <Leader>z :!python3 %<CR>
autocmd FileType javascript map <buffer> <Leader>d :TernDef<CR>
autocmd FileType javascript map <buffer> <Leader>n :TernRename<CR>
autocmd FileType javascript map <buffer> <Leader>r :TernRefs<CR>
autocmd FileType javascript map <buffer> <Leader>q :TernType<CR>
autocmd FileType javascript map <buffer> <Leader>t :!npm test<CR>
autocmd FileType javascript map <buffer> <Leader>l :!npm run lint<CR>
autocmd FileType javascript map <buffer> <Leader>z :!node %<CR>
autocmd FileType go map <buffer> <Leader>d :GoDef<CR>
autocmd FileType go map <buffer> <Leader>e <Plug>(go-def-tab)
autocmd FileType go map <buffer> <Leader>n :GoRename<CR>
autocmd FileType go map <buffer> <Leader>r :GoReferrers<CR>
autocmd FileType go map <buffer> <Leader>q :GoInfo<CR>
autocmd FileType go map <buffer> <Leader>t :GoTestFunc<CR>
autocmd FileType go map <buffer> <Leader>z :GoRun<CR>
autocmd FileType go let g:go_info_mode='gopls'
