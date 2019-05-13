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
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'deoplete-plugins/deoplete-jedi'
Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }
Plug 'deoplete-plugins/deoplete-go', { 'do': 'make' }
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
let g:mapleader=","
tnoremap <Esc> <C-\><C-n>
map <C-p> :e $HOME/.config/nvim/init.vim<CR>

" vim-solarized8
set termguicolors
set bg=dark
colorscheme solarized8

" fzf
map <Leader>f :Files<CR>
map <Leader>g :Rg 

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

" nerdcommenter
nmap <C-_>   <Plug>NERDCommenterToggle
vmap <C-_>   <Plug>NERDCommenterToggle<CR>gv

" vim-airline
let g:airline_theme='solarized'

" deoplete
let g:deoplete#enable_at_startup=1
let g:deoplete#sources#go#gocode_binary=$GOPATH.'/bin/gocode'
let g:deoplete#sources#go#sort_class=['package', 'func', 'type', 'var', 'const']
call deoplete#custom#option('num_processes', 1) " https://github.com/Shougo/deoplete.nvim/issues/761#issuecomment-389701983
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

" neosnippet
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif
let g:neosnippet#snippets_directory='$DOTFILES/.config/nvim/snippets/visible,$DOTFILES/.config/nvim/snippets/hidden'

" language specific
autocmd FileType python map <Leader><Leader> :w | :!python3 %:h/sol.py < %:h/input.txt<CR>
autocmd FileType python let g:jedi#rename_command = "<leader>n"
autocmd FileType python let g:jedi#usages_command = "<leader>r"
autocmd FileType python map <Leader>z :!python3 %<CR>
autocmd FileType javascript map <Leader>d :TernDef<CR>
autocmd FileType javascript map <Leader>n :TernRename<CR>
autocmd FileType javascript map <Leader>r :TernRefs<CR>
autocmd FileType javascript map <Leader>q :TernType<CR>
autocmd FileType javascript map <Leader>t :!npm test<CR>
autocmd FileType javascript map <Leader>l :!npm run lint<CR>
autocmd FileType javascript map <Leader>z :!node %<CR>
autocmd FileType go map <Leader>d :GoDef<CR>
autocmd FileType go map <Leader>n :GoRename<CR>
autocmd FileType go map <Leader>r :GoReferrers<CR>
autocmd FileType go map <Leader>q :GoInfo<CR>
autocmd FileType go let g:go_info_mode='gopls'
