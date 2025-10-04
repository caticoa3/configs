local function get_python_path()
  if (os.getenv("CONDA_PREFIX") ~= "root") and (os.getenv("CONDA_PREFIX") ~= nil) then  -- conda envirnment is enabled
    return os.getenv("CONDA_PREFIX") .. "/bin/python"
  elseif os.getenv("VIRTUAL_ENV") then  --another virtual environment is enabled (e.g. pipenv)
    return os.getenv("VIRTUAL_ENV") .. "/bin/python"
  end
  return nil
end

vim.g.python3_host_prog = get_python_path()
-- Show python location without requiring input
vim.schedule(function()
  vim.notify('Python location: ' .. (vim.g.python3_host_prog or 'not found'), vim.log.levels.INFO)
end)

-- get_venv() used to print in lualine_y for python files
local function get_venv(variable)
  local venv = os.getenv(variable)
  if venv ~= nil and string.find(venv, "/") then
    local orig_venv = venv
    venv = orig_venv:match("([^/]+)$")
    venv = string.format("%s", venv)
  end
  return venv
end

-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
--local stdpath = vim.fn.stdpath 'data'
--print(stdpath)
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
  -- Common plugins (both VS Code and Neovim)
  {
    -- Git plugins
    'tpope/vim-fugitive',
    'tpope/vim-rhubarb',

    {'preservim/nerdcommenter', event = 'VimEnter'},

    -- Motion and editing plugins

    {
      'echasnovski/mini.pairs',
      config = function()
        require('mini.pairs').setup({
          modes = { insert = true, command = false, terminal = false },
          mappings = {
            ['('] = { action = 'open', pair = '()', neigh_pattern = '.[^%w|^\\|^/]' },
            ['['] = { action = 'open', pair = '[]', neigh_pattern = '.[^%w|^\\|^/]' },
            ['{'] = { action = 'open', pair = '{}', neigh_pattern = '.[^%w|^\\|^/]' },
            ['"'] = { action = 'closeopen', pair = '""', neigh_pattern = '.[^%w|^\\|^/]', register = { cr = false } },
            ["'"] = { action = 'closeopen', pair = "''", neigh_pattern = '.[^%w|^\\|^/]', register = { cr = false } },
          }
        })
      end
    },
  },

  -- Neovim-only plugins
  {
    name = 'vscode-disabled-group',
    cond = not vim.g.vscode,

    'sindrets/diffview.nvim',  --git diff viewer

    'whiteinge/diffconflicts', -- simplifies the three-way merge view into a two-way view

    'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically

    -- markdown dev
    'godlygeek/tabular',
    'plasticboy/vim-markdown',

    -- Adds git related signs to the gutter, as well as utilities for managing changes
    --[['airblade/vim-gitgutter',]]
    {
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

    -- A pretty list for showing diagnostics, references, telescope results, quickfix and locations 
    {"folke/trouble.nvim",
      opts = {}, -- for default options, refer to the configuration section for custom setup.
      cmd = "Trouble",
    },

    -- Useful plugin to show you pending keybinds
    {
      'folke/which-key.nvim',
      opts = {
        icons = {
          breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
          separator = "➜", -- symbol used between a key and it's label
          group = "+", -- symbol prepended to a group
        }
      }
    },

    -- yanking with history
    {
      'gbprod/yanky.nvim',
      opts = {
        highlight = {
          on_put = false, -- disable to avoid conflict with our existing highlight
          on_yank = false, -- disable to avoid conflict with our existing highlight  
        },
      },
    },

    'glacambre/firenvim',
    --[['github/copilot.vim',]]
    'christoomey/vim-tmux-navigator',

    'esamattis/slimux', --copy paste across tmux panes

    -- File explorer
    {
      "nvim-neo-tree/neo-tree.nvim",
      lazy = false,
      branch = "v3.x",
      dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
      },
    },

    -- LSP and other plugins...
    {
      'neovim/nvim-lspconfig',
      dependencies = {
        -- Automatically install LSPs to stdpath for neovim
        -- manages LSP servers, DAP servers, linters, and formatters
        {'mason-org/mason.nvim',
          config = function()
            require("mason").setup()
          end
        },
        {'mason-org/mason-lspconfig.nvim',
          config = function()
            require("mason-lspconfig").setup({
              ensure_installed = {"pyright", "lua_ls", "ruff"},  -- install mypy and ruff through GUI
              automatic_enable = false,  -- enabled in lsp.lua
            })
          end
        },
        {
          "WhoIsSethDaniel/mason-tool-installer.nvim",
          opts = {
            ensure_installed = { "mypy" },
            auto_update = false,
            run_on_start = true,
          },
        },
        -- eye candy...status updates widget for LSP
        { 'j-hui/fidget.nvim',
          config = function()
            require('fidget').setup({})
          end,
        },

        -- lua LSP for configs and plugin...api func, autocompletions etc
        'folke/neodev.nvim',
      },
    },

    -- Autocompletion
    {
      'hrsh7th/nvim-cmp',
      dependencies = {
        'L3MON4D3/LuaSnip',              --snippet engine
        'saadparwaiz1/cmp_luasnip',      --snippet completions
        'hrsh7th/cmp-path',              --file path autocompletions
        'hrsh7th/cmp-nvim-lsp',          -- LSP completion capabilities
        'hrsh7th/cmp-cmdline',           --command line completions
        'rafamadriz/friendly-snippets',  -- Adds lots of user-friendly snippets
      },
      config = function()
        -- Initialize cmp with empty setup - detailed configuration is in lua/custom/completion.lua
        local cmp = require('cmp')
        cmp.setup {}  -- Empty setup, will be configured in completion.lua

        -- Setup cmdline completion (this specific setup is here to keep all cmp initialization together)
        cmp.setup.cmdline(':', {
          mapping = cmp.mapping.preset.cmdline(),
          sources = cmp.config.sources({
            { name = 'path' }
          }, {
            { name = 'cmdline' }
          })
        })
      end,
    },

    -- "stevearc/dressing.nvim",
    "echasnovski/mini.pick",
    {
      'nvim-telescope/telescope.nvim',
      branch = '0.1.x',
      dependencies = { 'nvim-lua/plenary.nvim' }
    },
    "ibhagwan/fzf-lua",
    "nvim-tree/nvim-web-devicons",

    {
      -- Markdown rendering support
      'MeanderingProgrammer/render-markdown.nvim',
      opts = {
        file_types = { "markdown" },
      },
      ft = { "markdown" },
    },

    -- Document formats and conversion
    'vim-pandoc/vim-pandoc',
    'vim-pandoc/vim-pandoc-syntax',

    -- GPT integration
    {"robitx/gp.nvim",
      config = function()
        require("gp").setup()
      end,
    },

    -- null-ls for additional formatting/linting
    {'nvimtools/none-ls.nvim',
      ft = {"python"},
      opts = function()
        return require('custom.none-ls')
      end
    },

    -- Highlight, edit, and navigate code
    {
      'nvim-treesitter/nvim-treesitter',
      dependencies = {
        'nvim-treesitter/nvim-treesitter-textobjects',
      },
      build = ':TSUpdate',
    },

    -- Add indentation guides even on blank lines
    {
      'lukas-reineke/indent-blankline.nvim',  -- Enable `lukas-reineke/indent-blankline.nvim`
      -- See `:help indent_blankline.txt`
      main = "ibl",
      opts = {
        enabled = true,
        indent = { char = "|" },
        --[[ char = '┊' ]]
        --[[ IBshow_trailing_blankline_indent = false, ]]
      },
    },

    -- Gives suggestions on alternate Vim usage
    {
      "m4xshen/hardtime.nvim",
      lazy = false,
      dependencies = { "MunifTanjim/nui.nvim" },
      opts = {},
    },

    {
      "coder/claudecode.nvim",
      dependencies = { "folke/snacks.nvim" },
      config = true,
    }
  },

  -- find things
  'mhinz/vim-grepper',

  -- markdown preview
  {'iamcco/markdown-preview.nvim',
    ft = {'markdown', 'pandoc.markdown', 'rmd'},
    build = 'sh -c "cd app & yarn install"'
  },

  -- Status line
  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    opts = {
      options = {
        icons_enabled = true,
        component_separators = '|',
        section_separators = '',
        ignore_focus = {'neo-tree'},
      },

      sections = {
        lualine_c = {{ "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 }}, 'filename'},
        lualine_x = {'encoding', 'fileformat'},
        lualine_y = {
          {
            function()
              local venv = get_venv("CONDA_PREFIX") or get_venv("VIRTUAL_ENV") or "NO ENV"
              --[[print(" " .. venv)]]
              return " " .. venv
            end,
            cond = function() return vim.bo.filetype == "python" end,
          },
          'progress'
        },
      },
    },
  },

  -- color schemes
  {
    "lifepillar/vim-solarized8",
    branch = "neovim",
  },
  'ellisonleao/gruvbox.nvim',
  {'navarasu/onedark.nvim', -- theme inspired by atom
    lazy = false,
    priority = 1000,  -- load before all others
  },

}, {})

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

-- [[ Auto-open Trouble diagnostics on file save ]]
--[[if not vim.g.vscode then
   [  vim.api.nvim_create_autocmd("BufWritePost", {
   [    callback = function()
   [      -- Only open Trouble if there are diagnostics
   [      local diagnostics = vim.diagnostic.get(0)
   [      if #diagnostics > 0 then
   [        require("trouble").open("diagnostics")
   [      end
   [    end,
   [    group = vim.api.nvim_create_augroup("TroubleOnSave", { clear = true }),
   [  })
   [end]]

require('custom.keymaps')
if vim.g.vscode then
  -- Load minimal config when in VS Code
  require('custom.options')
else
  -- Only load these configs when not in VS Code
  require('custom.options')
  require('custom.telescope')
  require('custom.lsp')
  require('custom.completion')
  require('custom.treesitter')
end

-- Keep these regardless of environment
vim.cmd('source ~/.vimrc')

-- Load dotfiles git integration
require('custom.dotfiles').setup()

--
-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et 
