require("config.lazy")

vim.opt.shiftwidth = 4
vim.o.tabstop = 4
vim.opt.clipboard = "unnamedplus"

vim.wo.number = true
vim.wo.relativenumber = true

vim.keymap.set("n", "<space><space>x", "<cmd>source %<CR>")
vim.keymap.set("n", "<space>x", ":.lua<CR>")
vim.keymap.set("v", "<space>x", ":lua<CR>")

vim.keymap.set("n", "<M-j>", "<cmd>cnext<CR>")
vim.keymap.set("n", "<M-k>", "<cmd>cprev<CR>")

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = "Highlight when yanking text",
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd('TermOpen', {
  desc = "Open integrated terminal",
  group = vim.api.nvim_create_augroup('custom-term-open', { clear = true }),
  callback = function()
    vim.opt.number = false;
    vim.opt.relativenumber = true;
  end,
})

vim.cmd.colorscheme "catppuccin"

local map = function(keys, func, desc)
  vim.keymap.set('n', keys, func, { desc = 'LSP: ' .. desc })
end

map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
map('<leader>lr', vim.lsp.buf.rename, 'Rename')
map('<leader>la', vim.lsp.buf.code_action, 'Code action')
map('K', vim.lsp.buf.hover, 'Hover Documentation')

-- Tmux navigation symbols
vim.keymap.set('n', '<C-h>', '<cmd> TmuxNavigateLeft<CR>', { desc = 'navigate to left tmux pane' })
vim.keymap.set('n', '<C-l>', '<cmd> TmuxNavigateRight<CR>', { desc = 'navigate to right tmux pane' })
vim.keymap.set('n', '<C-j>', '<cmd> TmuxNavigateDown<CR>', { desc = 'navigate to down tmux pane' })
vim.keymap.set('n', '<C-k>', '<cmd> TmuxNavigateUp<CR>', { desc = 'navigate to up tmux pane' })

local wk = require("which-key")
wk.add({
  { "<leader>f", group = "Find", icon = "" },
  { "<leader>n", group = "Neovim", icon = "󱇧" },
  { "<leader>l", group = "LSP", icon = "" },
})

wk.add({
  { "<space><space>x", hidden = true },
  { "<space>x",        hidden = true, mode = "n" },
  { "<space>x",        hidden = true },
  { "<space>?",        hidden = true },
})

local oil = require('oil')
local open_oil_in_current_directory = function()
  oil.open(oil.get_current_dir())
end
map('<space>e', open_oil_in_current_directory, 'Open Explorer')

vim.diagnostic.config({
  virtual_text = true,
  signs = false,
  underline = true,
})

require('lualine').setup({})
require('mason').setup({})
