vim.o.number = true
vim.o.relativenumber = true

vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

vim.o.swapfile = false
vim.g.mapleader =" " 



vim.cmd("colorscheme habamax")

vim.pack.add({
      { src = 'https://github.com/neovim/nvim-lspconfig' },

      { src = "https://github.com/nvim-lua/plenary.nvim" },
      { src = 'https://github.com/nvim-telescope/telescope.nvim' },
})


vim.lsp.config('ruff', {
  init_options = {
    settings = {
      configurationPreference = "editorFirst",
      -- configurationPreference = "filesystemFirst",
      -- codeAction = {
      --   fixViolation = {
      --     enable = true
      --   }
      -- }
    }
  }
})


vim.lsp.enable('ruff')
vim.keymap.set("n", "gd", vim.lsp.buf.definition)


local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
