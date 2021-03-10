let mapleader =","

if ! filereadable(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim"'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim
	autocmd VimEnter * PlugInstall
endif

call plug#begin(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/plugged"'))
Plug 'bling/vim-airline'
Plug 'dense-analysis/ale'
Plug 'jeetsukumaran/vim-pythonsense'
Plug 'jiangmiao/auto-pairs'
Plug 'joshdick/onedark.vim'
Plug 'jreybert/vimagit'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/seoul256.vim'
Plug 'liuchengxu/vista.vim'
Plug 'neoclide/coc.nvim'
Plug 'NLKNguyen/papercolor-theme'
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
Plug 'preservim/nerdtree'
Plug 'sainnhe/sonokai'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'Vimjas/vim-python-pep8-indent'
call plug#end()

" As configurações numeradas abaixo são emprestadas do Luke:

" 01. Some basics:
	nnoremap c "_c
	set nocompatible
	filetype plugin on
	syntax on
	set encoding=utf-8
	set number relativenumber
	"themas:
	if has('termguicolors')
          set termguicolors
        endif
        " The configuration options should be placed before `colorscheme sonokai`.
        "let g:sonokai_style = 'andromeda'
        "let g:sonokai_style = 'default'
        let g:sonokai_style = 'atlantis'
        "let g:sonokai_style = 'shusia'
        "let g:sonokai_style = 'maia'
        let g:sonokai_enable_italic = 0
        let g:sonokai_disable_italic_comment = 0
        let g:sonokai_transparent_background = 0
	colorscheme sonokai
	"color onedark
	"color seoul256
	"color PaperColor
	set background=dark

" 02. Disables automatic commenting on newline:
	autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" 03. Goyo plugin makes text more readable when writing prose:
	map <leader>f :Goyo \| set bg=light \| set linebreak<CR>

" 04. Nerd tree
	map <leader>n :NERDTreeToggle<CR>
	autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
    if has('nvim')
        let NERDTreeBookmarksFile = stdpath('data') . '/NERDTreeBookmarks'
    else
        let NERDTreeBookmarksFile = '~/.vim' . '/NERDTreeBookmarks'
    endif

" 05. Automatically deletes all trailing whitespace and newlines at end of file on save.
	autocmd BufWritePre * %s/\s\+$//e
	autocmd BufWritepre * %s/\n\+\%$//e

" 06. Configuração das linguagens de programação:
  " Linters e fixers
let g:ale_linters = {
      \   'python': ['flake8', 'pylint'],
      \   'ruby': ['standardrb', 'rubocop'],
      \   'javascript': ['eslint']
      \}

let g:ale_fixers = {
      \    'python': ['yapf'],
      \    'cpp': ['astyle', 'uncrustify'],
      \}
nmap <F10> :ALEFix<CR>
let g:ale_fix_on_save = 1

  "Coc stuff
nmap <silent> gd <Plug>(coc-definition)
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
nmap <leader>rn <Plug>(coc-rename)
