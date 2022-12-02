"BASE
set term=$TERM
packadd termdebug
let g:termdebug_wide = 100
set encoding=UTF-8
set nocompatible
set number relativenumber
set incsearch
set autoindent
set smartindent
set wildmode=list:longest,full
set hidden
set scrolloff=8
set ignorecase
set smartcase
filetype plugin on
syntax enable
"set formatoptions+=a "so text is auto formatted while typing
set linebreak
set laststatus=2
set noshowmode
set display=lastline
set splitbelow
set noswapfile
set backupdir=~/.vim/backupdir
set undofile
set undodir=~/.vim/undodir
set updatetime=50
set timeoutlen=1000 ttimeoutlen=0

"SPELLCHECK
map <Left> :setlocal spell! spelllang=en_us<CR>
map <Right> :set spelllang=ru_ru<CR>
"FIX: need to find a dictionary for RU.



"PLUGS
call plug#begin('~/.vim/plugged')

Plug 'morhetz/gruvbox'
Plug 'Yggdroot/indentLine'
Plug 'airblade/vim-rooter'
Plug 'vim-utils/vim-man'
Plug 'mbbill/undotree'
Plug 'vimwiki/vimwiki'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-commentary'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'preservim/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-sleuth'
Plug 'hashivim/vim-terraform'
Plug 'dense-analysis/ale'
Plug 'rust-lang/rust.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'mattn/vim-lsp-settings'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'ryanoasis/vim-devicons'

call plug#end()




"Specific ALE configs | Asyncomplete pop up scrolling
let g:ale_linters = {'rust': ['analyzer']}
let g:ale_cursor_detail = 1
let g:ale_floating_preview = 1
let g:ale_hover_to_preview = 1
let g:ale_floating_window_border = ['│', '─', '╭', '╮', '╯', '╰', '│', '─']
set pumheight=10
autocmd ColorScheme * highlight pmenu guibg=#282828 gui=bold

 inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
 inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"
"inoremap <expr> j ((pumvisible())?("\<C-n>"):("j"))
"inoremap <expr> k ((pumvisible())?("\<C-p>"):("k"))





"LIGHTLINE (status bar) config; colors at -  :h g:lightline.colorscheme
let g:lightline = {
      \ 'colorscheme': 'gruvbox',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }

"VIMWIKI
let g:vimwiki_list = [{'path': '~/vimwiki/',
			 \ 'syntax': 'markdown', 'ext': '.md'}]


"THEME
set background=dark
colorscheme gruvbox
highlight Normal ctermbg=NONE guibg=NONE
highlight Comment ctermfg=246 guifg=#a89984
highlight CursorLineNr ctermfg=246 guifg=#a89984

set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

highlight NERDTreeCWD ctermfg=red
hi NERDTreeClosable guifg=#FF0000 ctermfg=red
hi NERDTreeOpenable ctermfg=green
hi NERDTreeDir ctermfg=red
hi NERDTreeFlags ctermfg=Gray


"LEADER
let mapleader = " "

"KEYMAPS
" nnoremap  <silent> <s-tab>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bprevious<CR>
"nnoremap  <silent>   <tab>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bnext<CR>
map <S-t> :tabnew<CR>
map <S-h> :tabprevious<CR>
map <S-l> :tabnext<CR>
map <C-h> <C-w>h
map <C-l> <C-w>l
map <C-j> <C-w>j
map <C-k> <C-w>k
nmap p :pu<CR>
nmap P :pu!<CR>
nmap <C-P> :set paste!<CR>
nnoremap <leader>u :UndotreeShow<CR>
nnoremap <silent> <Leader>- :vertical resize +5<CR>
nnoremap <silent> <Leader>= :vertical resize -5<CR>
nnoremap <silent> <Leader><Up> :resize +5<CR>
nnoremap <silent> <Leader><Down> :resize -5<CR>
map <leader>m <Plug>(Man) 
map <leader>v <Plug>(Vman)
map <C-y> :w !wl-copy <CR><CR>
nnoremap Y y$ 
nnoremap <leader>b :buffers<CR>:buffer<Space>
nnoremap <leader>s :FZF<CR>
nnoremap <leader>n :NERDTreeToggle<CR>
nnoremap <leader>d :ALEGoToDefinition -tab<CR>
nnoremap <leader>t :ALEGoToTypeDefinition -tab<CR>
nnoremap <leader>i :ALEGoToImplementation -tab<CR>
nnoremap <leader>r :ALEFindReferences -tab<CR>
nnoremap <leader>h :ALEHover<CR>
nnoremap <leader>f :%! rustfmt<CR>



"FUGITIVE KEYMAPS (and highlighting)
nnoremap <leader>g :Git<CR> 
nnoremap <leader>gc :Git commit<CR> 
nnoremap <leader>gp :Git push<CR>
nnoremap <leader>gd :Gvdiffsplit<CR>
nnoremap <leader>gi :Git rebase -i<CR>
"index|working copy
nnoremap <leader>gw :Gwrite<CR>
nnoremap <leader>gr :Gread<CR>
nnoremap <leader>gm :Gmove
nnoremap <leader>grm :GRemove<CR>
nnoremap <leader>gb :Git blame<CR>
nnoremap <leader>gl  :Git log<CR>
nnoremap <leader>ge :Gedit :0<CR>


highlight DiffDelete ctermbg=0 ctermfg=196
highlight DiffAdd ctermbg=237 ctermfg=107 
highlight DiffChange ctermbg=237 ctermfg=130
highlight DiffText ctermbg=237 ctermfg=172




"EYECANDY, move chunks in Visual Mode
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
inoremap <C-j> <esc> :m .+1<CR>==
inoremap <C-k> <esc> :m .-2<CR>==
nnoremap <leader>k :m .-2<CR>==
nnoremap <leader>j :m .+1<CR>==



"AUTOCMDs for Specific Filetypes
autocmd FileType yaml setlocal ai ts=2 sw=2 et

augroup terraform
	au!
	autocmd FileType terraform setlocal autoread 
	nnoremap <leader>f :!terraform fmt %<CR> L <CR>
augroup end

augroup jenkins_as_groovy
	au!
	au BufNewFile,BufRead *.jenkinsfile,*.Jenkinsfile,Jenkinsfile,jenkinsfile setf groovy
augroup END

autocmd FileType groovy setlocal ai ts=2 sw=2 et
