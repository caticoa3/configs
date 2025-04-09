--For the option key work as the <A> key in vim keymaps, set the (left) option to Esc+ in iTerm profiles.
local opts = { noremap = true }

local term_opts = { silent = true }

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

local keymap = vim.keymap.set -- Shorten function name

-- Remap comma as Leader key
keymap("", ",", "<Nop>", opts)
vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- Common bindings (work in both VS Code and Neovim)
keymap("n", "<Leader>p", '"+p', opts) -- paste system clipboard

vim.schedule(function()
  vim.notify('Setting up kj escape binding', vim.log.levels.INFO)
end)

-- Press kj fast for ESC
keymap("i", "kj", "<ESC>", opts)
keymap("v", "kj", "<ESC>", opts)
keymap("x", "kj", "<ESC>", opts)
keymap("c", "kj", "<ESC>", opts)

-- Show vscode status without requiring input
vim.schedule(function()
  vim.notify('Loading keymaps.lua, vscode: ' .. tostring(vim.g.vscode), vim.log.levels.INFO)
end)

if vim.g.vscode then
    -- VS Code specific LSP-like features
    keymap('n', 'gd', function() vim.fn.VSCodeNotify('editor.action.revealDefinition') end)
    keymap('n', 'gr', function() vim.fn.VSCodeNotify('editor.action.goToReferences') end)
    keymap('n', 'K', function() vim.fn.VSCodeNotify('editor.action.showHover') end)
    
    -- VS Code window navigation
    keymap('n', '<C-h>', function() vim.fn.VSCodeNotify('workbench.action.navigateLeft') end)
    keymap('n', '<C-l>', function() vim.fn.VSCodeNotify('workbench.action.navigateRight') end)
    keymap('n', '<C-j>', function() vim.fn.VSCodeNotify('workbench.action.navigateDown') end)
    keymap('n', '<C-k>', function() vim.fn.VSCodeNotify('workbench.action.navigateUp') end)

    -- VS Code safe mappings
    keymap("n", "<Leader><Leader>s", ":set spell!<CR>", opts)
    keymap("n", "<Leader><Leader>p", ":set paste!<CR>", opts)
else
    -- Regular Neovim mappings
    -- Normal --
    -- Spelling
    vim.opt.spelllang = "en_us"
    keymap("n", "<Leader><Leader>s", ":set spell!<CR>", opts)
    keymap("n", "<Leader><Leader>p", ":set paste!<CR>", opts)

    -- find and replace
    keymap("n", "<Leader>r", ":%s///gc<left><left><left>", opts)
    keymap("n", "<Leader>rs", ":s///gc<left><left><left>", opts)

    -- Better window navigation
    keymap("n", "<C-h>", "<C-w>h", opts)
    keymap("n", "<C-j>", "<C-w>j", opts)
    keymap("n", "<C-k>", "<C-w>k", opts)
    keymap("n", "<C-l>", "<C-w>l", opts)
    keymap("n", "<tab><tab>", "<C-w>W", opts) --cycle through windows

    -- Resize windows when in normal mode
    keymap("n", "<A-k>", ":resize +2<CR>", opts)
    keymap("n", "<A-j>", ":resize -2<CR>", opts)
    keymap("n", "<A-h>", ":vertical resize -2<CR>", opts)
    keymap("n", "<A-l>", ":vertical resize +2<CR>", opts)

    -- Navigate buffers
    keymap("n", "<S-l>", ":bnext<CR>", opts)
    keymap("n", "<S-h>", ":bprevious<CR>", opts)

    -- Visual and Visual Block --
    -- Move text up and down
    keymap("v", "<A-k>", ":m .-2<CR>==", opts) -- move text up
    keymap("v", "<A-j>", ":m .+1<CR>==", opts) -- move text down
    keymap("x", "K",     ":move '<-2<CR>gv-gv", opts) -- move text up
    keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts) -- move text up 
    keymap("x", "J",     ":move '>+1<CR>gv-gv", opts) -- move text down
    keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts) -- move text down 
    
    -- Indentation
    keymap({"v", "x"}, "<A-h>", "<gv", opts)   -- remove indentation
    keymap({"v", "x"}, "<A-l>", ">gv", opts)   -- add indentation
    keymap("v", "<", "<gv", opts) -- remove indentation
    keymap("v", ">", ">gv", opts) -- add indentation

    -- Terminal --
    -- Better terminal navigation
    keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
    keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
    keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
    keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

    -- Diagnostic keymaps
    keymap('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
    keymap('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
    keymap('n', '<Leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
    keymap('n', '<Leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

    -- Plugin Dependent
    -- slimux
    --[[keymap('', "<Leader>s", ":SlimuxREPLSendLine<CR>", opts)
       [keymap({'v', 'x'}, "<Leader>s", "SlimuxREPLSendSelection<CR>", opts)
       [keymap('', "<Leader>a", ":SlimuxShellLast<CR>", opts)
       [keymap('', "<Leader>k", ":SlimuxSendKeysLast<CR>", opts)]]

    --NeoTree
    keymap('n', "<Leader>N", ":Neotree<CR>", opts)

    --yankring
    keymap('', "<Leader>yr", ":YRShow <CR>", opts)
    vim.g.yankring_replace_n_pkey = "<Leader>yp"

    --Gitgutter
    keymap("n", "<F3>", ":GitGutterBufferToggle<CR>", opts)

    -- Colorscheme switching
    keymap('n', '<Leader>bd1', ':colorscheme onedark<CR>', opts)
    keymap('n', '<Leader>bd', ':colorscheme solarized8<CR>', opts)
    keymap('n', '<Leader>bl', ':set background=light<CR>', opts)

    -- See `:help telescope.builtin`
    keymap('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
    keymap('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
    keymap('n', '<leader>/', function()
      -- You can pass additional configuration to telescope to change theme, layout, etc.
      require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end, { desc = '[/] Fuzzily search in current buffer' })

    keymap('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
    keymap('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
    keymap('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
    keymap('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
    keymap('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
    keymap('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })

    keymap('n', '<leader>xx', ":Trouble diagnostics toggle<CR>", {desc = "Diagnostics (Trouble)"})
    keymap('n', '<leader>xX', ":Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Buffer Diagnostics (Trouble)" })
    keymap('n', '<leader>st', ":Trouble symbols toggle focus=false<cr>", { desc = "Document Symbols (Trouble)"})
    --keymap('n', "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", { desc = "LSP Definitions / references / ... (Trouble)"})
    --[[keymap('n',  "<leader>xL", "<cmd>Trouble loclist toggle<cr>", { desc = "Location List (Trouble)" })]]
    keymap('n', "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", { desc = "Quickfix List (Trouble)" })

    -- [[ Basic Keymaps ]]
    --keymap({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
    -- Remap for dealing with word wrap
    --keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
    --keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

    -- Vim<->TMUX Navigation
    vim.cmd([[
      noremap <c-h> :<C-U>TmuxNavigateLeft<cr>
      noremap <c-j> :<C-U>TmuxNavigateDown<cr>
      noremap <c-k> :<C-U>TmuxNavigateUp<cr>
      noremap <c-l> :<C-U>TmuxNavigateRight<cr>
      noremap <c-\> :<C-U>TmuxNavigatePrevious<cr>
    ]])
end
