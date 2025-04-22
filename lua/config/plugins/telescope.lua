return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
  },
  config = function()
    require('telescope').setup {
      extensions = {
        fzf = {
        }
      }
    }
    require('telescope').load_extension('fzf')
    require "config.telescope.multigrep".setup()

    local map = function(keys, func, desc)
      vim.keymap.set('n', keys, func, { desc = 'LSP: ' .. desc })
    end


    local builtin = require('telescope.builtin')
    local default_opts = require('telescope.themes').get_ivy()

    local function opts_built_in(builtin_func, opts)
      return function()
        builtin_func(opts)
      end
    end

    map('gd', builtin.lsp_definitions, '[G]oto [D]efinition')
    vim.keymap.set('n', '<leader>ff', opts_built_in(builtin.find_files, default_opts), { desc = 'Telescope find files' })
    vim.keymap.set('n', '<leader>fh', opts_built_in(builtin.find_help, default_opts), { desc = 'Telescope find help' })
    vim.keymap.set('n', '<leader>fw', opts_built_in(builtin.live_grep, default_opts), { desc = 'Telescope live grep' })
    vim.keymap.set('n', '<leader>fb', opts_built_in(builtin.buffers, default_opts), { desc = 'Telescope buffers' })
    vim.keymap.set('n', '<leader>fh', opts_built_in(builtin.help_tags, default_opts), { desc = 'Telescope help tags' })
    vim.keymap.set("n", "<space>nn", function()
      local opts = require('telescope.themes').get_ivy({
        cwd = vim.fn.stdpath("config")
      })
      builtin.find_files(opts)
    end, { desc = 'Edit neovim' })
    vim.keymap.set("n", "<space>np", function()
      local opts = require('telescope.themes').get_ivy({
        cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy")
      })
      builtin.find_files(opts)
    end, { desc = 'Edit packages' })
  end
}
