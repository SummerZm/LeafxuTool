set nu		"显示行号
set ts=4	"设定tab空格数
set ruler	"显示标尺  
set showcmd	"输入的命令显示出来

"不要闪烁(screen命令会出现闪烁情况)
set novisualbell	

"允许鼠标
set mouse=a

"允许折叠
set foldenable 	

"set foldmethod=manual	"手动折叠

"命令折叠： zi 打开/关闭所有折叠；zo 打开当前折叠; 
set foldmethod=indent 

" 当文件被改动时自动载入
set autoread

"代码补全
set completeopt=preview,menu

"共享剪贴板
set clipboard+=unamed

"自动载入修改
set autoread

" 设置高亮
set hls

" 取消错误鸣叫
set noeb

" 取消vi键盘模式
set nocompatible

" 自动缩进
set autoindent

" C语言自动缩进
set smartindent
set shiftwidth=4
set expandtab
set softtabstop=4

" 粘贴不复制缩进
set paste
"set nopaste

" 未保存或只读文件时弹出确认
set confirm

" 搜索忽略大小写
set ignorecase

" 禁止生成临时文件
set nobackup
set noswapfile

"编码设置
set enc=utf-8
set fencs=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936
:set fileencoding=gb2312

"语言设置
set langmenu=zh_CN.UTF-8
set helplang=cn

