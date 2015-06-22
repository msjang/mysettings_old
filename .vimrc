"help OPTION                                                                                                                                                        

syntax on

set encoding=utf-8
set fileencodings=utf-8,euc-kr

"탭 하나의 크기를 4로 설정
set tabstop=4
set shiftwidth=4
set softtabstop=4

set autoindent
"TAB을 space로 치환
"set expandtab
"Display line number
set number
"numberwidth
set numberwidth=8

"소스 폴딩
set foldmethod=marker


"하단에 상태 표시줄
set laststatus=2
set statusline=%<%F%h%m%r%h%w%y\ %{strftime(\"%Y/%m/%d-%H:%M\")}%=\ col:%c%V\ ascii:%b\ pos:%o\ lin:%l\,%L\ %P

"붙이기 모드로 전환
set paste

"마우스 사용
set mouse=an

"highlight previous search pattern
set hlsearch

"show cursor line
set cursorline

color torte

"Ignore Case
" set ic
"Clipboard
set cb=unnamed
"show match bracket
"set showmatch
"set matchtime=5


"Window Fix Width
"set wfw
"set wfh



if &term =~ "xterm"
  if has("terminfo")
    set t_Co=8
    set t_Sf=^[[3%p1%dm
    set t_Sb=^[[4%p1%dm
  else
    set t_Co=8
    set t_Sf=^[[3%dm
    set t_Sb=^[[4%dm
  endif
endif

" Taglist plugin
filetype on
nnoremap <silent> <F2> :TlistToggle<CR>
let Tlist_Ctags_Cmd = "/usr/bin/ctags"
let Tlist_Inc_Winwidth = 0
let Tlist_Exit_OnlyWindow = 0
let Tlist_Auto_Open = 0
let Tlist_Use_Right_Window = 1

" Source Explorer plugin
nnoremap <silent> <F3> :SrcExplToggle<CR>

"nmap <F8> :SrcExplToggle<CR>
nmap <C-H> <C-W>h
nmap <C-J> <C-W>j
nmap <C-K> <C-W>k
nmap <C-L> <C-W>l

let g:SrcExpl_winHeight = 8
let g:SrcExpl_refreshTime = 100
let g:SrcExpl_jumpKey = "<ENTER>"
let g:SrcExpl_gobackKey = "<SPACE>"
let g:SrcExpl_isUpdateTags = 0


" NERDTree plugin
let NERDTreeWinPos = "left"
nnoremap <silent> <F4> :NERDTreeToggle<CR>
" nmap <F9> :NERDTreeToggle<CR>


" ctags plugin
set tags=./tags,tags,../tags,../../tags,../../../tags,../../../../tags
"set tag=./tags;/


set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

Plugin 'Valloric/YouCompleteMe'
Plugin 'VOoM'
"Plugin 'Markdown'
Plugin 'https://github.com/jtratner/vim-flavored-markdown'
"Plugin 'https://github.com/gabrielelana/vim-markdown'
Plugin 'tabman.vim'



call vundle#end()            " required
filetype plugin indent on    " required

let g:ycm_global_ycm_extra_conf ='/home/msjang/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'

augroup markdown
    au!
    au BufNewFile,BufRead *.md,*.markdown setlocal filetype=ghmarkdown
	"au BufNewFile,BufRead *.md,*.markdown Voom markdown
augroup END

Bundle 'gabrielelana/vim-markdown'
