" test
set nocompatible               " Be iMproved
mapclear
"let g:python_host_prog ='/Users/carlos/anaconda3/envs/python2/bin/python'
let g:python3_host_prog="/Users/carlos/anaconda3/bin/python3"

let mapleader = ","
vnoremap kj <Esc>gV
onoremap kj <Esc>
cnoremap kj <C-C><Esc>
inoremap kj <Esc>

nnoremap <tab><tab> <c-w>w
set t_Co=256
set autochdir

" quick repeat, qq to start
nnoremap <leader>. @q

" toggle spell
set spell spelllang=en_us
" hi SpellBad cterm=underline ctermfg=black ctermbg=219
nnoremap <leader><leader>s :set spell!<CR>
nnoremap <leader><leader>p :set paste!<CR>
nnoremap <leader>p "+p
" start with no spell
set nospell

" set background light or dark
if strftime("%H") < 17 && strftime("%H") > 6
   set background=light
else
   set background=dark
endif

"set termguicolors

"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')

  " Let dein manage dein
  " Required:
  call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')
  call dein#add('vim-airline/vim-airline')
  call dein#add('vim-airline/vim-airline-themes')
  call dein#add('altercation/vim-colors-solarized')

  " -- use vim with the libraries in a conda evn
  "call dein#add('cjrh/vim-conda')

  " -- python dev
  call dein#add('python-mode/python-mode')
  call dein#add('davidhalter/jedi-vim')
  call dein#add('Konfekt/FastFold')
  call dein#add('tpope/vim-fugitive')
  call dein#add('airblade/vim-gitgutter')
  call dein#add('scrooloose/nerdtree')
  call dein#add('easymotion/vim-easymotion')

  call dein#add('christoomey/vim-tmux-navigator')
  call dein#add('epeli/slimux')

  call dein#add('vim-scripts/YankRing.vim')
  call dein#add('ctrlpvim/ctrlP.vim')
  "call dein#add('SirVer/ultisnips')
  "call dein#add('honza/vim-snippets')
  call dein#add('scrooloose/nerdcommenter')

  "call dein#add('vimwiki/vimwiki')
  "call dein#add('jcc-ne/taskwiki')
  "call dein#add('farseer90718/vim-taskwarrior')
  call dein#add('majutsushi/tagbar')

  "call dein#add('chrisbra/Recover.vim')
  "
  call dein#add('deoplete-plugins/deoplete-jedi') " async jedi
  call dein#add('Shougo/deoplete.nvim')

  " -- json highlighting
  call dein#add('elzr/vim-json')
  
  " -- markdown dev
  call dein#add('godlygeek/tabular')
  call dein#add('plasticboy/vim-markdown')

  call dein#add('vim-pandoc/vim-pandoc-syntax')
  call dein#add('iamcco/markdown-preview.nvim', {'on_ft': ['markdown', 'pandoc.markdown', 'rmd'],
					\ 'build': 'sh -c "cd app & yarn install"' })



  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

colorscheme solarized

" If you want to install not installed plugins on startup.
"if dein#check_install()
"  call dein#install()
"endif

"End dein Scripts-------------------------

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
"

let g:airline_powerline_fonts = 1
let g:airline#extensions#hunks#enabled = 0
let g:airline#extensions#branch#enabled = 0
let g:airline_theme = 'powerlineish'
" Spacing between # and text when commenting lines with NERD commenter
" let NERDSpaceDelims=1

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

" -- fastfold
"  prevents pymode folding from being very slow, works with version d2dead6
"  cd ~/.vim/bundle/python-mode/
"  git checkout d2dead6     (git checkout tags/snappy)

nmap zuz <Plug>(FastFoldUpdate)
let g:fastfold_savehook = 1
let g:fastfold_force = 1
" let g:fastfold_fold_command_suffixes =  ['x','X','a','A','o','O','c','C']
" let g:fastfold_fold_movement_commands = [']z', '[z', 'zj', 'zk']
" -- to be faster, set the fastfold update commands to blank
let g:fastfold_fold_command_suffixes =  []  
let g:fastfold_fold_movement_commands = []


" ====  set pymode ====
"filetype off
filetype plugin indent on
syntax on

" FileType python set omnifunc=pythoncomplete#Complete
"let g:SuperTabDefaultCompletionType = "context"

let g:pymode_python = 'python3'
let g:pymode_folding = 1

" Load rope plugin
let g:pymode_rope = 0

" Documentation
let g:pymode_doc = 1
let g:pymode_doc_key = 'K'

" Map keys for autocompletion
"let g:pymode_rope_autocomplete_map = '<C-K>'

