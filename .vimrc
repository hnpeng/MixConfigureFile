let mapleader=";" " 定义leader键

" vim颜色主题
" colorscheme blue
" colorscheme darkblue
" colorscheme delek
" colorscheme desert
" colorscheme elflord
" colorscheme evening
" colorscheme industry
" colorscheme koehler
" colorscheme morning
" colorscheme murphy
" colorscheme pablo
" colorscheme peachpuff
" colorscheme ron
" colorscheme shine
" colorscheme slate
" colorscheme torte
" colorscheme zellner
" colorscheme wombat256mod
" colorscheme vividchalk

set autoread    " 文件被外部改变时自动重新读入

set listchars=tab:>-,trail:$

" set encoding=cp936      " 设置vim自身内部消息使用的编码
set fileencoding=utf-8  " 设置文件保存的格式，无论打开什么编码的文本，最终会保存成设置的格式
set fileencodings=utf-8,ucs-bom,cp-936  " 设置vim解码的猜测列表，先用utf-8解码，失败后再用ucs-bom解码，依次类推
" set termencoding=utf-8  " 设置在终端中vim的编码方式

" set nobackup    " 不产生自动备份文件
set noswapfile  " 不产生交换文件

set lazyredraw " 在执行宏命令时不显示重绘，执行完成后一次性重绘，能构优化打开大文件卡顿问题



" 以下两行设置关键字颜色开启
syntax enable
" syntax on

set number " 开启显示行号

set ruler " 右下角实时显示光标的位置
" 高亮显示当前行/列
" set cursorline
" set cursorcolumn

" autocmd BufWritePost ${MYVIMRC} source ${MYVIMRC}	" 让配置文件的更改立即生效

" 搜索设置
set incsearch	" 命令行输入搜索字符同时进行搜索
set ignorecase	" 搜索时大小写不敏感
set smartcase   " 在启动大小写不敏感时，搜索的字母包含大写字母就会大小写敏感，小写则不会
set hlsearch	" 高亮显示搜索结果

set wildmenu	" 命令行模式的命令智能补全

" 缩进设置
filetype indent on	" 自适应不同语言的智能缩进
set expandtab		" 将制表符扩展为空格
" set tabstop=4		" 设置制表符占用空格数
set shiftwidth=4        " 设置格式化时制表符占用空格数
set softtabstop=4       " 让 vim 把连续数量的空格视为一个制表符


" 基于缩进或语法进行代码折叠
set foldmethod=indent
"set foldmethod=syntax
set nofoldenable        " 启动 vim 时关闭折叠代码
"za，打开或关闭当前折叠；zM，关闭所有折叠；zR，打开所有折叠

"""python支持PIPE8风格的缩进"""
au BufNewFile,BufRead *.py
	\ set tabstop=4 |
	\ set softtabstop=4 |
	\ set shiftwidth=4 |
	\ set textwidth=79 |
	\ set expandtab |
	\ set autoindent | 
	\ set fileformat=unix | 
	\ set colorcolumn=80

"""其他语言的缩进"""
au BufNewFile,BufRead *.js, *.html, *.css
        \ set tabstop=2 |
        \ set softtabstop=2 |
        \ set shiftwidth=2 

set mouse=a     " 鼠标点击能够激活vim中的窗口并支持鼠标滚动


"""Ctags 的配置"""
" 映射<C-F12>为生成ctags文件的命令
map <leader>tt :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>


"""cscope"""
if has("cscope")
	set csprg=/usr/local/bin/cscope
	set csto=0
	set cst
	set nocsverb
	" add any database in current directory  
	if filereadable("cscope.out") 
		cs add cscope.out  
	" else add database pointed to by environment 
	elseif $CSCOPE_DB != ""  
		cs add $CSCOPE_DB 
	endif 
	set csverb
endif 
nmap <Space>r :cs find g 
nmap <Space>s :cs find s <C-R>=expand("<cword>")<CR><CR>	" 查找这个符号
nmap <Space>g :cs find g <C-R>=expand("<cword>")<CR><CR>	" 查找这个定义
nmap <Space>c :cs find c <C-R>=expand("<cword>")<CR><CR>	" 查找被这个函数调用的函数们
nmap <Space>t :cs find t <C-R>=expand("<cword>")<CR><CR>	" 查找调用这个函数的函数们
nmap <Space>e :cs find e <C-R>=expand("<cword>")<CR><CR>	" 查找这个字符串
nmap <Space>f :cs find f <C-R>=expand("<cfile>")<CR><CR>	" 查找这个egrep匹配模式
nmap <Space>i :cs find i <C-R>=expand("<cfile>")<CR><CR>	" 查找这个文件
nmap <Space>d :cs find d <C-R>=expand("<cword>")<CR><CR>	" 查找#include这个文件的文件们
" 使用方法：先在项目根目录下使用shell命令 cscope -Rbq
" 生成cscope.out,cscope.in.out,cscope.po.out 
nmap <leader>tr :!cscope -Rbq<CR>


