call plug#begin()
  Plug 'lifepillar/vim-solarized8'
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug 'preservim/nerdcommenter'
  Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'airblade/vim-gitgutter'
  Plug 'tpope/vim-fugitive'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'HerringtonDarkholme/yats.vim'
  Plug 'maxmellon/vim-jsx-pretty'
  Plug 'hashivim/vim-terraform'
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
let loaded_netrwPlugin = 1
call defx#custom#option('_', {
      \ 'split': 'floating',
      \ 'show_ignored_files': 1,
      \ 'toggle': 1,
      \ 'resume': 1
      \ })
map <C-n> :Defx<CR>
map <C-f> :Defx -search=`expand('%:p')`<CR>
autocmd FileType defx call s:defx_settings()
function! s:defx_settings() abort
  set nu
  set rnu
  nnoremap <silent><buffer><expr> <ESC>
        \ defx#do_action('quit')
  nnoremap <silent><buffer><expr> <CR>
        \ defx#is_directory() ?
        \ defx#do_action('open_or_close_tree') :
        \ defx#do_action('multi', ['drop', 'quit'])
  nnoremap <silent><buffer><expr> s
        \ defx#do_action('multi', [['drop', 'vsplit'], 'quit'])
  nnoremap <silent><buffer><expr> t
        \ defx#do_action('multi', [['drop', 'tabe'], 'quit'])
  nnoremap <silent><buffer><expr> ma
        \ defx#do_action('new_file')
  nnoremap <silent><buffer><expr> md
        \ defx#do_action('remove')
  nnoremap <silent><buffer><expr> mm
        \ defx#do_action('rename')
endfunction
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
nmap <Leader>e :call CocAction('jumpDefinition', 'tab drop')<CR>
nmap <Leader>q :call CocAction('doHover')<CR>
nmap <Leader>u <Plug>(coc-references)
nmap <Leader>r <Plug>(coc-rename)
imap <C-l> <Plug>(coc-snippets-expand)
vmap <C-j> <Plug>(coc-snippets-select)
let g:coc_snippet_next = '<c-j>'
let g:coc_snippet_prev = '<c-k>'
imap <C-j> <Plug>(coc-snippets-expand-jump)
nmap <Leader>p :tabe $DOTFILES/.config/nvim/snippets/%:e.snippets<CR>

" language specific
autocmd FileType go nmap <buffer> <Leader>zz :vsplit term://go run % < %:h/in<CR> i
autocmd FileType go nmap <buffer> <Leader>zx :vsplit term://piper go run % < %:h/in<CR> i
autocmd FileType go nmap <buffer> <Leader>zi :vsplit term://piper go run %<CR> i
autocmd FileType go nmap <buffer> <Leader>l :!goimports -w %<CR>
autocmd FileType go nmap <buffer> <Leader>t :tabe term://go test -v -count=1 %:p:h<CR> i
autocmd FileType go nmap <buffer> <Leader>gg :!go generate %<CR>
autocmd FileType go nmap <buffer> <Leader>gr :!grabbyright -w %<CR>
autocmd FileType go set shiftwidth=4
autocmd FileType typescript,typescriptreact nmap <buffer> <Leader>t :tabe term://npx react-scripts test %<CR> i
autocmd FileType typescript,typescriptreact nmap <buffer> <Leader>l :!npx eslint --fix %<CR>
autocmd FileType typescript,typescriptreact set shiftwidth=2
autocmd FileType html set shiftwidth=2
autocmd FileType css,scss set shiftwidth=2
autocmd FileType json set shiftwidth=2
autocmd FileType json nmap <buffer> <Leader>l :%!python -m json.tool<CR>
autocmd FileType terraform nmap <buffer> <Leader>tf :!terraform fmt -write=true %<CR>
autocmd FileType terraform nmap <buffer> <Leader>tp :vsplit term://terraform plan<CR> i
autocmd FileType terraform nmap <buffer> <Leader>ta :vsplit term://terraform apply<CR> i
autocmd FileType terraform nmap <buffer> <Leader>ti :vsplit term://terraform init<CR> i
autocmd FileType terraform nmap <buffer> <Leader>tsl :vsplit term://terraform state list<CR> i
autocmd FileType terraform nmap <buffer> <Leader>tss :vsplit term://terraform state show 
autocmd FileType vim set shiftwidth=2
