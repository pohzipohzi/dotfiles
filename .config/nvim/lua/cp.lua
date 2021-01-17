-- run shortcuts
vim.api.nvim_command('autocmd FileType go nnoremap <buffer> <Leader>zx :lua RunCase()<CR>')
vim.api.nvim_command('autocmd FileType go nnoremap <buffer> <Leader>zc :lua RunCases()<CR>')
vim.api.nvim_command('autocmd FileType go nnoremap <buffer> <Leader>zi :lua RunCaseInteractive()<CR>')

function RunCase()
  local prog = vim.fn.expand('%')
  local input = vim.fn.expand('%:h') .. '/in'
  RunTerm(string.format('go run %s < %s', prog, input))
end

function RunCases()
  local prog = vim.fn.expand('%')
  local build = vim.fn.expand('%:p:r')
  local input = vim.fn.expand('%:h') .. '/in'
  RunTerm(string.format('go build -o %s %s && piper -o -c %s < %s', build, prog, build, input))
end

function RunCaseInteractive()
  local prog = vim.fn.expand('%')
  local build = vim.fn.expand('%:p:r')
  RunTerm(string.format('go build -o %s %s && piper -o -c %s', build, prog, build))
end

-- layout
vim.api.nvim_command('e sol.go')
vim.api.nvim_command('vsplit out')
vim.api.nvim_command('split in')
vim.api.nvim_command('vert 3resize 88')
