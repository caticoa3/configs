local function get_python_path()
  if (os.getenv("CONDA_PREFIX") ~= "root") and (os.getenv("CONDA_PREFIX") ~= nil) then  -- conda envirnment is enabled
    return os.getenv("CONDA_PREFIX") .. "/bin/python"
  elseif os.getenv("VIRTUAL_ENV") then  --another virtual environment is enabled (e.g. pipenv)
    return os.getenv("VIRTUAL_ENV") .. "/bin/python"
  end
  return nil
end

vim.g.python3_host_prog = get_python_path()
print('python location', vim.g.python3_host_prog)

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
  },

  -- Neovim-only plugins
  {
    name = 'vscode-disabled-group',
    cond = not vim.g.vscode,
    
    -- simplifies the three-way merge view into a two-way view
    'whiteinge/diffconflicts',
    
    -- Detect tabstop and shiftwidth automatically
    'tpope/vim-sleuth',
    
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
    'folke/which-key.nvim',
    
    -- yanking with history
    'vim-scripts/YankRing.vim',
    
    'glacambre/firenvim',
    --[['github/copilot.vim',]]
    'easymotion/vim-easymotion',
    'christoomey/vim-tmux-navigator',
    
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
        {'williamboman/mason.nvim', config = true,
          opts = {
            ensure_installed = {
              'black',
              --[['mypy',]]
              'ruff',
              --[['pyrite']]
            }
          }
        },
        'williamboman/mason-lspconfig.nvim',

        -- eye candy...status updates widget for LSP
        -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
        { 'j-hui/fidget.nvim', tag = 'legacy', opts = {} },

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

    -- Avante and its dependencies
    {
      "yetone/avante.nvim",
      event = "VeryLazy",
      lazy = false,
      version = false,
      opts = {
        -- add any opts here
        -- for example
        provider = "openai",
        openai = {
          endpoint = "https://api.openai.com/v1",
          model = "gpt-4o", -- your desired model (or use gpt-4o, etc.)
          timeout = 30000, -- timeout in milliseconds
          temperature = 0, -- adjust if needed
          max_tokens = 4096,
        },
        debug = true,
      },
      -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
      build = "make",
      -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
      dependencies = {
        "stevearc/dressing.nvim",
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        --- The below dependencies are optional,
        "echasnovski/mini.pick", -- for file_selector provider mini.pick
        "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
        "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
        "ibhagwan/fzf-lua", -- for file_selector provider fzf
        "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
        "zbirenbaum/copilot.lua", -- for providers='copilot'
        {
          -- support for image pasting
          "HakonHarnes/img-clip.nvim",
          event = "VeryLazy",
          opts = {
            -- recommended settings
            default = {
              embed_image_as_base64 = false,
              prompt_for_file_name = false,
              drag_and_drop = {
                insert_mode = true,
              },
              -- required for Windows users
              use_absolute_path = true,
            },
          },
        },
        {
          -- Make sure to set this up properly if you have lazy=true
          'MeanderingProgrammer/render-markdown.nvim',
          opts = {
            file_types = { "markdown", "Avante" },
          },
          ft = { "markdown", "Avante" },
        },
      },
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
  },

  -- Luarocks package manager
  {
    "vhyrro/luarocks.nvim",
    priority = 1000, -- Very high priority is required, luarocks.nvim should run as the first plugin in your config.
    config = true,
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
              --[[print(" " .. venv)]]
            return " " .. venv
            end,
            cond = function() return vim.bo.filetype == "python" end,
          },
          'progress'
        },
      },
    },
  },

  -- color schemes
  'lifepillar/vim-solarized8',
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
--
-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
