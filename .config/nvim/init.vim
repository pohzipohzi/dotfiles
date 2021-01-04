call plug#begin()
Plug 'arcticicestudio/nord-vim'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/gv.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'airblade/vim-gitgutter'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'nvim-lua/lsp-status.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
call plug#end()

lua require'init'

" status
function! LightlineFilename()
  let root = fnamemodify(get(b:, 'git_dir'), ':h')
  let path = expand('%:p')
  if path[:len(root)-1] ==# root
    return path[len(root)+1:]
  endif
  return expand('%')
endfunction
function! LspStatus()
  return luaeval("LspStatus()")
endfunction

" navigation
autocmd! FileType fzf set laststatus=0 noshowmode noruler
      \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
command! -bang -nargs=* GGrep
      \ call fzf#vim#grep(
      \   'git grep -n -- '.shellescape(<q-args>), 0,
      \   fzf#vim#with_preview({'dir': input('git grep dir: ', expand('%:p:h'), 'file')}),
      \   <bang>0)

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
  let buffer_content = getline(1, '$')
  let lines = systemlist(a:cmd, join(buffer_content, "\n"))
  if v:shell_error
    echo join(lines, "\n")
    return
  endif
  silent keepjumps call setline(1, lines)
  if line('$') > len(lines)
    silent keepjumps execute string(len(lines)+1).',$ delete'
  endif
endfunction

function! RunTerm(msg, cmd) abort
  echo a:msg
  execute ":tabe term://".a:cmd
endfunction
