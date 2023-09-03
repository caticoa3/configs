vim.opt.autochdir = true
--vim.opt.termguicolors = true
--
--plugin dependent settings
vim.g.gitgutter_set_sign_backgrounds = 1

--VimGrepper config (commented out because it breaks with these configs)
--vim.g.grepper = {}
--vim.g.grepper.dir = 'repo'

--NERDTreeIgnore WIP
--vim.cmd.let("NERDTreeIgnore = ['\\.git$', '__pycache__$']")
--vim.g.NERDTreeIgnore = {'\\.git$', '__pycache__$'}

--vim-fugitive
--[[
   [vim.cmd.set('diffopt=filler, vertical')
   ]]

-- remove highlight on vertical line between panes and gitgutter SignColumn
vim.api.nvim_create_autocmd({"VimEnter", "ColorScheme"}, {
   command = "highlight clear VertSplit" })
vim.api.nvim_create_autocmd({"VimEnter", "ColorScheme"}, {
   command = "highlight clear SignColumn"})

--gitgutter color
vim.g.gitgutter_set_sign_backgrounds = 1

--start up colorscheme
vim.cmd("let g:onedark_config = {'style' : 'warmer'}")
vim.cmd.colorscheme 'onedark'

vim.o.hlsearch = false                 -- Set highlight on search
vim.wo.number = true                   -- Make line numbers default
vim.o.mouse = 'a'                      -- Enable mouse mode
vim.o.clipboard = 'unnamedplus'        -- Sync clipboard between OS and Neovim
vim.o.breakindent = true               -- Enable break indent
vim.o.undofile = true                  -- Save undo history
vim.o.ignorecase = true                -- Case-insensitive searching
--vim.o.smartcase = true                 -- " " UNLESS \C or capital in search
vim.wo.signcolumn = 'yes'              -- Keep signcolumn on by default
vim.o.updatetime = 250                 -- Decrease update time
vim.o.timeoutlen = 300                 -- Decrease update time
vim.o.completeopt = 'menuone,noselect' -- completopt for a better completion experience
vim.o.termguicolors = true             -- NOTE: You should make sure your terminal supports this