"""Vundle 的配置""" 插件管理器用于管理所有的插件
set nocompatible	" 去除VI一致性，即VIM不考虑和VI兼容必须添加
filetype on		" 必须添加

" 设置包括vundle和初始化相关的runtine path
set rtp+=~/.vim/bundle/Vundle.vim

" vundle 管理的插件必须位于 vundle#begin() 和 vundle#end() 之间
" call vundle#begin()
" 另一种选择，指定一个vundle安装插件的路径
call vundle#begin('~/.vim/bundle')

Plugin 'VundleVim/Vundle.vim' " 让vundle管理插件版本

" Github 上的插件格式为: Plugin '用户名/插件仓库名' 或者 Plugin 'git 地址'


"""taglist"""
"Plugin 'vim-scripts/taglist.vim'
"let Tlist_Ctags_Cmd='ctags' " ctags命令在环境变量目录下，所以省略具体路径
"let Tlist_Show_One_File=1   " 不同时显示多个文件的tag，只显示当前文件的
"let Tlist_WinWidth = 40     " 设置taglist的宽度
"let Tlist_Exit_OnlyWindow=1 " 如果taglist窗口是最后一个窗口则退出vim
"" let Tlist_Use_Right_Window=1 " 在窗口右侧显示taglist
"let Tlist_Use_Left_Window=1 " 在窗口左侧显示taglist
"" let Tlist_Auto_Open=1       " 启动vim后自动打开taglist
"" 设置taglist的快捷键
"map <silent> <leader>tg :TlistToggle<CR>


"""tagbar""" 用于查看类的结构
Plugin 'majutsushi/tagbar'
" 快捷键设置
nmap <leader>tb :TagbarToggle<CR>
let g:tagbar_ctags_bin='ctags'    " ctags命令路径
let g:tagbar_width=40		  " 窗口宽度设置
let g:tagbar_left=1 		  " 设置tagbar的窗口显示的位置,为左边
"autocmd BufReadPost *.cpp,*.c,*.h call tagbar#autoopen() " c/c++文件自动启动tagbar
autocmd BufReadPost *.cpp,*.c,*.h,*.hpp,*.cc,*.cxx call tagbar#autoopen()


"""NERDTree""" 用于查看文件夹的结构
Plugin 'scrooloose/nerdtree'
let NERDTreeWinPos='right' " 设置NERDTree显示在窗口的右边
let NERDTreeWinSize=40	   " 设置NERDTree的宽度
" 设置NERDTree的快捷键
nmap <silent> <leader>n :NERDTreeToggle<CR>
" let NERDTreeShowHidden=1   " 显示隐藏文件
" let NERDTreeMinimalUI=1    " NERDTree窗口不显示冗余帮助信息
let NERDTreeAutoDeleteBuffer=1 " 删除文件时自动删除对应的buffer
" autocmd VimEnter * NERDTree  " 启动vim时自动打开NERDTree


"""MiniBufExplorer""" 用于以标签的方式显示vim打开的缓存，使得可以快速切换
"Plugin 'fholgado/minibufexpl.vim'
"let g:miniBufExplMapWindowNavVim = 1
"let g:miniBufExplMapWindowArrows = 1
"let g:miniBufExplMapCTabSwitchBufs = 1
"let g:miniBufExplModSelTarget = 1
"let g:miniBufExplMoreThanOne = 0
" 设定上一个标签和下一个标签的快捷键
nmap <F12> :bn<CR>
nmap <F11> :bp<CR>
"nmap <leader>c :MBEbd<CR>


"""vim-airline""" 让状态栏显示更多信息
"Plugin 'bling/vim-airline'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
let g:airline#extensions#tabline#enabled = 1    " 开启顶部的Buffer显示
let g:airline#extensions#tabline#left_sep = '⮀'
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
" let g:airline_theme='simple'    " 设置状态栏主题tip:命令行输入AirlineTheme<TAB>可查看所有主题
"set linespace=0
let g:airline_powerline_fonts = 1
" set laststatus=2 " 总是显示状态栏
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
" powerline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.maxlinenr = ''


