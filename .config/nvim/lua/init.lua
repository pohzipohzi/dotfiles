-- unmap unused keys
for _, lhs in ipairs({
  '<Up>',
  '<Down>',
  '<Left>',
  '<Right>',
  '<C-f>',
  '<C-b>',
  '<Space>',
}) do
vim.api.nvim_set_keymap('', lhs, '<NOP>', { noremap = true })
end

-- set options
vim.api.nvim_win_set_option(0, 'nu', true)
vim.api.nvim_win_set_option(0, 'rnu', true)
vim.api.nvim_win_set_option(0, 'colorcolumn', '80')
vim.api.nvim_win_set_option(0, 'cursorline', true)
vim.api.nvim_buf_set_option(0, 'expandtab', true)
vim.api.nvim_buf_set_option(0, 'swapfile', false)
vim.api.nvim_set_option('clipboard', 'unnamedplus')
vim.api.nvim_set_option('updatetime', 100)
vim.api.nvim_set_option('termguicolors', true)
vim.api.nvim_command('colorscheme nord')

-- leader mappings
vim.api.nvim_set_var('mapleader', ' ')
vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader><Leader>', ':tabe $MYVIMRC<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>s', ':so $MYVIMRC<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>yy', ':let @+=expand("%")<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>yl', ':let @+=expand("%").":".line(".")<CR>', { noremap = true })

-- status
vim.api.nvim_set_var('lightline', {
  colorscheme = 'nord',
  active = {
    left = {
      { 'mode', 'paste' },
      { 'fugitive' },
      { 'readonly', 'filename', 'modified' },
    },
  },
  component_function = {
    filename = 'LightlineFilename',
    fugitive = 'FugitiveHead',
  },
})

-- navigation
vim.api.nvim_set_var('netrw_bufsettings', 'nu rnu')
vim.api.nvim_set_var('netrw_fastbrowse', 0)
vim.api.nvim_set_var('fzf_colors', {
  gutter = { 'bg', 'Normal' },
})
vim.api.nvim_set_var('fzf_layout', {
  window = {
    width = 0.9,
    height = 0.8,
  },
})
vim.api.nvim_set_keymap('n', '<C-h>', ':tabp<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-l>', ':tabn<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-j>', ':cnext<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-k>', ':cprev<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-x>', ':pc<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-c>', ':ccl<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-f>', ':GFiles<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-g>', ':GGrep<CR>', { noremap = true })

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

-- lsp
local lsp = require 'lspconfig'
local compl = require 'completion'

lsp.gopls.setup{
  cmd = {'gopls', '-vv', '-rpc.trace', '-logfile', os.getenv('HOME') .. '/.gopls.log'},
  on_attach = compl.on_attach,
}
lsp.sumneko_lua.setup{
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
  on_attach = compl.on_attach,
}
lsp.ccls.setup{}
lsp.pyls.setup{}
lsp.solargraph.setup{}
lsp.tsserver.setup{}
lsp.yamlls.setup{}
lsp.jsonls.setup{}
lsp.vimls.setup{}

vim.api.nvim_set_keymap('n', '<Leader>e', ':tab split<bar>lua vim.lsp.buf.definition()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>d', ':lua vim.lsp.buf.definition()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>q', ':lua vim.lsp.buf.hover()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>u', ':lua vim.lsp.buf.references()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>r', ':lua vim.lsp.buf.rename()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>i', ':lua vim.lsp.buf.implementation()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-n>', ':lua vim.lsp.diagnostic.goto_next()<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-p>', ':lua vim.lsp.diagnostic.goto_prev()<CR>', { noremap = true })

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
vim.lsp.diagnostic.on_publish_diagnostics, {
  virtual_text = false,
  signs = true,
  update_in_insert = false,
}
)

vim.lsp.set_log_level("debug")
vim.api.nvim_set_keymap('n', '<Leader>ll', ':tabe ' .. vim.lsp.get_log_path() .. '<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>gl', ':tabe ' .. os.getenv('HOME') .. '/.gopls.log' .. '<CR>', { noremap = true })

function GoImports()
  local context = { source = { organizeImports = true } }
  vim.validate { context = { context, "t", true } }
  local params = vim.lsp.util.make_range_params()
  params.context = context
  local method = "textDocument/codeAction"
  local resp = vim.lsp.buf_request_sync(0, method, params)
  if resp and resp[1] then
    local result = resp[1].result
    if result and result[1] then
      local edit = result[1].edit
      vim.lsp.util.apply_workspace_edit(edit)
    end
  end
  vim.lsp.buf.formatting()
end

-- completion
vim.api.nvim_set_option('completeopt', 'menuone,noinsert,noselect')
vim.api.nvim_set_option('shortmess', 'filnxtToOFc')
vim.api.nvim_set_var('completion_enable_snippet', 'vim-vsnip')
vim.api.nvim_set_var('completion_chain_complete_list', {
  go = {
    default = {
      { complete_items = {'snippet', 'lsp'}},
    },
  },
})

-- treesitter
local ts = require 'nvim-treesitter.configs'
ts.setup {
  ensure_installed = 'maintained',
  highlight = {
    enable = true,
  },
}
