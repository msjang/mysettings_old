

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
"set paste
nnoremap <silent> ,p :<C-U>set paste!<CR>:<C-U>echo("Toggle PasteMode => " . (&paste == 0 ? "Off" : "On"))<CR>


"마우스 사용
set mouse=an


"highlight previous search pattern
set hlsearch


"show cursor line
set cursorline


"Ignore Case
"set ic


"Clipboard
set cb=unnamed


"show match bracket
set showmatch
set matchtime=5


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


"Taglist plugin
filetype on
nnoremap <silent> <F3> :TlistToggle<CR>
let Tlist_Ctags_Cmd = "/usr/bin/ctags"
let Tlist_Inc_Winwidth = 0
let Tlist_Exit_OnlyWindow = 0
let Tlist_Auto_Open = 0
let Tlist_Use_Right_Window = 1


"Source Explorer plugin
nnoremap <silent> <F4> :SrcExplToggle<CR>


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


"NERDTree plugin
let NERDTreeWinPos = "left"
nnoremap <silent> <F5> :NERDTreeToggle<CR>
"nmap <F9> :NERDTreeToggle<CR>


"ctags plugin
set tags=./tags,tags,../tags,../../tags,../../../tags,../../../../tags,../../../../../tags
"set tag=./tags;/



"vundle plugin
set nocompatible              "be iMproved, required
filetype off                  "required
"set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

"let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
"Plugin 'Valloric/YouCompleteMe'
"Plugin 'AutoComplPop'
Plugin 'https://github.com/Shougo/neocomplete.vim'
Plugin 'plasticboy/vim-markdown'
Plugin 'tabman.vim'
Plugin 'VOoM'
Plugin 'The-NERD-tree'
Plugin 'taglist.vim'
Plugin 'https://github.com/wesleyche/SrcExpl'
Plugin 'DoxygenToolkit.vim'
Plugin 'DoxyGen-Syntax'
Plugin 'Tabular'

"color schemes
Plugin 'Blueshift'
Plugin 'Solarized'
Plugin 'Cleanroom'
Plugin 'summerfruit256.vim'

call vundle#end()            "required
filetype plugin indent on    "required


"YouCompleteMe plugin
"let g:ycm_global_ycm_extra_conf ='/home/msjang/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'


"vim-markdown plugin
let g:vim_markdown_folding_disabled=1


"tabman plugin
let g:tabman_width = 20
let g:tabman_side = 'left'
nnoremap <silent> <F2> :TMToggle<CR>
nmap <C-W>g :TMFocus<CR>

"colorschemes
"set t_Co=256
color blueshift
"color torte
"color summerfruit256


"auto start
autocmd VimEnter * TlistToggle
autocmd VimEnter * TMToggle
autocmd VimEnter * wincmd l


"new shortcut
"ref) http://stackoverflow.com/questions/3249275
nmap <C-W>t :tab split<CR><F2><C-W><Right><F3>


"my command example
"com! H echo "hello world"


"neocomplete plugin
let g:neocomplete#enable_at_startup = 1


"cscope plugin
let csfs=['./cscope.out','../cscope.out','../../cscope.out','../../../cscope.out','../../../../cscope.out', '../../../../../cscope.out', '../../../../../../cscope.out', '../../../../../../../cscope.out']
for csf in csfs
  if filereadable(csf)
    exe "cs add" csf
	"echo (csf . " selected")
	break
  endif
endfor

