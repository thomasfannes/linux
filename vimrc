if has('python3')
endif

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
function! BuildYCM(info)
  " info is a dictionary with 3 fields
  " - name:   name of the plugin
  " - status: 'installed', 'updated', or 'unchanged'
  " - force:  set on PlugInstall! or PlugUpdate!
  if a:info.status == 'installed' || a:info.force
    !./install.py --system-libclang --clang-completer
  endif
endfunction


call plug#begin('~/.vim/plugged')


Plug 'flazz/vim-colorschemes'
Plug 'jiangmiao/auto-pairs'
Plug 'oblitum/YouCompleteMe', { 'do': function('BuildYCM') }
    let g:ycm_always_populate_location_list = 1
    let g:ycm_autoclose_preview_window_after_insertion = 1
    "let g:ycm_goto_buffer_command = 'horizontal-split'
    let g:ycm_complete_in_comments = 1
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
Plug 'tpope/vim-unimpaired'
Plug 'scrooloose/nerdtree'
    " set the width of the nerdtree window bigger, default is 31
    let g:NERDTreeWinSize=50
    let g:NERDTreeDirArrows=0
    let g:NERDTreeQuitOnOpen=1
Plug 'vim-airline/vim-airline'
    let g:airline_theme='dark'
    let g:airline#extensions#default#section_truncate_width = {
          \ 'a': 80,
          \ 'b': 100,
          \ 'x': 90,
          \ 'y': 88,
          \ 'z': 80,
          \ 'warning': 120,
          \ 'error': 120,
          \ }
    let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]'
Plug 'Frydac/vim-tree'
Plug 'Frydac/vim-auro'
Plug 'mileszs/ack.vim'
    " use ag in stead of ack
    let g:ackprg = 'ag --vimgrep --smart-case'
Plug 'SirVer/ultisnips'
    " Trigger configuration. Do not use <tab> if you use
    " https://github.com/Valloric/YouCompleteMe.
    let g:UltiSnipsExpandTrigger="<c-j>"
    let g:UltiSnipsJumpForwardTrigger="<c-j>"
    let g:UltiSnipsJumpBackwardTrigger="<c-h>"
    let g:ycm_collect_identifiers_from_tags_files = 1
    " If you want :UltiSnipsEdit to split your window.
    let g:UltiSnipsEditSplit="vertical"
    " Where should UltiSnipsEdit put its files, by default it just went into the
    " home directory, rather in the vim folder
    if has('win32')
        let g:UltiSnipsSnippetsDir='~/vimfiles/plugged/vim-auro/UltiSnips'
    else
        let g:UltiSnipsSnippetsDir='~/.vim/plugged/vim-auro/UltiSnips'
    endif
Plug 'dkprice/vim-easygrep'
    let g:EasyGrepMode='TrackExt'
    let g:EasyGrepJumpToMatch=0
    let g:EasyGrepRecursive=1
    let g:EasyGrepCommand=1
    let g:EasyGrepSearchCurrentBufferDir=0
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
    if has('win32')
        let g:fzf_history_dir = '$HOME/.fzf_vim_history'
    else
        let g:fzf_directories = '~/.fzf_vim_history'
    endif
    let g:fzf_layout = { 'down': '~95%' }
    " Some default colors didn't render well on solarized, they where
    " difficult to read. The other colors I liked. So adjusted some of them:
    let g:fzf_colors = {
      \ 'info':    ['fg', 'PreProc'],
      \ 'prompt':  ['fg', 'Conditional'],
      \ 'spinner': ['fg', 'Label']
      \ }
    " Use ripgrep to list searches
    command! -bang -nargs=* Rg
      \ call fzf#vim#grep(
      \   'rg --column --line-number --hidden --no-heading --color=always '.shellescape(<q-args>), 1,
      \   <bang>0 ? fzf#vim#with_preview('up:60%')
      \           : fzf#vim#with_preview('right:50%:hidden', '?'),
      \   <bang>0)
    " Files command with preview window
    command! -bang -nargs=? -complete=dir Files
      \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)
    " History command with preview window
    command! -bang -nargs=* MRU call fzf#vim#history(fzf#vim#with_preview())
    Plug 'terryma/vim-multiple-cursors'
call plug#end()
" URL: http://vim.wikia.com/wiki/Example_vimrc
" Authors: http://vim.wikia.com/wiki/Vim_on_Freenode
" Description: A minimal, but feature rich, example .vimrc. If you are a
"              newbie, basing your first .vimrc on this file is a good choice.
"              If you're a more advanced user, building your own .vimrc based
"              on this file is still a good idea.
 
"------------------------------------------------------------
" Features {{{1
"
" These options and commands enable some very useful features in Vim, that
" no user should have to live without.
 
" Set 'nocompatible' to ward off unexpected things that your distro might
" have made, as well as sanely reset options when re-sourcing .vimrc
set nocompatible
 
" Attempt to determine the type of a file based on its name and possibly its
" contents. Use this to allow intelligent auto-indenting for each filetype,
" and for plugins that are filetype specific.
filetype indent plugin on
 
" Enable syntax highlighting
syntax on
 
 
"------------------------------------------------------------
" Must have options {{{1
"
" These are highly recommended options.
 
