call plug#begin()
Plug 'arcticicestudio/nord-vim'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'neovim/nvim-lsp'
Plug 'nvim-lua/completion-nvim'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'pohzipohzi/delve.nvim', { 'do': 'go install' }
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
set updatetime=100
let g:mapleader=" "
tnoremap <Esc> <C-\><C-n>
nnoremap <Leader><Leader> :tabe $MYVIMRC<CR>
nnoremap <Leader>s :so $MYVIMRC<CR>
nnoremap <Leader>yy :let @+=expand("%")<CR>
nnoremap <Leader>yl :let @+=expand("%").":".line(".")<CR>

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
nnoremap <C-h> :tabp<CR>
nnoremap <C-l> :tabn<CR>
nnoremap <C-j> :cnext<CR>
nnoremap <C-k> :cprev<CR>
nnoremap <C-c> :ccl<CR>
nnoremap <C-f> :GFiles<CR>
nnoremap <C-g> :GGrep<CR>
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
nnoremap <Leader>gb :Git blame<CR>
nnoremap <Leader>gd :Git difftool<CR>
nnoremap <Leader>gs :Git<CR>
nnoremap <Leader>gc :Git commit -a<CR>
nnoremap <Leader>gp :Git push<CR>
nnoremap <Leader>hn :GitGutterNextHunk<CR>
nnoremap <Leader>hp :GitGutterPrevHunk<CR>
nnoremap <Leader>hu :GitGutterUndoHunk<CR>
nnoremap <Leader>hh :GitGutterPreviewHunk<CR>
nnoremap <Leader>hs :GitGutterStageHunk<CR>

" lsp
lua << EOF
require'nvim_lsp'.gopls.setup{}
require'nvim_lsp'.ccls.setup{}
require'nvim_lsp'.pyls.setup{}
require'nvim_lsp'.solargraph.setup{}
require'nvim_lsp'.tsserver.setup{}
require'nvim_lsp'.yamlls.setup{}
require'nvim_lsp'.sumneko_lua.setup{}
EOF
nnoremap <Leader>e :tab split<bar>lua vim.lsp.buf.definition()<CR>
nnoremap <Leader>d :lua vim.lsp.buf.definition()<CR>
nnoremap <Leader>q :lua vim.lsp.buf.hover()<CR>
nnoremap <Leader>u :lua vim.lsp.buf.references()<CR>
nnoremap <Leader>r :lua vim.lsp.buf.rename()<CR>

" completion
autocmd BufEnter * lua require'completion'.on_attach()
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
set completeopt=menuone,noinsert,noselect
set shortmess+=c
let g:completion_enable_snippet = "vim-vsnip"

" filetype specific
autocmd FileType go nnoremap <buffer> <Leader>zz :tabe term://go run % < %:h/in<CR> i
autocmd FileType go nnoremap <buffer> <Leader>zc :tabe term://go build -o %:r % && piper -c %:p:r < %:h/in<CR> i
autocmd FileType go nnoremap <buffer> <Leader>zi :tabe term://go build -o %:r % && piper -c %:p:r<CR> i
autocmd FileType go nnoremap <buffer> <Leader>zd :tabe term://diff <(go build -o %:r % && piper -o -c %:r < %:h/in) <(piper -o -c cat < %:h/out)<CR> i
autocmd FileType go nnoremap <buffer> <Leader>l :call RunBuf("goimports")<CR>
autocmd FileType go nnoremap <buffer> <Leader>tp :call GoTestPkg()<CR>
autocmd FileType go nnoremap <buffer> <Leader>tf :call GoTestFunc()<CR>
autocmd FileType go set shiftwidth=4
autocmd FileType go set noet
autocmd FileType typescript,typescriptreact nnoremap <buffer> <Leader>t :tabe term://npx react-scripts test %<CR> i
autocmd FileType typescript,typescriptreact nnoremap <buffer> <Leader>l :!npx eslint --fix %<CR>
autocmd FileType typescript,typescriptreact set shiftwidth=2
autocmd FileType html set shiftwidth=2
autocmd FileType css,scss set shiftwidth=2
autocmd FileType yaml set shiftwidth=2
autocmd FileType json set shiftwidth=2
autocmd FileType json nnoremap <buffer> <Leader>l :call RunBuf("jq -e .")<CR>
autocmd FileType tf nnoremap <buffer> <Leader>l :call RunBuf("terraform fmt -")<CR>
autocmd FileType tf nnoremap <buffer> <Leader>ti :tabe term://cd %:h && terraform init<CR>i
autocmd FileType tf nnoremap <buffer> <Leader>tp :tabe term://cd %:h && terraform plan<CR>i
autocmd FileType tf nnoremap <buffer> <Leader>tu :!(cd %:h && terraenv terraform use)<CR>
autocmd FileType tf setlocal commentstring=#\ %s
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

function! RunBuf(cmd) abort
  redir => output
  silent execute "w !" . a:cmd
  redir END
  if v:shell_error
    echo output
    return
  endif
  let pos = getcurpos()
  execute "%!" . a:cmd
  call setpos('.', pos)
endfunction

function! RunTerm(msg, cmd) abort
  echo a:msg
  execute ":tabe term://".a:cmd
endfunction
