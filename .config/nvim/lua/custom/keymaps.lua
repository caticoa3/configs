local opts = { noremap = true }

local term_opts = { silent = true }

local keymap = vim.keymap.set -- Shorten function name
--Remap comma as Leader key
keymap("", ",", "<Nop>", opts)
vim.g.mapleader = ","
vim.g.maplocalleader = ","

keymap("n", "<Leader>p", '"+p', opts) -- paste system clipboard

--[[
   [keymap("n", "<Leader>.", "@q", opts) --repeat actions stored in q 
   ]]

-- switching colorscheme
keymap("n", "<Leader>bl", ":set background=light<CR> :colorscheme solarized8<CR>", opts)

keymap("n", "<Leader>bd", ":set background=dark<CR> :colorscheme gruvbox<CR>", opts)

keymap("n", "<Leader>bd1", ":set background=dark<CR> :let g:onedark_config = {'style': 'warmer'}<CR> :colorscheme onedark<CR>", opts)


-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Press kj fast for ESC
keymap("i", "kj", "<ESC>", opts)
keymap("v", "kj", "<ESC>", opts)
keymap("x", "kj", "<ESC>", opts)
keymap("c", "kj", "<ESC>", opts)

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
keymap("n", "<tab><tab>", "<C-w>W", opts) --cycle througwindows

--keymap("n", "<Leader>e", ":Lex 30<cr>", opts)  --basic nav tree

-- Resize windows when in normal mode
keymap("n", "<A-k>", ":resize +2<CR>", opts)
keymap("n", "<A-j>", ":resize -2<CR>", opts)
keymap("n", "<A-h>", ":vertical resize -2<CR>", opts)
keymap("n", "<A-l>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)


-- Visual and Visual Block -- 
keymap("v", "<A-k>", ":m .-2<CR>==", opts) -- move text up
keymap("v", "<A-j>", ":m .+1<CR>==", opts) -- move text down
keymap({"v", "x"}, "<A-h>", "<gv", opts)   -- remove indentation
keymap({"v", "x"}, "<A-l>", ">gv", opts)   -- add indentation
-- Move text left and right (additional mappings)
keymap("v", "<", "<gv", opts) --remove indentation
keymap("v", ">", ">gv", opts) -- add indentation

-- Visual Block -- Move text up and down 
keymap("x", "K",     ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)
keymap("x", "J",     ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)

--keymap("v", "p", '"_dP', opts)  --yank and paste combined 

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
keymap('', "<Leader>s", ":SlimuxREPLSendLine<CR>", opts)
keymap({'v', 'x'}, "<Leader>s", "SlimuxREPLSendSelection<CR>", opts)
keymap('', "<Leader>a", ":SlimuxShellLast<CR>", opts)
keymap('', "<Leader>k", ":SlimuxSendKeysLast<CR>", opts)

-- NERDTree
keymap('', "<Leader>N", ":NERDTree<CR>", opts)

--yankring
keymap('', "<Leader>yr", ":YRShow <CR>", opts)
vim.g.yankring_replace_n_pkey = "<Leader>yp"

--Gitgutter
keymap("n", "<F3>", ":GitGutterBufferToggle<CR>", opts)

-- [[ Basic Keymaps ]]
--keymap({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
-- Remap for dealing with word wrap
--keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
--keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
