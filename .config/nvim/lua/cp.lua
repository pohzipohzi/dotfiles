-- shortcuts
vim.api.nvim_command('autocmd FileType go nnoremap <buffer> <Leader>zc :lua RunTerm(RunCasesGo())<CR>')
vim.api.nvim_command('autocmd FileType go nnoremap <buffer> <Leader>zi :lua RunTerm(RunInteractiveGo())<CR>')
vim.api.nvim_command('autocmd FileType c nnoremap <buffer> <Leader>zc :lua RunTerm(RunCasesC())<CR>')
vim.api.nvim_set_keymap('n', '<Leader>zo', ':tabe $HOME/dotfiles/.scripts/cp/<CR>', { noremap = true })

function RunCasesGo()
  local prog = vim.fn.expand('%')
  local build = vim.fn.expand('%:p:r')
  local input = vim.fn.expand('%:h') .. '/in'
  return string.format('go build -o %s %s && piper -o -c %s < %s', build, prog, build, input)
end

function RunInteractiveGo()
  local prog = vim.fn.expand('%')
  return string.format('go run %s', prog)
end

function RunCasesC()
  local prog = vim.fn.expand('%')
  local build = vim.fn.expand('%:h') .. '/a.out'
  local input = vim.fn.expand('%:h') .. '/in'
  return string.format('gcc %s && piper -o -c %s < %s', prog, build, input)
end

-- layout
vim.api.nvim_command('e')
vim.api.nvim_command('vsplit out')
vim.api.nvim_command('split in')
vim.api.nvim_command('vert 3resize ' .. (vim.wo.colorcolumn + vim.wo.numberwidth + 4))
