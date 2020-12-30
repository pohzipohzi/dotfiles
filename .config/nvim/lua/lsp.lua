local lsp = require 'lspconfig'

lsp.gopls.setup{}
lsp.ccls.setup{}
lsp.pyls.setup{}
lsp.solargraph.setup{}
lsp.tsserver.setup{}
lsp.yamlls.setup{}
lsp.jsonls.setup{}
lsp.sumneko_lua.setup{}
lsp.vimls.setup{}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = false,
    signs = true,
    update_in_insert = false,
  }
)