"我的状态行显示的内容（包括文件类型和解码）
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]%{strftime(\"%d/%m/%y\ -\ %H:%M\")}
"set statusline=[%F]%y%r%m%*%=[Line:%l/%L,Column:%c][%p%%]

"打开文件类型检测, 加了这句才可以用智能补全
set completeopt=longest,menu

"用浅色高亮当前行
autocmd InsertLeave * se nocul	
autocmd InsertEnter * se cul	

"设置语法高亮
syntax on	

"允许插件
filetype plugin on
"====================================================================
" 热键映射
"====================================================================
"映射全选复制
map <C-A> ggVGY	
map! <C-A> <Esc> ggVGY

" 比较文件
nnoremap <C-F2> :vert diffsplit

"映射撤销---冲突
"map <C-Z> u	

"map <C-S> :w <CR> 映射失"打开当前目录列表败
map <F3> :tabnew .<CR>	


"======================================================================
" ctags 配置
"======================================================================
set tags+=tags
set autochdir
"默认打开Taglist 
let Tlist_Auto_Open=1 
let Tlist_Ctags_Cmd = '/usr/bin/ctags' 
let Tlist_Sort_Type = "name" " 按照名称排序 
let Tlist_Use_Left_Window = 1 " 在左侧显示窗口 
let Tlist_Compart_Format = 1 " 压缩方式 
let Tlist_File_Fold_Auto_Close = 0 " 不要关闭其他文件的tags 
"let Tlist_Use_Left_Window = 1 "在右侧窗口中显示taglist窗口
let Tlist_Use_Right_Window = 1 "在右侧窗口中显示taglist窗口
let Tlist_Enable_Fold_Column = 0 " 不要显示折叠树 
let Tlist_WinWidth=40   "设置taglist宽度
let Tlist_Show_One_File=1 "不同时显示多个文件的tag，只显示当前文件的
let Tlist_Exist_OnlyWindow = 1 " 如果只有一个buffer，kill窗口也kill掉buffer 

"设置tags.
"./tag;  递归查找当前打开vim所在目录上级 (;代表递归的意思)
"tags    查找当前打开vim所在目录上级
"set tags=./tags;,tags;
"map <F10> :!ctags -R --c++ -kinds=+p --fields=+ias --extra=+q .<CR>:TaglistToggle<CR>
"map <F10> :!ctags -R <CR> :TaglistToggle<CR>
"map <silent><F10> :!ctags -R <CR> :TlistToggle<CR>

map <F9> :!ctags -R <CR> :TaglistToggle<CR>
map <silent><F9> :!ctags -R <CR> :TlistToggle<CR>

"=====================================================================
" cscope 配置
"=====================================================================

"To solve 'duplicate cscope database not added'
set nocscopeverbose

if has("cscope")  
    set csprg=/usr/bin/cscope  
	" if 0 the cscope database will be search first, tag file second
	set csto=0  
	" use ctag instead of tag
    set cst  
	" prompt database add if success
    set csverb  
	" how many level of the path will be show 
    set cspc=3  
"===================================
    "add any database in current dir  
    if filereadable("cscope.out")  
		let cscope_file= findfile("cscope.out",".;")  
        let cscope_pre = system("pwd")
        let cscope_pre = strpart(cscope_pre,0,strlen(cscope_pre) - 1)
        if !empty(cscope_file) && filereadable(cscope_file)  
        	exe "cs add" cscope_file cscope_pre  
        	echo "cs add" cscope_file cscope_pre  
        endif        
    endif  
"===================================
	"add any database in current dir  
    "if filereadable("cscope.out")  
    	"cs add cscope.out  
    "else search cscope.out elsewhere  
    "else  
    	"let cscope_file=findfile("cscope.out", '".;")  
        "let cscope_pre=matchstr(cscope_file,".*/")  
        "if !empty(cscope_file) && filereadable(cscope_file)  
        	"exe "cs add" cscope_file cscope_pre  
        "endif        
   	"endif  
endif  

map g<C-]> :cs find 3 <C-R>=expand(“<cword>”)<CR><CR>

"水平分割窗口
"0/s 查找c符号
nmap <C-\>s :scs find s <C-R>=expand("<cword>")<CR><CR>

"1/g 查找定义 
nmap <C-\>g :scs find g <C-R>=expand("<cword>")<CR><CR>

"3/c 查找调用这个函数的函数们
nmap <C-\>c :scs find c <C-R>=expand("<cword>")<CR><CR>

"4/t 查找这个字符串
nmap <C-\>t :scs find t <C-R>=expand("<cword>")<CR><CR>

"6/e 查找这个egrep 匹配模式
nmap <C-\>e :scs find e <C-R>=expand("<cword>")<CR><CR>

"7/f 查找这个文件
nmap <C-\>f :scs find f <C-R>=expand("<cfile>")<CR><CR>

"8/i 查找#include这个文件的文件们
nmap <C-\>i :scs find i <C-R>=expand("<cfile>")<CR><CR>

"2/d 查找被这个函数调用的函数们
nmap <C-\>d :scs find d <C-R>=expand("<cword>")<CR><CR>

"垂直分割窗口
"0/s 查找c符号 --- <C-/> 和 <C-Space> 貌似没用
nmap <C-/>s :vert scs find s <C-R>=expand("<cword>")<CR><CR>

"1/g 查找定义 
nmap <C-/>g :vert cs find g <C-R>=expand("<cword>")<CR><CR>

"3/c 查找调用这个函数的函数们
nmap <C-/>c :vert scs find c <C-R>=expand("<cword>")<CR><CR>

"4/t 查找这个字符串
nmap <C-/>t :vert scs find t <C-R>=expand("<cword>")<CR><CR>

"6/e 查找这个egrep 匹配模式
nmap <C-/>e :vert scs find e <C-R>=expand("<cword>")<CR><CR>

"7/f 查找这个文件
nmap <C-/>f :vert scs find f <C-R>=expand("<cfile>")<CR><CR>

"8/i 查找#include这个文件的文件们
nmap <C-/>i :vert scs find i <C-R>=expand("<cfile>")<CR><CR>

"2/d 查找被这个函数调用的函数们
nmap <C-/>d :vert scs find d <C-R>=expand("<cword>")<CR><CR>

"""""新文件标题""""""""""
"新建.c,.h,.sh,.java文件，自动插入文件头 
autocmd BufNewFile *.xu,*.doc,*.cpp,*.[ch],*.sh,*.java exec ":call SetTitle()" 
"""定义函数SetTitle，自动插入文件头 
func SetTitle() 
"如果文件类型为.sh文件 
if &filetype == 'sh' 
call setline(1,"\#########################################################################") 
call append(line("."), "\# File Name: ".expand("%")) 
call append(line(".")+1, "\# Author: Leafxu") 
"call append(line(".")+2,
""\# mail: <a href=\"mailto:test@jbxue.com\">test@jbxue.com</a>") 
call append(line(".")+2, "\# Created Time: ".strftime("%c")) 
call append(line(".")+3, "\#########################################################################") 
call append(line(".")+4, "\#!/bin/bash") 
call append(line(".")+5, "") 
else 
call setline(1, "\/*************************************************************************") 
call append(line("."), " > File Name: ".expand("%")) 
call append(line(".")+1, " > Author: Leafxu") 
"call append(line(".")+2, 
"" > Mail: <a href=\"mailto:test@jbxue.com\">test@jbxue.com</a> ") 
call append(line(".")+2, " > Created Time: ".strftime("%c")) 
call append(line(".")+3, " ************************************************************************/") 
call append(line(".")+4, "")
endif
"if &filetype == 'cpp'
"call append(line(".")+5, "#include<iostream>")
"call append(line(".")+6, "using namespace std;")
"call append(line(".")+7, "")
"endif
if &filetype == 'c'
call append(line(".")+5, "#include<stdio.h>")
call append(line(".")+6, "")
endif
"新建文件后，自动定位到文件末尾
autocmd BufNewFile * normal G
endfunc 

"列表操作
"======================================================================
" 在插入模式下，按Ctrl-L，自动插入序号列表。Ctrl+R列表序号归0
"=====================================================================
let counter = 0 
"inoremap <expr> <C-L> ListItem() 
"inoremap <expr> <C-R> ListReset()  //
"与插入模式下的寄存器操作冲突，实际上列表操作这个不常用 

func ListItem() 
let g:counter += 1 
return g:counter . '. ' 
endfunc 

func ListReset() 
let g:counter = 0 
return '' 
endfunc 

"====================================================================
" 文件管理插件
"===================================================================
"autocmd VimEnter * NERDTree
map <F12> :NERDTreeMirror<CR> 
map <F12> :NERDTreeToggle<CR>   