let g:pymode_run = 1

" Key for run python code
let g:pymode_run_key = 'R'

"Linting
let g:pymode_lint = 1
"flake8 is a wrapper around of pep8, mccabe and pyflakes: https://pypi.org/project/flake8/
let g:pymode_lint_checker = "pep8, mccabe, pyflakes"
" Auto check on save
let g:pymode_lint_write = 1

" syntax highlighting
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all

"-----------------set jedi-------------------

let g:jedi#goto_assignments_command = "<leader>g"
let g:jedi#goto_definitions_command = "<leader>d"
let g:jedi#documentation_command = "K"
let g:jedi#usages_command = "<leader>n"
let g:jedi#completions_command = "<C-Space>"
let g:jedi#rename_command = "<leader>r"
let g:jedi#show_call_signatures = "1"
" let g:jedi#force_py_version = 3 " (default: 'auto')
" let g:jedi#popup_select_first = 0 " (default: 1)
let g:jedi#popup_on_dot = 0 " (default: 1)
let g:jedi#completions_enabled = 0  " use deoplete-jedi instead
let g:jedi#use_tabs_not_buffers = 1

" -- deoplete setup
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#jedi#ignore_errors = v:true
nnoremap <leader>D :call deoplete#disable()<CR>
nnoremap <leader>E :call deoplete#enable()<CR>

" ------- snippet -------------
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsSnippetsDir="~/.vim/bundle/myBundle/UltiSnips"
" let g:UltiSnipsSnippetsDirectories=["~/.vim/bundle/myBundle/UltiSnips"]
let g:UltiSnipsListSnippets="<c-tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" -- slimux setup
map <Leader>s :SlimuxREPLSendLine<CR>
vmap <Leader>s :SlimuxREPLSendSelection<CR>
map <Leader>a :SlimuxShellLast<CR>
map <Leader>k :SlimuxSendKeysLast<CR>

" -  yankring 
map <Leader><space> :YRShow <CR>
let g:yankring_replace_n_pkey="<leader> p"

" - map ctrl-p back to ctrl-p
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlPMixed'
"let g:ctrlp_cmd = 'CtrlPBuffer'
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git\|(\.(swp|ico|git|svn|pyc))'

autocmd FileType wiki,vimwiki set expandtab
autocmd FileType wiki,vimwiki set tabstop=3
nnoremap <leader>wa :VimwikiAll2HTML<CR>

" --- vim-fugitive
set diffopt=filler,vertical

" --- configurations for working with vim-conda plugin
"let g:jedi#force_py_version = 3
"let g:UltisnipsUsePythonVersion = 3
"let g:conda_startup_msg_suppress = 0

" --- vimwiki
let g:vimwiki_list = [
            \{'path': '~/vimwiki/text/datum',
            \ 'path_html': '~/vimwiki/html/datum',
            \'syntax': 'markdown',
            \'ext': '.md',
            \ 'auto_toc': 1,
            \ 'index': 'index',
            \ 'template_path': '~/vimwiki/templates/',
            \ 'template_default': 'def_template',
            \ 'template_ext': '.html'},
            \{'path': '~/vimwiki/text/fin',
            \ 'path_html': '~/vimwiki/html/fin',
            \'syntax': 'default',
            \'ext': '.md',
            \ 'auto_toc': 1,
            \ 'index': 'index',
            \ 'template_path': '~/vimwiki/templates/',
            \ 'template_default': 'def_template',
            \ 'template_ext': '.html'},
            \{'path': '~/vimwiki/text/general',
            \ 'path_html': '~/vimwiki/html/general',
            \'syntax': 'default',
            \'ext': '.wiki',
            \ 'auto_toc': 1,
            \ 'index': 'index',
            \ 'template_path': '~/vimwiki/templates/',
            \ 'template_default': 'def_template',
            \ 'template_ext': '.html'},
            \{'path': '~/vimwiki/text/tech',
            \ 'ext': '.wiki',
            \ 'path_html': '~/vimwiki/html/tech',
            \ 'auto_toc': 1,
            \ 'template_path': '~/vimwiki/templates/',
            \ 'template_default': 'def_template',
            \ 'template_ext': '.html'}
            \]

nnoremap <silent> <F3> :redir @a<CR>:g//<CR>:redir END<CR>:new<CR>:put! a<CR>

" -- iamcco/makrkdown-preview.nvim configs
nnoremap <M-m> :MarkdownPreview<CR>
let g:mkdp_refresh_slow=1
let g:mkdp_markdown_css='$HOME/.config/nvim/github-markdown.css'
