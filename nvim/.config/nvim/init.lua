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
require("mason-lspconfig").setup({
    -- ruff only does lint/format/hover, no go-to-definition or completion;
    -- basedpyright covers those for Python.
    ensure_installed = { "ruff", "basedpyright" },
})

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

-- Use the project's own Python interpreter (uv/venv/virtualenv), not a global
-- one: an active $VIRTUAL_ENV wins, otherwise look for .venv/venv/env at the
-- project root (uv creates .venv there by default).
local function find_venv_python(root_dir)
    if not root_dir then
        return nil
    end
    local venv = vim.env.VIRTUAL_ENV
    if venv and vim.fn.executable(venv .. "/bin/python") == 1 then
        return venv .. "/bin/python"
    end
    for _, dir in ipairs({ ".venv", "venv", "env" }) do
        local candidate = root_dir .. "/" .. dir .. "/bin/python"
        if vim.fn.executable(candidate) == 1 then
            return candidate
        end
    end
    return nil
end

vim.lsp.config("basedpyright", {
    before_init = function(_, config)
        local python_path = find_venv_python(config.root_dir)
        if python_path then
            config.settings = vim.tbl_deep_extend("force", config.settings or {}, {
                python = { pythonPath = python_path },
            })
        end
    end,
})

vim.lsp.config("ruff", {
    before_init = function(_, config)
        local python_path = find_venv_python(config.root_dir)
        if python_path then
            config.init_options = vim.tbl_deep_extend("force", config.init_options or {}, {
                settings = { interpreter = { python_path } },
            })
        end
    end,
})

vim.lsp.enable('ruff')
vim.lsp.enable('basedpyright')

-- Native LSP completion (built into Neovim, no completion plugin needed).
vim.o.completeopt = "menuone,noselect,popup"
vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client and client:supports_method("textDocument/completion") then
            vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
        end
    end,
})

vim.keymap.set("n", "gd", vim.lsp.buf.definition)


local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
