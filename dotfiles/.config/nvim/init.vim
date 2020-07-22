call plug#begin()
  Plug 'arcticicestudio/nord-vim'
  Plug 'itchyny/lightline.vim'
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-fugitive'
  Plug 'airblade/vim-gitgutter'
  Plug 'neovim/nvim-lsp'
  Plug 'nvim-lua/completion-nvim'
  Plug 'SirVer/ultisnips'
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
noremap <Space> <NOP>
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
let g:mapleader=" "
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
	  \   'filename': 'LightlineFilename',
      \   'fugitive': 'FugitiveHead'
      \ }
      \ }
function! LightlineFilename()
  let root = fnamemodify(get(b:, 'git_dir'), ':h')
  let path = expand('%:p')
  if path[:len(root)-1] ==# root
    return path[len(root)+1:]
  endif
  return expand('%')
endfunction

" navigation
let g:netrw_bufsettings = 'nu rnu'
let g:netrw_fastbrowse = 0
nmap <C-h> :tabp<CR>
nmap <C-l> :tabn<CR>
nmap <C-f> :GFiles<CR>
nmap <C-g> :GGrep<CR>
autocmd! FileType fzf set laststatus=0 noshowmode noruler
      \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
let g:fzf_colors = {
      \ 'bg+':     ['bg', 'ColorColumn'],
      \ 'gutter':  ['bg', 'Normal'],
      \ 'pointer': ['fg', 'Exception'],
      \}
command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number -- '.shellescape(<q-args>), 0,
  \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)

" git
nmap <Leader>gb :Git blame<CR>
nmap <Leader>gd :Git diff<CR>
nmap <Leader>gs :Git<CR>
nmap <Leader>gc :Git commit -a<CR>
nmap <Leader>gp :Git push<CR>
nmap <Leader>hn <Plug>(GitGutterNextHunk)
nmap <Leader>hp <Plug>(GitGutterPrevHunk)
nmap <Leader>hu <Plug>(GitGutterUndoHunk)

" lsp
lua << EOF
require'nvim_lsp'.gopls.setup{}
require'nvim_lsp'.pyls.setup{}
require'nvim_lsp'.solargraph.setup{}
require'nvim_lsp'.tsserver.setup{}
require'nvim_lsp'.yamlls.setup{}
require'nvim_lsp'.sumneko_lua.setup{}
EOF
nnoremap <Leader>e :tab split<CR><cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <Leader>d <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <Leader>q <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <Leader>u <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <Leader>r <cmd>lua vim.lsp.buf.rename()<CR>

" completion
autocmd BufEnter * lua require'completion'.on_attach()
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
set completeopt=menuone,noinsert,noselect
set shortmess+=c
let g:completion_enable_snippet = "UltiSnips"
let g:UltiSnipsSnippetDirectories=["UltiSnips"]

" filetype specific
autocmd FileType go nmap <buffer> <Leader>zc :vsplit term://go build -o %:r % && piper -c %:r < %:h/in<CR> i
autocmd FileType go nmap <buffer> <Leader>zi :vsplit term://go build -o %:r % && piper -c %:r<CR> i
autocmd FileType go nmap <buffer> <Leader>l :!goimports -w %<CR>
autocmd FileType go nmap <buffer> <Leader>tp :call GoTestPkg()<CR>
autocmd FileType go nmap <buffer> <Leader>tf :call GoTestFunc()<CR>
autocmd FileType go nmap <buffer> <Leader>gr :!grabbyright -w %<CR>
autocmd FileType go set shiftwidth=4
autocmd FileType go set noet
autocmd FileType typescript,typescriptreact nmap <buffer> <Leader>t :tabe term://npx react-scripts test %<CR> i
autocmd FileType typescript,typescriptreact nmap <buffer> <Leader>l :!npx eslint --fix %<CR>
autocmd FileType typescript,typescriptreact set shiftwidth=2
autocmd FileType html set shiftwidth=2
autocmd FileType css,scss set shiftwidth=2
autocmd FileType yaml set shiftwidth=2
autocmd FileType json set shiftwidth=2
autocmd FileType json nmap <buffer> <Leader>l :%!python -m json.tool<CR>
autocmd FileType tf nmap <buffer> <Leader>l :!terraform fmt -write=true %<CR>
autocmd FileType tf nmap <buffer> <Leader>ti :tabe term://cd %:h && terraform init<CR>i
autocmd FileType tf nmap <buffer> <Leader>tp :tabe term://cd %:h && terraform plan<CR>i
autocmd FileType tf nmap <buffer> <Leader>tu :!(cd %:h && terraenv terraform use)<CR>
autocmd FileType vim set shiftwidth=2
autocmd FileType help set nu rnu
autocmd BufNewFile,BufRead Jenkinsfile setf groovy

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
        \"go test -v -count=1 ".expand("%:p:h")." -run ^".name."$"
        \)
endfunction

function! RunTerm(msg, cmd) abort
  echo a:msg
  execute ":tabe term://".a:cmd
endfunction
