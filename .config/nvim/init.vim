call plug#begin()
Plug 'arcticicestudio/nord-vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/gv.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'airblade/vim-gitgutter'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
call plug#end()

lua require'init'

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
