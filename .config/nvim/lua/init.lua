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
      { 'lspstatus' },
    },
    right = {
      { 'readonly', 'filename', 'modified', 'filetype' },
    },
  },
  component_function = {
    filename = 'LightlineFilename',
    fugitive = 'FugitiveHead',
    lspstatus = 'LspStatus',
  },
})
local messaging = require('lsp-status/messaging')
function LspStatus()
  if vim.lsp.buf_get_clients() == 0 then
    return ''
  end
  local buf_messages = messaging.messages()
  local msgs = {}
  local function build_message(msg)
    if msg.progress then
      local contents = msg.title
      if msg.message then
	contents = contents .. ': ' .. msg.message
      end
      if msg.percentage then
	contents = contents .. ' (' .. msg.percentage .. ')'
      end
      return contents
    end
    return msg.content
  end
  for _, msg in ipairs(buf_messages) do
    table.insert(msgs, '[' .. msg.name .. '] ' .. build_message(msg))
  end
  return table.concat(msgs, ' ')
end

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
vim.api.nvim_command('autocmd! FileType fzf set laststatus=0 noshowmode noruler | autocmd BufLeave <buffer> set laststatus=2 showmode ruler')
vim.api.nvim_command("command! -bang -nargs=* GGrep call fzf#vim#grep('git grep -n -- '.shellescape(<q-args>), 0, fzf#vim#with_preview({'dir': input('git grep dir: ', expand('%:p:h'), 'file')}), <bang>0)")

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
local lspconfig = require 'lspconfig'
local completion = require 'completion'
local lsp_status = require 'lsp-status'
lsp_status.register_progress()
local function OnAttach(client)
  completion.on_attach(client)
  lsp_status.on_attach(client)
end

lspconfig.gopls.setup{
  cmd = {'gopls', '-vv', '-rpc.trace', '-logfile', os.getenv('HOME') .. '/.gopls.log'},
  on_attach = OnAttach,
  capabilities = lsp_status.capabilities,
}
lspconfig.sumneko_lua.setup{
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
  on_attach = OnAttach,
  capabilities = lsp_status.capabilities,
}
lspconfig.ccls.setup{}
lspconfig.pyls.setup{}
lspconfig.solargraph.setup{}
lspconfig.tsserver.setup{}
lspconfig.yamlls.setup{}
lspconfig.jsonls.setup{}
lspconfig.vimls.setup{}

vim.api.nvim_set_keymap('n', '<Leader>e', ':lua GoToDefinitionTab()<CR>', { noremap = true })
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
  vim.validate { context = { context, 't', true } }
  local params = vim.lsp.util.make_range_params()
  params.context = context
  local method = 'textDocument/codeAction'
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

function GoToDefinitionTab()
  local params = vim.lsp.util.make_position_params()
  local method = 'textDocument/definition'
  vim.lsp.buf_request(0, method, params, GoToDefinitionTabHandler)
end

function GoToDefinitionTabHandler(_, _, result)
  -- apparently it's possible for 'textDocument/definition' to return more than
  -- one result. This implementation only handles the first one
  local expr = string.sub(result[1]['uri'], string.len('file://')+1)
  vim.api.nvim_command('tab drop ' .. expr)
  vim.lsp.util.jump_to_location(result[1])
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
vim.api.nvim_command('inoremap <expr><Tab>   pumvisible() ? "\\<C-n>" : "\\<Tab>"')
vim.api.nvim_command('inoremap <expr><S-Tab> pumvisible() ? "\\<C-p>" : "\\<S-Tab>"')

-- treesitter
local ts = require 'nvim-treesitter.configs'
ts.setup {
  ensure_installed = 'maintained',
  highlight = {
    enable = true,
  },
}

-- filetype specific
vim.api.nvim_command('autocmd FileType go nnoremap <buffer> <Leader>zz :tabe term://go run % < %:h/in<CR> i')
vim.api.nvim_command('autocmd FileType go nnoremap <buffer> <Leader>zc :tabe term://go build -o %:r % && piper -c %:p:r < %:h/in<CR> i')
vim.api.nvim_command('autocmd FileType go nnoremap <buffer> <Leader>zi :tabe term://go build -o %:r % && piper -c %:p:r<CR> i')
vim.api.nvim_command('autocmd FileType go nnoremap <buffer> <Leader>f :lua GoImports()<CR>')
vim.api.nvim_command('autocmd FileType go nnoremap <buffer> <Leader>tp :lua GoTestPkg()<CR>')
vim.api.nvim_command('autocmd FileType go nnoremap <buffer> <Leader>tf :lua GoTestFunc()<CR>')
vim.api.nvim_command('autocmd FileType go set tabstop=4')
vim.api.nvim_command('autocmd FileType go set shiftwidth=4')
vim.api.nvim_command('autocmd FileType go set noet')
vim.api.nvim_command('autocmd FileType typescript,typescriptreact nnoremap <buffer> <Leader>t :tabe term://npx react-scripts test %<CR> i')
vim.api.nvim_command('autocmd FileType typescript,typescriptreact nnoremap <buffer> <Leader>f :!npx eslint --fix %<CR>')
vim.api.nvim_command('autocmd FileType typescript,typescriptreact set shiftwidth=2')
vim.api.nvim_command('autocmd FileType html set shiftwidth=2')
vim.api.nvim_command('autocmd FileType css,scss set shiftwidth=2')
vim.api.nvim_command('autocmd FileType yaml set shiftwidth=2')
vim.api.nvim_command('autocmd FileType json set shiftwidth=2')
vim.api.nvim_command('autocmd FileType json nnoremap <buffer> <Leader>f :call RunBuf("jq -e .")<CR>')
vim.api.nvim_command('autocmd FileType tf nnoremap <buffer> <Leader>f :call RunBuf("terraform fmt -")<CR>')
vim.api.nvim_command('autocmd FileType tf nnoremap <buffer> <Leader>ti :tabe term://cd %:h && terraform init<CR>i')
vim.api.nvim_command('autocmd FileType tf nnoremap <buffer> <Leader>tp :tabe term://cd %:h && terraform plan<CR>i')
vim.api.nvim_command('autocmd FileType tf nnoremap <buffer> <Leader>tu :!(cd %:h && terraenv terraform use)<CR>')
vim.api.nvim_command('autocmd FileType tf setlocal commentstring=#\\ %s')
vim.api.nvim_command('autocmd FileType vim set shiftwidth=2')
vim.api.nvim_command('autocmd FileType help set nu rnu')
vim.api.nvim_command('autocmd BufNewFile,BufRead Jenkinsfile setf groovy')

-- helper functions
function GoTestPkg()
  print('running tests in package: ' .. vim.fn.expand('%:h'))
  RunTerm('go test -v -count=1 ' .. vim.fn.expand('%:p:h'))
end

function GoTestFunc()
  local linenum = vim.fn.search('func \\(Test\\|Example\\)', 'bcnW')
  if linenum == 0 then
    print('no test found')
    return
  end
  local line = vim.fn.getline(linenum)
  local testname = string.sub(line, string.len('func ')+1, string.find(line, '%(')-1)
  if testname == '' then
    print('no test found')
    return
  end
  print('running test: ' .. testname)
  RunTerm('go test -v -count=1 ' .. vim.fn.expand('%:p:h') .. ' -run ^' .. testname .. '$')
end

function RunTerm(cmd)
  vim.api.nvim_command('tabe term://' .. cmd)
end
