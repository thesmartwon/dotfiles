syntax enable
set termguicolors
colorscheme spacegray
set encoding=utf-8
set clipboard+=unnamedplus
set backspace=indent,eol,start
set hidden

" I lead with space
map <Space> <Nop>
let mapleader=" "

" I don't like pressing shift all the time
map ; :

" display tab as 2
filetype plugin indent on
set tabstop=2 softtabstop=2
set shiftwidth=2
set smartindent
let g:latex_to_unicode_tab=0

" I edit this file a lot
nnoremap <leader>e :e $MYVIMRC<cr>
nnoremap <leader><S-r> :source $MYVIMRC<cr>

" line numbers
set signcolumn=yes
set number

" let me resize windows
set mouse=a

" I only do these on accident
map q: <Nop>

" nice menu when typing :find
set wildmenu
set wildignore+=**/.git/*
set wildignore+=**/.node_modules/*
set wildignore+=**/tmp/*
set wildignore+=**/target/*
set wildignore+=**/build/*
set wildignore+=*.zip
set wildignore+=*.exe
nnoremap <C-p> :find 

" Better <C-p>
nnoremap <leader>f :Files<CR>
nnoremap <leader>g :Rg<CR>

" https://www.youtube.com/watch?v=DogKdiRx7ls
set incsearch
nnoremap <silent> <Esc> :noh<CR>
set nowrap
set scrolloff=8
set noswapfile
set noshowmode
set completeopt=menuone,noinsert,noselect
set colorcolumn=80
set cmdheight=1

" quick find/replace
nnoremap <C-f> :%s/

" Easy window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <Esc>[1;5D <c-w>h
nnoremap <Esc>[1;5B <c-w>j
nnoremap <Esc>[1;5A <c-w>k
nnoremap <Esc>[1;5C <c-w>l

" netrw is an abonimation
let loaded_netrwPlugin = 1

" make errors
nnoremap <leader>q :cope<CR>

" rust make
let g:rust_recommended_style=0 " cramps my style
aug rust
  au!
	au FileType rust set makeprg=cargo\ check
  au FileType rust set errorformat=
              \%-G,
              \%-Gerror:\ aborting\ %.%#,
              \%-Gerror:\ Could\ not\ compile\ %.%#,
              \%Eerror:\ %m,
              \%Eerror[E%n]:\ %m,
              \%Wwarning:\ %m,
              \%Inote:\ %m,
              \%C\ %#-->\ %f:%l:%c,
              \%E\ \ left:%m,%C\ right:%m\ %f:%l:%c,%Z
aug END

" Return to cursor on open
aug position
  au BufReadPost *
      \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
      \ |   exe "normal! g`\""
      \ | endif
aug END

" Make directories to filepath when saving
function s:MkNonExDir(file, buf)
    if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
        let dir=fnamemodify(a:file, ':h')
        if !isdirectory(dir)
            call mkdir(dir, 'p')
        endif
    endif
endfunction
augroup BWCCreateDir
    autocmd!
    autocmd BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END

augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank({timeout = 500})
augroup END

lua require('lsp')
lua require('git')

nmap <leader>rn :lua vim.lsp.buf.rename()<cr>
nmap <leader>d :lua vim.lsp.buf.definition()<cr>
nmap <leader>i :lua vim.lsp.buf.implementation()<cr>
nmap <leader>r :lua vim.lsp.buf.references()<cr>
nmap <leader>h :lua vim.lsp.buf.hover()<cr>
nmap <leader>j :lua vim.diagnostic.goto_next()<cr>
nmap <leader>k :lua vim.diagnostic.goto_prev()<cr>
"nmap <silent> <leader>s :CocCommand clangd.switchSourceHeader<cr>

function! s:empty_message(timer)
	echon ''
endfunction

augroup cmd_msg_cls
    autocmd!
    autocmd CmdlineLeave :  call timer_start(800, funcref('s:empty_message'))
augroup END
