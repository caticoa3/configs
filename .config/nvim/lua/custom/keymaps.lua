local opts = { noremap = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- pasting
keymap("n", "<leader>p", '"+p', opts)

-- quick repeat, qq to start
keymap("n", "<leader>.", "@q", opts) --repeat action n time

-- switching colorscheme
keymap("n", "<leader>bl", ":set background=light<CR> :colorscheme solarized8<CR>", opts)

keymap("n", "<leader>bd", ":colorscheme gruvbox<CR> :set background=dark<CR>", opts)

keymap("n", "<leader>b1d", ":let g:onedark_config = {'style': 'warm'}<CR> :colorscheme onedark<CR>", opts)


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
keymap("n", "<leader><leader>s", ":set spell!<CR>", opts)
keymap("n", "<leader><leader>p", ":set paste!<CR>", opts)



-- find and replace
keymap("n", "<leader>r", ":%s///gc<left><left><left>", opts)
keymap("n", "<leader>rs", ":s///gc<left><left><left>", opts)

-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)
keymap("n", "<tab><tab>", "<C-w>W", opts) --cycle througwindows

keymap("n", "<leader>e", ":Lex 30<cr>", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)


-- Visual --
-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
-- Move text left and right (double mappings)
keymap("v", "<", "<gv", opts) --remove indentation
keymap("v", ">", ">gv", opts) -- add indentation
keymap("v", "<A-h>", "<gv", opts) --remove indentation
keymap("v", "<A-l>", ">gv", opts) -- add indentation

keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down 
keymap("x", "K",     ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)
keymap("x", "J",     ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
-- Move text left and right
keymap("x", "<A-h>", "<gv", opts)
keymap("x", "<A-l>", ">gv", opts)

-- Terminal --
-- Better terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

-- Plugin Dependent
-- slimux 
keymap('', "<Leader>s", ":SlimuxREPLSendLine<CR>", opts)
keymap('v', "<Leader>s", "SlimuxREPLSendSelection<CR>", opts)
keymap('x', "<Leader>s", "SlimuxREPLSendSelection<CR>", opts)
keymap('', "<Leader>a", ":SlimuxShellLast<CR>", opts)
keymap('', "<Leader>k", ":SlimuxSendKeysLast<CR>", opts)

-- NERDTree
keymap('', "<Leader>N", ":NERDTree<CR>", opts)

--yankring
keymap('', "<Leader><space>", ":YRShow <CR>", opts)
vim.g.yankring_replace_n_pkey = "<leader> p"

--Gitgutter
keymap("n", "<F3>", "GitGutterBufferToggle<CR>", opts)
