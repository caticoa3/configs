vim.opt.autochdir = true
vim.o.termguicolors = true             -- NOTE: You should make sure your terminal supports this

--plugin dependent settings
--vim.g.gitgutter_set_sign_backgrounds = 1

--NERDTreeIgnore WIP  
--vim.cmd.let("NERDTreeIgnore = ['\\.git$', '__pycache__$']")
--vim.g.NERDTreeIgnore = {'\\.git$', '__pycache__$'}

--Spacing between # and text when commenting lines with NERD commenter
vim.cmd('let g:NERDSpaceDelims=1')
vim.cmd('let g:NERDCompactSexyComs=1')

--vim-fugitive
--vim.cmd.set('diffopt=filler, vertical')

-- remove highlight on vertical line between panes and gitgutter SignColumn
vim.api.nvim_create_autocmd({"VimEnter", "ColorScheme"}, {
   command = "highlight clear VertSplit" })
vim.api.nvim_create_autocmd({"VimEnter", "ColorScheme"}, {
   command = "highlight clear SignColumn"})

--gitgutter color
--vim.g.gitgutter_set_sign_backgrounds = 1

--start up colorscheme
vim.cmd("let g:onedark_config = {'style' : 'warmer'}")
vim.cmd.colorscheme 'onedark'

--WIP
--vim.g.airline_powerline_fonts = 1
--vim.cmd('let g:airline#extensions#hunks#enabled = 0')
--vim.cmd('let g:airline#extensions#branch#enabled = 0')
--vim.g.airline_theme = 'powerlineish'

vim.o.hlsearch = true                 -- Set highlight on search
vim.wo.number = true                   -- Make line numbers default
vim.o.mouse = 'a'                      -- Enable mouse mode
vim.o.clipboard = 'unnamedplus'        -- Sync clipboard between OS and Neovim
vim.o.breakindent = true               -- Enable break indent
vim.o.undofile = true                  -- Save undo history
vim.o.ignorecase = true                -- Case-insensitive searching
--vim.o.smartcase = true                 -- " " UNLESS \C or capital in search
--vim.wo.signcolumn = 'yes'              -- Keep signcolumn on by default
vim.o.updatetime = 250                 -- Decrease update time
vim.o.timeoutlen = 300                 -- Decrease update time
vim.o.completeopt = 'menuone,noselect' -- completopt for a better completion experience


-- set background light or dark
-- vim.cmd [[
-- if strftime("%H") < 18 && strftime("%H") > 7
--    colorscheme solarized8
--    set background=light
-- else
--    colorscheme onedark
--    set background=dark
-- endif
-- ]]

--behave like NERDTree
--options: https://github.com/nvim-neo-tree/neo-tree.nvim/blob/aec592bb1f0cf67f7e1123053d1eb17700aa9ed4/lua/neo-tree/defaults.lua#L378-L382
require('neo-tree').setup({
   filesystem = { follow_current_file = {enabled = true},
                  bind_to_cwd = false},
   filtered_items = { hide_gitignored = false},
   hide_by_name = {".DS_Store", "thumbs.db"},
})
