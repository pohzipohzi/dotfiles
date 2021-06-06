vim.api.nvim_command([[
call plug#begin()
Plug 'arcticicestudio/nord-vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/gv.vim'
Plug 'justinmk/vim-dirvish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'airblade/vim-gitgutter'
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'hrsh7th/nvim-compe'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'
Plug 'rhysd/clever-f.vim'
call plug#end()
]])

-- unmap unused keys
for _, lhs in ipairs({
  '<Up>',
  '<Down>',
  '<Left>',
  '<Right>',
  '<C-f>',
  '<C-b>',
  '<C-t>',
  '<Space>',
}) do
vim.api.nvim_set_keymap('', lhs, '<NOP>', { noremap = true })
end

-- options
vim.opt.nu = true
vim.opt.rnu = true
vim.opt.colorcolumn = '80'
vim.opt.cursorline = true
vim.opt.list = true
vim.opt.clipboard = 'unnamedplus'
vim.opt.updatetime = 100
vim.opt.termguicolors = true
vim.opt.statusline = '%<%f %h%m%r%{FugitiveStatusline()} %{luaeval("DiagnosticStatus()")} %=%-14.(%l,%c%V%) %P'
vim.opt.tabstop = 2
vim.opt.shiftwidth = 0
vim.opt.expandtab = true
vim.opt.tagstack = false

-- colors
vim.api.nvim_command('colorscheme nord')
vim.api.nvim_command('highlight LspDiagnosticsDefaultError guifg=#BF616A')
vim.api.nvim_command('highlight LspDiagnosticsDefaultWarning guifg=#EBCB8B')
vim.api.nvim_command('highlight CleverFChar gui=bold,underline guifg=#BF616A')

-- leader mappings
vim.api.nvim_set_var('mapleader', ' ')
vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader><Leader>', ':tabe $MYVIMRC<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>s', ':luafile $MYVIMRC<CR>', { noremap=true })
vim.api.nvim_set_keymap('n', '<Leader>yy', ':let @+=expand("%")<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>yl', ':let @+=expand("%").":".line(".")<CR>', { noremap = true })

-- navigation
vim.api.nvim_set_var('loaded_netrwPlugin', 1)
vim.api.nvim_set_var('fzf_colors', {
  gutter = { 'bg', 'Normal' },
})
vim.api.nvim_set_var('fzf_layout', {
  window = {
    width = 0.9,
    height = 0.8,
  },
})
vim.api.nvim_set_var('clever_f_across_no_line', 1)
vim.api.nvim_set_keymap('n', '<C-h>', ':tabp<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-l>', ':tabn<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-j>', ':cnext<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-k>', ':cprev<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-x>', ':pc<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-c>', ':ccl<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-f>', ':GFiles<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-g>', ':GGrep<CR>', { noremap = true })
vim.api.nvim_set_var('loaded_fzf_vim', '1')
vim.api.nvim_command('autocmd! FileType fzf set laststatus=0 noshowmode noruler | autocmd BufLeave <buffer> set laststatus=2 showmode ruler')
vim.api.nvim_command('command! -bang -nargs=? GFiles call fzf#vim#gitfiles(<q-args>, fzf#vim#with_preview(<q-args> == "?" ? { "placeholder": "" } : {}), <bang>0)')
vim.api.nvim_command('command! -bang -nargs=* GGrep call fzf#vim#grep("git grep -n -- ".shellescape(<q-args>), 0, fzf#vim#with_preview({"dir": input("git grep dir: ", expand("%:p:h"), "file")}), <bang>0)')

-- git
vim.api.nvim_set_keymap('n', '<Leader>gb', ':Git blame<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>gd', ':Git difftool<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>gs', ':Git<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>gc', ':Git commit -a<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>gp', ':Git push<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>hn', ':GitGutterNextHunk<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>hp', ':GitGutterPrevHunk<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>hu', ':GitGutterUndoHunk<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>hh', ':GitGutterPreviewHunk<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>hs', ':GitGutterStageHunk<CR>', { noremap = true })

-- lsp handlers
vim.lsp.handlers["$/progress"] = function(_, _, params, client_id)
  local client = vim.lsp.get_client_by_id(client_id)
  local client_name = client and client.name or string.format("%d", client_id)
  if not client then
    print(string.format('[%s] client has shut down after sending the message', client_name))
    return
  end
  local val = params.value
  if val.kind then
    if val.title and val.message then
      print(string.format('[%s:%s] %s: %s', client_name, val.kind, val.title, val.message))
      return
    end
    if val.title then
      print(string.format('[%s:%s] %s', client_name, val.kind, val.title))
      return
    end
    if val.message then
      print(string.format('[%s:%s] %s', client_name, val.kind, val.message))
      return
    end
    print(string.format('[%s:%s]', client_name, val.kind))
  end
