call plug#begin()
  Plug 'arcticicestudio/nord-vim'
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug 'preservim/nerdcommenter'
  Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'airblade/vim-gitgutter'
  Plug 'tpope/vim-fugitive'
  Plug 'itchyny/lightline.vim'
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
nmap <Leader><Leader> :tabe $MYVIMRC<CR>
nmap <Leader>s :so $MYVIMRC<CR>
nmap <Leader>yy :let @+=expand("%")<CR>
nmap <Leader>yl :let @+=expand("%").":".line(".")<CR>

" colors
set termguicolors
colorscheme nord

" status
let g:lightline = {
      \ 'colorscheme': 'nord',
      \ 'active': {
      \ 'left': [ [ 'mode', 'paste' ],
      \           [ 'fugitive' ],
      \           [ 'readonly', 'filename', 'modified' ] ],
      \ },
      \ 'component_function': {
      \   'fugitive': 'FugitiveHead'
      \ }
      \ }

" navigation
let loaded_netrwPlugin = 1
call defx#custom#option('_', {
      \ 'split': 'floating',
      \ 'wincol': &columns / 4,
      \ 'winwidth': &columns / 2,
      \ 'winrow': &lines / 4,
      \ 'winheight': &lines / 2,
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
        \ defx#do_action('open_tree', 'toggle') :
        \ defx#do_action('multi', ['drop', 'quit'])
  nnoremap <silent><buffer><expr> v
        \ defx#do_action('multi', [['drop', 'vsplit'], 'quit'])
  nnoremap <silent><buffer><expr> s
        \ defx#do_action('multi', [['drop', 'split'], 'quit'])
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
nmap <Leader>f :GFiles<CR>
autocmd! FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

" git
nmap <Leader>gb :Git blame<CR>
nmap <Leader>gd :tab Git --paginate diff<CR>
nmap <Leader>gs :Git<CR>
nmap <Leader>gc :Git commit -a<CR>
nmap <Leader>gp :Git push<CR>
nmap <Leader>hn <Plug>(GitGutterNextHunk)
nmap <Leader>hp <Plug>(GitGutterPrevHunk)
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

" filetype specific
autocmd FileType go nmap <buffer> <Leader>z :vsplit term://go run % < %:h/in<CR> i
autocmd FileType go nmap <buffer> <Leader>l :!goimports -w %<CR>
autocmd FileType go nmap <buffer> <Leader>tp :call GoTestPkg()<CR>
autocmd FileType go nmap <buffer> <Leader>tf :call GoTestFunc()<CR>
autocmd FileType go nmap <buffer> <Leader>gg :!go generate %<CR>
autocmd FileType go nmap <buffer> <Leader>gr :!grabbyright -w %<CR>
autocmd FileType go set shiftwidth=4
autocmd FileType go set noet
autocmd FileType typescript,typescriptreact nmap <buffer> <Leader>t :tabe term://npx react-scripts test %<CR> i
autocmd FileType typescript,typescriptreact nmap <buffer> <Leader>l :!npx eslint --fix %<CR>
autocmd FileType typescript,typescriptreact set shiftwidth=2
autocmd FileType html set shiftwidth=2
autocmd FileType css,scss set shiftwidth=2
autocmd FileType json set shiftwidth=2
autocmd FileType json nmap <buffer> <Leader>l :%!python -m json.tool<CR>
autocmd FileType terraform nmap <buffer> <Leader>tf :!terraform fmt -write=true %<CR>
autocmd FileType terraform nmap <buffer> <Leader>ti :tabe term://cd %:h && terraform init<CR>i
autocmd FileType terraform nmap <buffer> <Leader>tp :tabe term://cd %:h && terraform plan<CR>i
autocmd FileType terraform nmap <buffer> <Leader>tu :!(cd %:h && terraenv terraform use)<CR>
autocmd FileType vim set shiftwidth=2
autocmd FileType help set nu rnu

function! GoTestPkg() abort
  call RunTerm(
        \"running tests in package: ".expand("%:h"),
        \"go test -v -count=1 ".expand("%:p:h"),
        \)
endfunction

function! GoTestFunc() abort
  let test = search('func \(Test\|Example\)', "bcnW")
  if test == 0
    echo "no test found"
    return
  end
  let name = split(split(getline(test), " ")[1], "(")[0]
  call RunTerm(
        \"running test: ".name,
        \"go test -v ".expand("%:p:h")." -run ^".name."$"
        \)
endfunction

function! RunTerm(msg, cmd) abort
  echo a:msg
  execute ":tabe term://".a:cmd
endfunction
