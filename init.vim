" [leaser key]
set showcmd
let mapleader = ' '

" [keybindings]
map <F2> :w<CR>
nmap <F7> :Project<CR>
nmap <F8> :TlistToggle<CR>
nmap <F10> :qa<CR>

nmap <C-S-P> :call <SID>SynStack()<CR>
function! <SID>SynStack()
    if !exists("*synstack")
        return
    endif
    echo map(synstack(line('.'),col('.')), 'synIDattr(v:val,"name")')
endfunc

set pastetoggle=<F12>

" [mouse]
set mouse=a


" [tab intervals]
set tabstop=4
set shiftwidth=4
set smartindent


" [hightlight current line and column]
set cursorline
"set cursorcolumn


" [colorscheme]
set background=dark
set t_ZH=[3m
set t_ZR=[23m

set t_Co=256
colorscheme solarized
let g:solarized_termcolors=256

" [buffers]
set hidden

" [c++]
autocmd BufRead,BufNewFile *.tpp set filetype=cpp

" [vala]
autocmd BufRead *.vala,*.vapi set efm=%f:%l.%c-%[%^:]%#:\ %t%[%^:]%#:\ %m
au BufRead,BufNewFile *.vala,*.vapi setfiletype vala

" [kivy]
au BufNewFile,BufRead *.kv set filetype=yaml

" [airline]
set laststatus=2
let g:airline_detect_paste = 1

" [ncm2]
" enable ncm2 for all buffers
"autocmd BufEnter * call ncm2#enable_for_buffer()
"set completeopt=noinsert,menuone,noselect
"
" [MUcomplete]
set completeopt+=menuone
let g:mucomplete#enable_auto_at_startup = 1
let g:mucomplete#completion_delay = 1


" [LanguageClient]
set hidden

let g:LanguageClient_serverCommands = {
	\ 'cpp': ['cquery', '--log-file=/tmp/cq.log', '--init={"cacheDirectory":"/tmp/cquery/"}'],
	\ 'c': ['cquery', '--log-file=/tmp/cq.log', '--init={"cacheDirectory":"/tmp/cquery/"}'],
	\ 
    \ 'python': ['/usr/local/bin/pyls'],
    \ }

"nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> gr :call LanguageClient#textDocument_references()<CR>
nnoremap <silent> gs :call LanguageClient#textDocument_documentSymbol()<CR>
nnoremap <silent> <F6> :call LanguageClient#textDocument_rename()<CR>


" [Plugins]
call plug#begin('~/.config/nvim/plugged')
Plug 'vim-scripts/taglist.vim'
Plug 'pearofducks/ansible-vim'
Plug 'vim-airline/vim-airline'
Plug 'richq/cmake-lint'
"Plug 'ncm2/ncm2-jedi'
Plug 'Kuniwak/vint'
Plug 'sakhnik/nvim-gdb', { 'do': ':!./install.sh \| UpdateRemotePlugins' }
Plug 'vim-scripts/a.vim'
"Plug 'tpope/vim-fugitive'
"Plug 'ncm2/ncm2'
"Plug 'roxma/nvim-yarp'
Plug 'lifepillar/vim-mucomplete'
Plug 'autozimu/LanguageClient-neovim', {
	\	 'branch': 'next',
	\	 'do': 'bash install.sh',
	\ }
"Plug 'Shougo/neoinclude.vim'
"Plug 'ervandew/supertab'
"Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
Plug 'vim-scripts/rtorrent-syntax-file'
call plug#end()

"call ncm2#override_source('LanguageClient_python', {'enable': 0})
