-- shortcuts
local switch = {
  ['go'] = function()
    local prog = vim.fn.expand('%')
    local build = vim.fn.expand('%:p:r')
    local input = vim.fn.expand('%:h') .. '/in'
    local cases_cmd = string.format('go build -o %s %s && piper -o -c %s < %s', build, prog, build, input)
    local interactive_cmd = string.format('go run %s', prog)
    return cases_cmd, interactive_cmd
  end,
  ['c'] = function()
    local prog = vim.fn.expand('%')
    local build = vim.fn.expand('%:h') .. '/a.out'
    local input = vim.fn.expand('%:h') .. '/in'
    local cases_cmd = string.format('gcc %s && piper -o -c %s < %s', prog, build, input)
    local interactive_cmd = string.format('gcc %s && %s', prog, build)
    return cases_cmd, interactive_cmd
  end,
}
local cases_cmd, interactive_cmd = switch[vim.bo.filetype]()
vim.api.nvim_buf_set_keymap(0, 'n', '<Leader>zc', string.format(':lua RunTerm("%s")<CR>', cases_cmd), { noremap=true })
vim.api.nvim_buf_set_keymap(0, 'n', '<Leader>zi', string.format(':lua RunTerm("%s")<CR>', interactive_cmd), { noremap=true })
vim.api.nvim_set_keymap('n', '<Leader>zo', ':tabe $HOME/dotfiles/.scripts/cp/<CR>', { noremap = true })

-- layout
vim.api.nvim_command('vsplit out')
vim.api.nvim_command('split in')
vim.api.nvim_command('vert 3resize ' .. (vim.wo.colorcolumn + vim.wo.numberwidth + 4))