"""clang_complete""" c/c++代码补全并且具有语法检查
" Plugin 'Rip-Rip/clang_complete'
" let g:clang_complete_copen=1
" let g:clang_periodic_quickfix=1
" let g:clang_snippets=1
" " let g:clang_user_options='-std=c99'
" let g:clang_use_library=1
" let g:clang_user_options='-stdlib=libc++ -std=c++11 -IIncludePath'
" let g:clang_complete_optional_args_insnippets=0
" let g:clang_auto_select=1
" let g:clang_close_preview=1
" let g:clang_complete_macros=1


"""ctrlp""" 用于快速查找并打开文档
Plugin 'ctrlpvim/ctrlp.vim'
map <leader>f :CtrlP<CR>


"""OmniCppComplete""" 自动补全c++代码的插件
Plugin 'OmniCppComplete'
set tags+=/Users/hnp/ctags/cpp_src/tags/cpp
let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1 
let OmniCpp_ShowPrototypeInAbbr = 1 " 显示函数参数列表 
let OmniCpp_MayCompleteDot = 1   " 输入 .  后自动补全
let OmniCpp_MayCompleteArrow = 1 " 输入 -> 后自动补全 
let OmniCpp_MayCompleteScope = 1 " 输入 :: 后自动补全 
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
" 自动关闭补全窗口 
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif 
set completeopt=menuone,menu,longest
" 颜色美化
" highlight Pmenu    guibg=darkgrey  guifg=black 
" highlight Pmenu    guibg=green  guifg=red 
" highlight PmenuSel guibg=lightgrey guifg=black
" 手动按下 Ctrl+X Ctrl+O 后也就会弹出自动补全窗口


"""SuperTab"""
Plugin 'SuperTab'
" let g:SuperTabDefaultCompletionType="context" 


"""scrooloose/nerdcommenter""" 注释插件
Plugin 'scrooloose/nerdcommenter'
" let g:NERDSpaceDelims = 1  " 注释符号后添加空格
" let g:NERDCompactSexyComs = 1
" let g:NERDDefaultAlign = 'right'


"""gruvbox""" 颜色主题插件
Plugin 'morhetz/gruvbox'
"let g:gruvbox_italic=1
"let g:gruvbox_termcolors=256
let g:NERDTrimTrailingWhitespace = 1


"""solarized"""
Plugin 'altercation/vim-colors-solarized'
let g:solarized_termcolors=256


call vundle#end()

set t_Co=256
set background=light
set cursorline
let g:airline_theme='base16'    " 设置状态栏主题tip:命令行输入AirlineTheme<TAB>可查看所有主题
"set linespace=0
" set background=dark
"colorscheme gruvbox
colorscheme solarized


filetype plugin indent on " 加载vim自带和插件相应的语法和文件类型相关脚本
" 忽视插件改变缩进，可以使用以下代替：filetype plugin on
filetype plugin on

" 常用的vim命令模式下的命令
" :PluginList         - 列出已有配置的插件
" :PluginInstall      - 安装插件，追加'!'用于更新插件
" :PluginUpdate       - 更新所有vundle管理的插件
" :PluginSearch foo   - 搜索 foo；追加'!'清除本地缓存
" :PluginClean        - 清除未使用的插件，需要确认，追加'!'自动批准
" 查阅 :h vundle 获取更多细节和wiki以及FAQ


"""设置编译快捷键“”“
nmap<F9> :call Compile()<CR>
nmap<F10> :call Run()<CR>
nmap<F5> :call Compile()<CR> :call Run()<CR>
nmap<F6> :call Compile()<CR> :call Debug()<CR>

func! Compile()
    w
    !g++ % -o %< -lm -Wall
endf

func! Run()
    if &filetype == 'cpp'
        !./%<
    elseif &filetype == 'python'
        !python %
    elseif &filetype == 'sh'
        !bash %
    else
        ! ./%
    endif
endf

func! Debug()
    !gdb %<
endf

"""设置跳转窗口快捷键"""
"nnoremap <C-J> <C-W><C-J>
"nnoremap <C-K> <C-W><C-K>
"nnoremap <C-L> <C-W><C-L>
"nnoremap <C-H> <C-W><C-H>

