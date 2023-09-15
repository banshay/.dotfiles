--[[

=====================================================================
==================== READ THIS BEFORE CONTINUING ====================
=====================================================================

Kickstart.nvim is *not* a distribution.

Kickstart.nvim is a template for your own configuration.
  The goal is that you can read every line of code, top-to-bottom, understand
  what your configuration is doing, and modify it to suit your needs.

  Once you've done that, you should start exploring, configuring and tinkering to
  explore Neovim!

  If you don't know anything about Lua, I recommend taking some time to read through
  a guide. One possible example:
  - https://learnxinyminutes.com/docs/lua/

  And then you can explore or search through `:help lua-guide`


Kickstart Guide:

I have left several `:help X` comments throughout the init.lua
You should run that command and read that help section for more information.

In addition, I have some `NOTE:` items throughout the file.
These are for you, the reader to help understand what is happening. Feel free to delete
them once you know what you're doing, but they should serve as a guide for when you
are first encountering a few different constructs in your nvim config.

I hope you enjoy your Neovim journey,
- TJ

P.S. You can delete this when you're done too. It's your config now :)
--]]
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
   vim.fn.system {
      'git',
      'clone',
      '--filter=blob:none',
      'https://github.com/folke/lazy.nvim.git',
      '--branch=stable', -- latest stable release
      lazypath,
   }
end
vim.opt.rtp:prepend(lazypath)

-- NOTE: Here is where you install your plugins.
--  You can configure plugins using the `config` key.
--
--  You can also configure plugins after the setup call,
--    as they will be available in your neovim runtime.
require('lazy').setup({
   -- NOTE: First, some plugins that don't require any configuration

   -- Git related plugins
   'tpope/vim-fugitive',
   'tpope/vim-rhubarb',

   -- Detect tabstop and shiftwidth automatically
   -- 'tpope/vim-sleuth',

   -- NOTE: This is where your plugins related to LSP can be installed.
   --  The configuration is done below. Search for lspconfig to find it below.
   {
      -- LSP Configuration & Plugins
      'neovim/nvim-lspconfig',
      dependencies = {
         -- Automatically install LSPs to stdpath for neovim
         { 'williamboman/mason.nvim', config = true },
         'williamboman/mason-lspconfig.nvim',

         -- Useful status updates for LSP
         -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
         { 'j-hui/fidget.nvim',       tag = 'legacy', opts = {} },

         -- Additional lua configuration, makes nvim stuff amazing!
         'folke/neodev.nvim',
      },
   },

   {
      -- Autocompletion
      'hrsh7th/nvim-cmp',
      dependencies = {
         -- Snippet Engine & its associated nvim-cmp source
         'L3MON4D3/LuaSnip',
         'saadparwaiz1/cmp_luasnip',

         -- Adds LSP completion capabilities
         'hrsh7th/cmp-nvim-lsp',

         -- Adds a number of user-friendly snippets
         'rafamadriz/friendly-snippets',
      },
   },

   -- Useful plugin to show you pending keybinds.
   { 'folke/which-key.nvim',       opts = {} },
   {
      -- Adds git related signs to the gutter, as well as utilities for managing changes
      'lewis6991/gitsigns.nvim',
      opts = {
         -- See `:help gitsigns.txt`
         signs = {
            add = { text = '+' },
            change = { text = '~' },
            delete = { text = '_' },
            topdelete = { text = '‾' },
            changedelete = { text = '~' },
         },
         on_attach = function(bufnr)
            vim.keymap.set('n', '<leader>gp', require('gitsigns').prev_hunk,
               { buffer = bufnr, desc = '[G]o to [P]revious Hunk' })
            vim.keymap.set('n', '<leader>gn', require('gitsigns').next_hunk,
               { buffer = bufnr, desc = '[G]o to [N]ext Hunk' })
            vim.keymap.set('n', '<leader>ph', require('gitsigns').preview_hunk,
               { buffer = bufnr, desc = '[P]review [H]unk' })
         end,
      },
   },

   -- {
   --   -- Theme inspired by Atom
   --   'navarasu/onedark.nvim',
   --   priority = 1000,
   --   config = function()
   --     vim.cmd.colorscheme 'onedark'
   --   end,
   -- },
   -- {
   --   "briones-gabriel/darcula-solid.nvim",
   --   dependencies = "rktjmp/lush.nvim",
   --   config = function()
   --     vim.cmd 'colorscheme darcula-solid'
   --   end,
   -- },
   -- {
   --   "banshay/my_color_scheme",
   --   config = function()
   --     vim.cmd.colorscheme "intellij_new"
   --   end
   -- },
   -- Install without configuration
   { 'projekt0n/github-nvim-theme' },

   -- Or with configuration
   {
      'projekt0n/github-nvim-theme',
      lazy = false,  -- make sure we load this during startup if it is your main colorscheme
      priority = 1000, -- make sure to load this before all the other start plugins
      config = function()
         require('github-theme').setup({
            -- ...
         })

         vim.cmd('colorscheme github_dark')
      end,
   },


   {
      -- Set lualine as statusline
      'nvim-lualine/lualine.nvim',
      -- See `:help lualine.txt`
      opts = {
         options = {
            icons_enabled = false,
            theme = 'onedark',
            component_separators = '|',
            section_separators = '',
         },
      },
   },

   -- {
   --   -- Add indentation guides even on blank lines
   --   'lukas-reineke/indent-blankline.nvim',
   --   -- Enable `lukas-reineke/indent-blankline.nvim`
   --   -- See `:help indent_blankline.txt`
   --   opts = {
   --     char = '┊',
   --     show_trailing_blankline_indent = false,
   --   },
   -- },

   -- "gc" to comment visual regions/lines
   { 'numToStr/Comment.nvim',         opts = {} },

   -- Fuzzy Finder (files, lsp, etc)
   { 'nvim-telescope/telescope.nvim', branch = '0.1.x', dependencies = { 'nvim-lua/plenary.nvim' } },

   -- Fuzzy Finder Algorithm which requires local dependencies to be built.
   -- Only load if `make` is available. Make sure you have the system
   -- requirements installed.
   {
      'nvim-telescope/telescope-fzf-native.nvim',
      -- NOTE: If you are having trouble with this installation,
      --       refer to the README for telescope-fzf-native for more instructions.
      build = 'make',
      cond = function()
         return vim.fn.executable 'make' == 1
      end,
   },

   {
      "nvim-telescope/telescope-file-browser.nvim",
      dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
   },

   { "nvim-treesitter/playground" },

   {
      -- Highlight, edit, and navigate code
      'nvim-treesitter/nvim-treesitter',
      dependencies = {
         'nvim-treesitter/nvim-treesitter-textobjects',
      },
      build = ':TSUpdate',
   },

   -- NOTE: Next Step on Your Neovim Journey: Add/Configure additional "plugins" for kickstart
   --       These are some example plugins that I've included in the kickstart repository.
   --       Uncomment any of the lines below to enable them.
   -- require 'kickstart.plugins.autoformat',
   -- require 'kickstart.plugins.debug',

   -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
   --    You can use this folder to prevent any conflicts with this init.lua if you're interested in keeping
   --    up-to-date with whatever is in the kickstart repo.
   --    Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
   --
   --    For additional information see: https://github.com/folke/lazy.nvim#-structuring-your-plugins
   -- { import = 'custom.plugins' },
   {
      "kylechui/nvim-surround",
      version = "*", -- Use for stability; omit to use `main` branch for the latest features
      event = "VeryLazy",
      -- config = function()
      --   require("nvim-surround").setup({
      --     -- Configuration here, or leave empty to use defaults
      --   })
      -- end
   },

   {
      "mbbill/undotree",
   },

   {
      "theprimeagen/harpoon",
      config = function()
         require("harpoon").setup({
            menu = {
               width = vim.api.nvim_win_get_width(0) - 4,
            }
         })
      end
   },
   { "ThePrimeagen/vim-be-good" },

   { "mfussenegger/nvim-jdtls" },

}, {})

