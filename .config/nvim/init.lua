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

--  You can also configure plugins after the setup call,
--    as they will be available in your neovim runtime.
require('lazy').setup({
  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',
  'airblade/vim-gitgutter',
  'whiteinge/diffconflicts',

  -- Faster vim motions for jumping to section in code
  'easymotion/vim-easymotion',

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  {"nvim-neo-tree/neo-tree.nvim",
      lazy=false,
      branch = "v3.x",
      dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
      },
  },

  -- json highlighting
  --'elzr/vim-json',

  -- find things (not working in lua)
  'mhinz/vim-grepper',
  --'dyng/ctrlsf.vim',

  --TMUX interactions
  'christoomey/vim-tmux-navigator', --Navigating to and from tmux panes to vim
  'epeli/slimux', --send selected code to other tmux window

  --yanking and commenting
  'vim-scripts/YankRing.vim',
  'ctrlpvim/ctrlP.vim',
  'scrooloose/nerdcommenter',  --determines prefix to comment depending on file type

  -- markdown dev
  'godlygeek/tabular',
  'plasticboy/vim-markdown',

  -- converting to filetypes
  'vim-pandoc/vim-pandoc',
  'vim-pandoc/vim-pandoc-syntax',

  {'iamcco/markdown-preview.nvim',
  ft = {'markdown', 'pandoc.markdown', 'rmd'},
  --cmd = { "MarkdownPreview", "MarkdownPreviewStop" },
	build= 'sh -c "cd app & yarn install"'
  },

  --Design and color schemes
  -- 'vim-airline/vim-airline',
  -- 'vim-airline/vim-airline-themes',
 {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    opts = {
      options = {
        icons_enabled = true,
        component_separators = '|',
        section_separators = '',
      },
    },
  },

  --color schemes
  'lifepillar/vim-solarized8',
  --'morhetz/gruvbox',
  'ellisonleao/gruvbox.nvim',
  {'navarasu/onedark.nvim', -- theme inspired by atom
    lazy = false,
    priority = 1000,  -- load before all otehrs
  },

  -- NOTE: This is where your plugins related to LSP can be installed.
  --  The configuration is done below. Search for lspconfig to find it below.
  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      -- manages LSP servers, DAP servers, linters, and formatters
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',

      -- eye candy...status updates widget for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', tag = 'legacy', opts = {} },

      -- lua LSP for configs and plugin...api func, autocompletions etc 
      'folke/neodev.nvim',
    },
  },

  { -- Autocompletion
  'hrsh7th/nvim-cmp',

  dependencies = {
  -- Snippet Engine & its associated nvim-cmp source
  'L3MON4D3/LuaSnip',
  'saadparwaiz1/cmp_luasnip',

  -- Adds LSP completion capabilities
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-cmdline',

  -- Adds a number of user-friendly snippets
  'rafamadriz/friendly-snippets',
  },
  },

  -- Useful plugin to show you pending keybinds.
  { 'folke/which-key.nvim', opts = {} },
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
        vim.keymap.set('n', '<leader>gp', require('gitsigns').prev_hunk, { buffer = bufnr, desc = '[G]o to [P]revious Hunk' })
        vim.keymap.set('n', '<leader>gn', require('gitsigns').next_hunk, { buffer = bufnr, desc = '[G]o to [N]ext Hunk' })
        vim.keymap.set('n', '<leader>ph', require('gitsigns').preview_hunk, { buffer = bufnr, desc = '[P]review [H]unk' })
      end,
    },
  },
  {
    -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help indent_blankline.txt`
    opts = {
      char = '┊',
      show_trailing_blankline_indent = false,
    },
  },

  -- "gc" to comment visual regions/lines
  --[[
     [{ 'numToStr/Comment.nvim', opts = {} },
     ]]

  -- Fuzzy Finder (files, lsp, etc)
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      -- Fuzzy Finder Algorithm which requires local dependencies to be built.
      -- Only load if `make` is available. Make sure you have the system
      -- requirements installed.
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
    },
  },

  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
  },

  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    You can use this folder to prevent any conflicts with this init.lua if you're interested in keeping
  --    up-to-date with whatever is in the kickstart repo.
  --    Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  --
  --    For additional information see: https://github.com/folke/lazy.nvim#-structuring-your-plugins
  -- { import = 'custom.plugins' },
}, {})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore)o.

local cmp = require'cmp'
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})


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

require('custom.options')  -- no need to specify the lua directory it will search within
require('custom.telescope')
require('custom.keymaps')
require('custom.lsp')
require('custom.completion')
-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
