
" set t_Co=256
set nocompatible

" set background light or dark
if strftime("%H") < 18 && strftime("%H") > 7
   colorscheme solarized8
   set background=light
else
   colorscheme onedark
   set background=dark
endif

"remove verticle split highlight
" autocmd! VimEnter,ColorScheme * hi VertSplit ctermbg=none

" --------
" How to Do 90% of What Plugins Do (With Just Vim)
" https://github.com/changemewtf/no_plugins
" FINDING FILES:
" Search down into subfolders
" Provides tab-completion for all file-related tasks
set path+=**

" Display all matching files when we tab complete
"set wildmenu

" NOW WE CAN:
" - Hit tab to :find by partial match
" - Use * to make it fuzzy
" ---------

if v:version >= 400
  function! RelativeNumberToggle()
    if (&number == 1 && &relativenumber == 1)
      set number
      set norelativenumber
    elseif (&number == 0 && &relativenumber == 1)
      set norelativenumber
      set number number?
    elseif (&number == 1 && &relativenumber == 0)
      set norelativenumber
      set nonumber number?
    else
      set number
      set relativenumber relativenumber?
    endif
  endfunc
else
  function! RelativeNumberToggle()
    if (&relativenumber == 1)
      set number number?
    elseif (&number == 1)
      set nonumber number?
    else
      set relativenumber relativenumber?
    endif
  endfunc
  nnoremap <silent> <space> :set number!<CR>
endif
nnoremap <silent> <space> :call RelativeNumberToggle()<CR>

au FocusLost * :set number
au FocusGained * :set relativenumber
autocmd InsertEnter * :set number
autocmd InsertLeave * :set relativenumber

"nnoremap <silent> <f3> :redir @a<cr>:g//<CR>:redir END<CR>:new<CR>:put! a<CR>

"" -- iamcco/makrkdown-preview.nvim configs
"nnoremap <m-m> :markdownpreview<cr>
"let g:mkdp_refresh_slow=1
"let g:mkdp_markdown_css='$home/.config/nvim/github-markdown.css'

" -- remove trailing white space except from comments
function! Preserve(command)
  " preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " do the business:
  execute a:command
  " clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction
" use Preserve() search with regex for white space of lines that do not
" being with # passing the command :%s/\(#.\+\)\@<!\s\+$//e as a string needs more esapes
" remove trailing but not from markdown in jupytext to keep new lines (double space) 
nmap <leader># :call Preserve("%s/\\(#.\\+\\)\\@<!\\s\\+$//e")<cr>
" remove all trailing white space
nmap <leader>$ :call Preserve("%s/\\s\\+$//e")<cr>

" text wraping
autocmd VimEnter * :set wrap " would not work without autocmd
set wrapmargin=2

"command difforig vert new | set buftype=nofile | read ++edit # | 0d_
"			\| diffthis | wincmd p | diffthis
"
"
" tmux navigator wip 
" let g:tmux_navigator_save_on_switch = 1  " saves current buffer when switching to tmux pane
