local lsp = require 'lspconfig'

lsp.gopls.setup{
  cmd = {'gopls', '-vv', '-rpc.trace', '-logfile', os.getenv('HOME') .. '/.gopls.log'};
}
lsp.ccls.setup{}
lsp.pyls.setup{}
lsp.solargraph.setup{}
lsp.tsserver.setup{}
lsp.yamlls.setup{}
lsp.jsonls.setup{}
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
  }
}
lsp.vimls.setup{}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false,
    signs = true,
    update_in_insert = false,
  }
)

-- lsp debug, see logs via ":e `=luaeval('vim.lsp.get_log_path()')`"
vim.lsp.set_log_level("debug")

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