" Vim with default settings does not allow easy switching between multiple files
" in the same editor window. Users can use multiple split windows or multiple
" tab pages to edit multiple files, but it is still best to enable an option to
" allow easier switching between files.
"
" One such option is the 'hidden' option, which allows you to re-use the same
" window and switch from an unsaved buffer without saving it first. Also allows
" you to keep an undo history for multiple files when re-using the same window
" in this way. Note that using persistent undo also lets you undo in multiple
" files even in the same window, but is less efficient and is actually designed
" for keeping undo history after closing Vim entirely. Vim will complain if you
" try to quit without saving, and swap files will keep you safe if your computer
" crashes.
set hidden
 
" Note that not everyone likes working this way (with the hidden option).
" Alternatives include using tabs or split windows instead of re-using the same
" window as mentioned above, and/or either of the following options:
" set confirm
" set autowriteall
 
" Better command-line completion
set wildmenu
 
" Show partial commands in the last line of the screen
set showcmd
 
" Highlight searches (use <C-L> to temporarily turn off highlighting; see the
" mapping of <C-L> below)
set hlsearch
 
" Modelines have historically been a source of security vulnerabilities. As
" such, it may be a good idea to disable them and use the securemodelines
" script, <http://www.vim.org/scripts/script.php?script_id=1876>.
" set nomodeline
 
 
"------------------------------------------------------------
" Usability options {{{1
"
" These are options that users frequently set in their .vimrc. Some of them
" change Vim's behaviour in ways which deviate from the true Vi way, but
" which are considered to add usability. Which, if any, of these options to
" use is very much a personal preference, but they are harmless.
 
" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase
 
" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start
 
" When opening a new line and no filetype-specific indenting is enabled, keep
" the same indent as the line you're currently on. Useful for READMEs, etc.
set autoindent
 
" Stop certain movements from always going to the first character of a line.
" While this behaviour deviates from that of Vi, it does what most users
" coming from other editors would expect.
set nostartofline
 
" Display the cursor position on the last line of the screen or in the status
" line of a window
set ruler
 
" Always display the status line, even if only one window is displayed
set laststatus=2
 
" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm
 
" Use visual bell instead of beeping when doing something wrong
set visualbell
 
" And reset the terminal code for the visual bell. If visualbell is set, and
" this line is also included, vim will neither flash nor beep. If visualbell
" is unset, this does nothing.
set t_vb=
 
" Enable use of the mouse for all modes
set mouse=a
 
" Set the command window height to 2 lines, to avoid many cases of having to
" "press <Enter> to continue"
set cmdheight=2
 
" Display line numbers on the left
set number
 
" Quickly time out on keycodes, but never time out on mappings
set notimeout ttimeout ttimeoutlen=200
 
" Use <F11> to toggle between 'paste' and 'nopaste'
set pastetoggle=<F11>
 
 
"------------------------------------------------------------
" Indentation options {{{1
"
" Indentation settings according to personal preference.
 
" Indentation settings for using 4 spaces instead of tabs.
" Do not change 'tabstop' from its default value of 8 with this setup.
set shiftwidth=4
set softtabstop=4
set expandtab
 
" Indentation settings for using hard tabs for indent. Display tabs as
" four characters wide.
"set shiftwidth=4
"set tabstop=4
 
 
"------------------------------------------------------------
" Mappings {{{1
"
" Useful mappings
 
" Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy,
" which is the default
map Y y$
 
" Map <C-L> (redraw screen) to also turn off search highlighting until the
" next search
nnoremap <C-L> :nohl<CR><C-L>
vnoremap // y/<C-R>"<CR>
let mapleader=' '
au FocusLost * silent! wa
set autowriteall
nnoremap <leader>tt   :NERDTreeToggle<CR>
" find current file in nerdtree
nnoremap <leader>tf   :NERDTreeFind<CR>
nnoremap <C-CR> :YcmCompleter GoTo<CR>
nnoremap <leader>yg   :YcmCompleter GoTo<CR>
nnoremap <leader>yt   :YcmCompleter GetType<CR>
nnoremap <leader>yf   :YcmCompleter FixIt<CR>
nnoremap <leader>ev   :tabnew $MYVIMRC<CR>
" clang-format
let g:clang_format_fallback_style='WebKit'
noremap <C-K> :pyf /usr/share/clang/clang-format.py<cr>
inoremap <C-K> <c-o>:pyf /usr/share/clang/clang-format.py<cr>
"FZF
" https              : //github.com/junegunn/fzf.vim#commands
nnoremap <leader>fb  :Buffers<CR>
nnoremap <leader>b   :Buffers<CR>
nnoremap <leader>ff  :Files<CR>
nnoremap <leader>fgf :GFiles<CR>
nnoremap <leader>fag :Ag<CR>
nnoremap <leader>fl  :Lines<CR>
nnoremap <leader>fh  :History<CR>
nnoremap <leader>;   :History<CR>
nnoremap <leader>fs  :Snippets<CR>
nnoremap <leader>fco :Commits<CR>
nnoremap <leader>fcb :BCommits<CR>
nnoremap <leader>fw  :Windows<CR>
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>