end

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics,
  {
    underline = true,
    virtual_text = false,
  }
)

-- lsp configs
local on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>e', ':lua GoToDefinitionTab()<CR>', { noremap = true })
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>d', ':lua vim.lsp.buf.definition()<CR>', { noremap = true })
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>q', ':lua vim.lsp.buf.hover()<CR>', { noremap = true })
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>u', ':lua vim.lsp.buf.references()<CR>', { noremap = true })
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>r', ':lua vim.lsp.buf.rename()<CR>', { noremap = true })
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>i', ':lua vim.lsp.buf.implementation()<CR>', { noremap = true })
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>f',
  client.name == 'gopls' and ':lua GoImports()<CR>' or
  client.resolved_capabilities.document_formatting and ':lua vim.lsp.buf.formatting()<CR>' or
  client.resolved_capabilities.document_range_formatting and ':lua vim.lsp.buf.range_formatting({},{0,0},{vim.fn.line("$"),0})<CR>' or
  string.format(':lua vim.api.nvim_echo({{"no formatting command configured for language server `%s`", "WarningMsg"}}, false, {})<CR>', client.name), { noremap = true })
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-n>', ':lua vim.lsp.diagnostic.goto_next()<CR>', { noremap = true })
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-p>', ':lua vim.lsp.diagnostic.goto_prev()<CR>', { noremap = true })
end

require'lspconfig'.gopls.setup{
  cmd = {'gopls', '-vv', '-rpc.trace', '-logfile', os.getenv('HOME') .. '/.gopls.log'},
  on_attach = on_attach,
}

require'lspconfig'.pyls.setup{
  on_attach = on_attach,
}

require'lspconfig'.solargraph.setup{
  on_attach = on_attach,
}

require'lspconfig'.clangd.setup{
  on_attach = on_attach,
}

require'lspconfig'.sumneko_lua.setup{
  cmd = {
    os.getenv('HOME') .. '/oss/lua-language-server/bin/' .. (vim.fn.has('mac') == 1 and 'macOS' or 'Linux') .. '/lua-language-server',
    "-E",
    os.getenv('HOME') .. '/oss/lua-language-server/main.lua',
  };
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        path = vim.split(package.path, ';'),
      },
      diagnostics = {
        globals = { 'vim' }
      },
      workspace = {
        library = {
          [vim.fn.expand('$VIMRUNTIME/lua')] = true,
          [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
        },
      },
    }
  },
  on_attach = on_attach,
}

require'lspconfig'.yamlls.setup{
  on_attach = on_attach,
}

require'lspconfig'.jsonls.setup{
  on_attach = on_attach,
}

vim.lsp.set_log_level("debug")
vim.api.nvim_set_keymap('n', '<Leader>ll', ':tabe ' .. vim.lsp.get_log_path() .. '<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>lg', ':tabe ' .. os.getenv('HOME') .. '/.gopls.log' .. '<CR>', { noremap = true })

function DiagnosticStatus()
  if vim.tbl_isempty(vim.lsp.buf_get_clients(0)) then
    return ''
  end
  local count_e = vim.lsp.diagnostic.get_count(0, 'Error')
  local count_w = vim.lsp.diagnostic.get_count(0, 'Warning')
  return string.format('[E:%d,W:%d]', count_e, count_w)
end

-- this is mostly copied from https://github.com/golang/tools/blob/master/gopls/doc/vim.md#imports
function GoImports()
  vim.lsp.buf.formatting_sync()

  local params = vim.lsp.util.make_range_params()
  params.context = { source = { organizeImports = true } }
  local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
  if not result or next(result) == nil then return end
  local actions = result[1].result
  if not actions then return end
  local action = actions[1]

  if action.edit or type(action.command) == "table" then
    if action.edit then
      vim.lsp.util.apply_workspace_edit(action.edit)
    end
    if type(action.command) == "table" then
      vim.lsp.buf.execute_command(action.command)
    end
  else
    vim.lsp.buf.execute_command(action)
  end
end

function GoToDefinitionTab()
  local params = vim.lsp.util.make_position_params()
  local method = 'textDocument/definition'
  vim.lsp.buf_request(0, method, params, GoToDefinitionTabHandler)
end

function GoToDefinitionTabHandler(_, _, result)
  if not result or not result[1] then
    print('no definition to jump to')
    return
  end
  -- apparently it's possible for 'textDocument/definition' to return more than
  -- one result. This implementation only handles the first one
  local expr = string.sub(result[1]['uri'], string.len('file://')+1)
  vim.api.nvim_command('tab drop ' .. expr)
  vim.lsp.util.jump_to_location(result[1])
