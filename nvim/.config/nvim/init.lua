vim.o.number = true
vim.o.relativenumber = true

vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

vim.o.swapfile = false
vim.o.clipboard = "unnamedplus"
vim.g.mapleader = " "
vim.o.undofile = true

vim.g.netrw_winsize = 20
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3


vim.cmd("colorscheme habamax")

vim.pack.add({
    { src = 'https://github.com/neovim/nvim-lspconfig' },

    { src = "https://github.com/nvim-lua/plenary.nvim" },
    { src = 'https://github.com/nvim-telescope/telescope.nvim' },

    { src = 'https://github.com/mason-org/mason.nvim' },
    { src = 'https://github.com/mason-org/mason-lspconfig.nvim' },
    { src = 'https://github.com/stevearc/conform.nvim' }
})


require("mason").setup()
require("mason-lspconfig").setup()

require("conform").setup({
    formatters_by_ft = {
        python = { "ruff_format" },
    },
    format_on_save = {
        timeout_ms = 2000,
        lsp_fallback = true,
    },
})


-- vim.lsp.config('ruff', {
--   init_options = {
--     settings = {
--       configurationPreference = "editorFirst",
--       -- configurationPreference = "filesystemFirst",
--       -- codeAction = {
--       --   fixViolation = {
--       --     enable = true
--       --   }
--       -- }
--     }
--   }
-- })
--
--
-- vim.lsp.enable('ruff')



vim.keymap.set("n", "gd", vim.lsp.buf.definition)


local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