-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!

-- Set highlight on search
vim.o.hlsearch = false
vim.o.incsearch = true

-- Make line numbers default
vim.wo.number = true
vim.opt.relativenumber = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.scrolloff = 16

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 3
vim.opt.expandtab = true


-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
   callback = function()
      vim.highlight.on_yank()
   end,
   group = highlight_group,
   pattern = '*',
})

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require('telescope').setup {
   defaults = {
      path_display = {
         truncate = {},
      },
      mappings = {
         i = {
            ['<C-u>'] = false,
            ['<C-d>'] = false,
         },
      },
      pickers = {
         lsp_references = {
            fname_width = 100,
            show_line = false,
         },
      },
   },
   extensions = {
      file_browser = {
         hijack_netrw = true,
      }
   }
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')
-- Enable telescope file browser extension
pcall(require('telescope').load_extension, 'file_browser')

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
   -- You can pass additional configuration to telescope to change theme, layout, etc.
   require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
      winblend = 10,
      previewer = false,
   })
end, { desc = '[/] Fuzzily search in current buffer' })

vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
vim.keymap.set('n', '<leader>gcb', require('telescope.builtin').git_branches, { desc = 'Search [G]it [B]ranches' })
vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
require('nvim-treesitter.configs').setup {
   -- Add languages to be installed here that you want installed for treesitter
   ensure_installed = { 'java', 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'typescript', 'vimdoc', 'vim' },
   sync_install = false,
   ignore_install = {},
   modules = {},


   -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
   auto_install = false,

   highlight = { enable = true },
   indent = { enable = true },
   incremental_selection = {
      enable = true,
      keymaps = {
         init_selection = '<c-space>',
         node_incremental = '<c-space>',
         scope_incremental = '<c-s>',
         node_decremental = '<M-space>',
      },
   },
   textobjects = {
      select = {
         enable = true,
         lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
         keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ['aa'] = '@parameter.outer',
            ['ia'] = '@parameter.inner',
            ['af'] = '@function.outer',
            ['if'] = '@function.inner',
            ['ac'] = '@class.outer',
            ['ic'] = '@class.inner',
         },
      },
      move = {
         enable = true,
         set_jumps = true, -- whether to set jumps in the jumplist
         goto_next_start = {
            [']m'] = '@function.outer',
            [']]'] = '@class.outer',
         },
         goto_next_end = {
            [']M'] = '@function.outer',
            [']['] = '@class.outer',
         },
         goto_previous_start = {
            ['[m'] = '@function.outer',
            ['[['] = '@class.outer',
         },
         goto_previous_end = {
            ['[M'] = '@function.outer',
            ['[]'] = '@class.outer',
         },
      },
      swap = {
         enable = true,
         swap_next = {
            ['<leader>s'] = '@parameter.inner',
         },
         swap_previous = {
            ['<leader>S'] = '@parameter.inner',
         },
      },
   },
}

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })


-- [[ Configure LSP ]]
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = require("lsp_keymaps")


-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
--
--  If you want to override the default filetypes that your language server will attach to you can
--  define the property 'filetypes' to the map in question.
local servers = {
   -- clangd = {},
   -- gopls = {},
   -- pyright = {},
   -- rust_analyzer = {},
   -- tsserver = {},
   -- html = { filetypes = { 'html', 'twig', 'hbs'} },

   lua_ls = {
      Lua = {
         workspace = { checkThirdParty = false },
         telemetry = { enable = false },
      },
   },
}

-- Setup neovim lua configuration
require('neodev').setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
   ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
   function(server_name)
      require('lspconfig')[server_name].setup {
         capabilities = capabilities,
         on_attach = on_attach,
         settings = servers[server_name],
         filetypes = (servers[server_name] or {}).filetypes,
      }
   end,
   ["jdtls"] = function() end,
}


-- [[ Configure nvim-cmp ]]
-- See `:help cmp`
local cmp = require 'cmp'
local luasnip = require 'luasnip'
require('luasnip.loaders.from_vscode').lazy_load()
luasnip.config.setup {}

cmp.setup {
   snippet = {
      expand = function(args)
         luasnip.lsp_expand(args.body)
      end,
   },
   mapping = cmp.mapping.preset.insert {
      ['<C-j>'] = cmp.mapping.select_next_item(),
      ['<C-k>'] = cmp.mapping.select_prev_item(),
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      --    ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete {},
      ['<CR>'] = cmp.mapping.confirm {
         behavior = cmp.ConfirmBehavior.Replace,
         select = true,
      },
      ['<Tab>'] = cmp.mapping(function(fallback)
         if cmp.visible() then
            cmp.select_next_item()
         elseif luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
         else
            fallback()
         end
      end, { 'i', 's' }),
      ['<S-Tab>'] = cmp.mapping(function(fallback)
         if cmp.visible() then
            cmp.select_prev_item()
         elseif luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
         else
            fallback()
         end
      end, { 'i', 's' }),
   },
   sources = {
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
   },
}

require("keymaps")

require("my_harpoon")

-- vim.cmd.colorscheme "intellij_new"

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et



-- close quickfix menu after selecting choice
vim.api.nvim_create_autocmd(
   "FileType", {
      pattern = { "qf" },
      command = [[nnoremap <buffer> <CR> <CR>:cclose<CR>]]
   }
)


-- autosave when focus lost or buffer changes
vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost" }, {
   callback = function()
      if vim.bo.modified and not vim.bo.readonly and vim.fn.expand("%") ~= "" and vim.bo.buftype == "" then
         vim.api.nvim_command('silent update')
      end
   end
})

--format on save for java
vim.api.nvim_create_autocmd("BufWritePost", {
   group = vim.api.nvim_create_augroup("google-java-format", { clear = true }),
   pattern = "*.java",
   callback = function()
      local bufnr = vim.fn.expand("<abuf>")
      if bufnr then
         local full_file_name = vim.fn.expand("%:p")
         local command = "java -jar " ..
             vim.fn.expand("~/.local/share/nvim/mason/packages/google-java-format/") ..
             "google-java-format-1.17.0-all-deps.jar --replace " .. full_file_name

         -- local replace_content = function(_, data)
         --   if data then
         --     vim.api.nvim_buf_set_lines(tonumber(bufnr), 0, -1, false, data)
         --   end
         -- end

         vim.fn.jobstart(command, {
            -- stdout_buffered = true,
            -- on_stdout = replace_content,
            on_exit = function()
               vim.api.nvim_cmd({
                  cmd = "edit"
               }, {})
            end
         })
      end
   end,
})