end

-- completion
require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;

  source = {
    vsnip = true;
    nvim_lsp = true;
    treesitter = true;
  };
}
vim.opt.completeopt = { 'menuone', 'noinsert', 'noselect' }
vim.opt.shortmess = 'filnxtToOFc'
vim.api.nvim_set_keymap('i', '<CR>', 'compe#confirm("\\<CR>")', { noremap = true, silent = true, expr = true })
vim.api.nvim_set_keymap('i', '<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', { expr = true })
vim.api.nvim_set_keymap('i', '<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<S-Tab>"', { expr = true })

-- treesitter
local ts = require 'nvim-treesitter.configs'
ts.setup {
  ensure_installed = 'maintained',
  highlight = {
    enable = true,
  },
}

-- filetype specific
vim.api.nvim_command('autocmd FileType go nnoremap <buffer> <Leader>tp :lua GoTestPkg()<CR>')
vim.api.nvim_command('autocmd FileType go nnoremap <buffer> <Leader>tf :lua GoTestFunc()<CR>')
vim.api.nvim_command('autocmd FileType typescript,typescriptreact nnoremap <buffer> <Leader>t :tabe term://npx react-scripts test %<CR> i')
vim.api.nvim_command('autocmd FileType typescript,typescriptreact nnoremap <buffer> <Leader>f :!npx eslint --fix %<CR>')
vim.api.nvim_command('autocmd FileType tf nnoremap <buffer> <Leader>f :lua RunBuf("terraform fmt -")<CR>')
vim.api.nvim_command('autocmd FileType tf nnoremap <buffer> <Leader>ti :tabe term://cd %:h && terraform init<CR>i')
vim.api.nvim_command('autocmd FileType tf nnoremap <buffer> <Leader>tp :tabe term://cd %:h && terraform plan<CR>i')
vim.api.nvim_command('autocmd FileType tf nnoremap <buffer> <Leader>tu :!(cd %:h && terraenv terraform use)<CR>')
vim.api.nvim_command('autocmd FileType tf setlocal commentstring=#\\ %s')
vim.api.nvim_command('autocmd FileType help set nu rnu')
vim.api.nvim_command('autocmd BufNewFile,BufRead Jenkinsfile setf groovy')

-- helper functions
function GoTestPkg()
  RunTerm(string.format('(cd %s && go test -v -count=1)', vim.fn.expand('%:p:h')))
end

function GoTestFunc()
  local linenum = vim.fn.search('func \\(Test\\|Example\\)', 'bcnW')
  if linenum == 0 then
	vim.api.nvim_echo({{'no test found', 'WarningMsg'}}, false, {})
    return
  end
  local line = vim.fn.getline(linenum)
  local testname = string.sub(line, string.len('func ')+1, string.find(line, '%(')-1)
  if testname == '' then
	vim.api.nvim_echo({{'no test found', 'WarningMsg'}}, false, {})
    return
  end
  RunTerm(string.format('(cd %s && go test -v -count=1 -run ^%s$)', vim.fn.expand('%:p:h'), testname))
end

function RunTerm(cmd)
  local cols = vim.fn.winwidth(0) - vim.wo.numberwidth
  local rows = vim.fn.winheight(0)
  local width = math.floor(0.9 * cols)
  local height = math.floor(0.9 * rows)
  local col = (cols - width) / 2 + vim.wo.numberwidth
  local row = (rows - height) / 2
  local outerbuf = vim.api.nvim_create_buf(false, true)
  local innerbuf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_open_win(outerbuf, false, {relative='win', style='minimal', col=col, row=row, width=width, height=height, focusable=false})
  vim.api.nvim_open_win(innerbuf, true, {relative='win', style='minimal', col=col+1, row=row, width=width-2, height=height})
  vim.api.nvim_command(string.format('au BufWipeout <buffer=%d> exe "bw %d"', innerbuf, outerbuf))
  vim.fn.termopen(cmd)
  vim.api.nvim_command('startinsert')
end

function RunBuf(cmd)
  local buffer_content = table.concat(vim.fn.getline(1, '$'), '\n')
  local lines = vim.fn.systemlist(cmd, buffer_content)
  if vim.v['shell_error'] ~= 0 then
    print(table.concat(lines, '\n'))
    return
  end
  vim.fn.setline(1, lines)
  if vim.fn.line('$') > #lines then
    vim.api.nvim_command(string.format('%d,$ delete', #lines + 1))
  end
end

require'init2'
