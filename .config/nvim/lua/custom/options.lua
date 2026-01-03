vim.opt.autochdir = true
vim.o.termguicolors = true             -- NOTE: You should make sure your terminal supports this

-- Disable Perl provider since we don't use it
vim.g.loaded_perl_provider = 0

-- recommended for Avante: views can only be fully collapsed with the global statusline
vim.opt.laststatus = 3

--plugin dependent settings
--vim.g.gitgutter_set_sign_backgrounds = 1

--Spacing between # and text when commenting lines with NERD commenter
vim.cmd('let g:NERDSpaceDelims=0')
vim.cmd('let g:NERDCompactSexyComs=1')

--vim-fugitive
vim.o.diffopt = 'filler,vertical,hiddenoff'

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

-- Only configure neo-tree if we're not in Cursor/VS Code
if not vim.g.vscode then
  --behave like NERDTree
  --options: https://github.com/nvim-neo-tree/neo-tree.nvim/blob/aec592bb1f0cf67f7e1123053d1eb17700aa9ed4/lua/neo-tree/defaults.lua#L378-L382
  require('neo-tree').setup({
     filesystem = {
        follow_current_file = {enabled = true},
        bind_to_cwd = false,

        filtered_items = {
           visible = false, -- when true, they will just be displayed differently than normal items
           hide_dotfiles = true,
           hide_by_name = {
           },
           hide_by_pattern = { -- uses glob style patterns
             --"*.meta",
             --"*/src/*/tsconfig.json",
           },
           always_show = { -- remains visible even if other settings would normally hide it
            ".gitignored",
            --".gitkeep",
            ".gcloudignore"
           },
           never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
             ".DS_Store",
             "thumbs.db",
             ".mypy_cache"
           },
           never_show_by_pattern = { -- uses glob style patterns
             ".null-ls_*",
             "*__pycache__",
             "*.pytest_cache",
             "*.ipynb_checkpoints",
             "*.pptx",
             "*.egg-info"
           }
        }
     }
  })
end
