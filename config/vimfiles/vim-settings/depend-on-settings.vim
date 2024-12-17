"2024年11月28日
"需要依赖项的设置

"# 映射(mapping) {{{

nnoremap <LEADER>md :tabnew $HOME/vimfiles/pack/MyVim<CR>
nnoremap <LEADER>i  :call me#CreateImplement()<CR>
nnoremap <LEADER>e  :call me#GenerateDefine()<CR>
nnoremap <C-b> :call me#Compile()<CR>
nnoremap gs :call me#SwitchToSource()<CR>


"}}} # 映射(mapping)

"## my variable {{{
"根据平台信息和用户信息，进行变量的设置

let $my_dict = "D:\\user\\code"
if has('win32')
    let $mycfg="~/vimfiles/pack/MyVim/start"
    let $mytmp="~/vimfiles/tmp"
    let $myinclude="D:\\user\\code\\libraries\\include"
    let $myhome="D\\user\\code"
    let $mynote=$my_dict.."\\note"
    let $mycpp = "D:\\user\\code\\practice\\cpp"
    let $myprac = "D:\\user\\code\\practice"
else
    let $mycfg="~/.vim/pack/MyVim/start"
    let $mytmp="~/.vim/tmp"
endif

"}}} ## my variable


command -nargs=0 GVim :!start gvim.exe


"## menu {{{
" --------------------------------------------------------------------------------
" 在 vim 中，菜单是一个很强大的功能，但是需要自定义
" :h popup
" insert mode menu
"amenu ToolBar.BuiltIn21 :call me#Compile()<CR>
"amenu ToolBar.BuiltIn22 :!start subl.exe %<CR>
"amenu icon=~/vimfiles/bitmaps/main_icon.xpm ToolBar.Test :echo "test"<CR>

"添加分隔符
":menu Example.-Sep- 


"2024-07-28 01:19
"https://superuser.com/questions/11289/how-do-i-customize-the-gvim-toolbar
":tmenu ToolBar.taglist Toggle display of the Taglis
":amenu ToolBar.taglist :TlistToggle>
"tmenu 的作用是：工具提示，在鼠标悬停是显示信息
"amenu 决定图标被点击时会发生什么
"
"加上图标
":amenu icon=~/vimfiles/bitmaps/main_icon.bmp ToolBar.taglist :TlistToggle>
"在 windows 图标的格式是 bmp，在 linux 是 xpm ，图标的大小要是 18x18 的。

"使用 gimp 制作图标，导出的图标的要选中：导出图像为 BMP -> 兼容性选项 -> 不要写入色彩空间信息

" ### term_start
"term_start({cmd} [, {options}])			*term_start()*
":call term_start(['sh', '-c', 'echo hello'])

tmenu icon=~/vimfiles/bitmaps/dd.bmp ToolBar.deleteline Delete current line
amenu ToolBar.deleteline dd

tmenu icon=~/vimfiles/bitmaps/build1.bmp ToolBar.cmakebuild CMake build
amenu ToolBar.cmakebuild :call CMakeBuild()<CR>

tmenu icon=~/vimfiles/bitmaps/run.bmp ToolBar.cmakerun CMake Run
amenu ToolBar.cmakerun :call CMakeRun()<CR>

tmenu icon=~/vimfiles/bitmaps/sublime.bmp ToolBar.subl Use sublime open under the cursor of file.
amenu icon=~/vimfiles/bitmaps/sublime.bmp ToolBar.subl :!start "C:/Program Files/Sublime Text/subl.exe" %<CR>

tmenu icon=~/vimfiles/bitmaps/cmd.bmp ToolBar.runcmd Open standardalong cmd window.
amenu ToolBar.runcmd :!start cmd<CR>

tmenu icon=~/vimfiles/bitmaps/vim.bmp ToolBar.runvim Open standardalong vim window.
amenu ToolBar.runvim :!start gvim<CR>

tmenu icon=~/vimfiles/bitmaps/explorer.bmp ToolBar.explorer Open file explorer.
amenu ToolBar.explorer :!start explorer .<CR>

tmenu icon=~/vimfiles/bitmaps/newtabonly.bmp ToolBar.OnlyTab Open new tab and close all others.
amenu ToolBar.OnlyTab :call OnlyTab()<CR>

tmenu icon=~/vimfiles/bitmaps/close_buffer.bmp ToolBar.close_buffer close buffer at the beneth cursor.
amenu ToolBar.close_buffer :q!<cr>

tmenu icon=~/vimrc/bitmaps/me.bmp ToolBar.me 保存我的思考
amenu ToolBar.me :call Me()<CR>

tmenu icon=~/vimfiles/bitmaps/code-snippet.bmp ToolBar.EditSnippets edit the UltiSnips
amenu ToolBar.EditSnippets :tabnew ~/.vim/UltiSnips<CR>

function! Me()
    if !filewritable(expand("~").."/me.md")
        call writefile([''], expand("~").."/me.md", a)
    endif
state
    edit! ~/me.md
endfunction

function! OnlyTab()
    tabnew | tabonly
endfunction

"2024-07-30 00:23
"使用 Gimp 制作 bmp 图片，用于工具栏的图标
"导出的图像大小：36x36
"导出的图像格式：bmp
"导出选项：兼容选项下，选中不要保存色彩空间信息；位深为 24
"
"还是存在问题，从 vimrc 加载工具栏的图标不显示，而在启动后可以
"浪费时间，设计的有问题，不用 toolbar 了
"
"2024-07-30 11:17 最后还是解决问题了，是因为在 amenu 之前使用了 tmenu ，所以
"就不能正确的加载图标，在取消 tmenu 菜单后，就正常了，最终的原因是，要在 temnu
"中是使用图标（而只在 amenu 中使用了），而在 tmenu 后面的 amenu 不用，这样就
"可以正常显示图标了。
"

"### gvim linlin menu {{{
"tags: Lin

amenu &Lin.&Run\ code :call me#Compile()<CR>
amenu &Lin.-Spec- :
amenu &Lin.CMake\ &Build :call CMakeBuild()<CR>
amenu &Lin.CMake\ &Run :call CMakeRun()<CR>
amenu &Lin.-Spec- :
amenu &Lin.CD\ &cpp :cd $mycpp<CR>
amenu &Lin.CD\ &note :cd $mynote<CR>
amenu &Lin.-Spec- :
amenu &Lin.&Doxygen :Dox<CR>

"}}} ### gvim linlin menu

"cmake 构建
function! CMakeBuild()
    execute "normal :tabnew<CR>"
    call term_start('cmake -Bbuild')
endfunction

"cmake 运行
function! CMakeRun()
    execute "normal :tabnew<CR>"
    "call term_start('python C:\\Users\\16207\\vimfiles\\tmp\\run_qt.py')
    "call term_start(["cmd", "/k", "chch 65001", "&", "python C:\\Users\\16207\\vimfiles\\tmp\\run_qt.py"]) 
    execute "!start cmd /c python C:\\Users\\16207\\vimfiles\\tmp\\run_qt.py"
endfunction


"function! VSOpen()
"C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\IDE\devenv.exe"
"endfunction

"FUNCTION: 连接行
"---------------above line----------------------------
"---------------current line--------------------------
"RESULT:
"---------------above line----current line------------
"
"above line 简称为 a, current line 简称为 c
"
"有两情况：
"情况一：a 行为空
"  1. 删除 c 行中单词间的空格
"  2. 将 c 行中 - 替换为 _
"
"情况二：a 行不为空
"  1. 删除 c 行中单词间的空格
"  2. 将 c 行中 - 替换为 _
"  3. 将 c 行缀到 a 行后面
fun! JoinLine() 
    let cur_line = getline(".")

    let join_symbol = "_"

    "获取缩进数，在a行为空时，不拼接行，而只替换行，并保留缩进
    let indent         = match(cur_line, "\\w")
    let sub_str        = trim(cur_line)
    let sub_str        = trim(sub_str, "-", 2)
    let sub_str        = trim(sub_str, " ", 2)
    let sub_str        = substitute(sub_str, " ", "", "g")
    let sub_str        = substitute(sub_str, "-", join_symbol, "g")
    let cur_line_num   = getcurpos(".")
    let above_line     = getline(cur_line_num[1]-1)
    let is_empty_line  = match(above_line, "^\\s*$")
    if is_empty_line  == -1
        call setline(cur_line_num[1]-1, above_line..sub_str)
        call setline(cur_line_num[1], "")
        execute "normal k"
    else
        let indent_str = ""
        if indent > 0
            let indent_str = cur_line[:indent-1]
        endif
        call setline(".", indent_str..sub_str)
    endif

endfun

"inoremap <C-F> <ESC>V:s/\s//g<CR>:noh<CR>kJA


" 此种方式的调用会导致意外的结果，在光标处会产生一个0，这也就说明了
" <C-R>= 的方法不是用于这样的目的
"inoremap <C-F> <C-R>=JoinLine()<CR>

inoremap <C-F> <ESC>:call JoinLine()<CR>A
"}}} ## menu

"## 补全设置 {{{
"tags: complete, cpl
""!
"\beginmd
"查看补全的帮助 `:h ins-complete`
"
"### 补全方式
"--------------------------------------------------------------------------------""
"
"vim中有不同的补全方式，调用的快捷键是不同。不同的方式，有不同的补全文本来源。
"
" - 整行补全                    ctrl-x ctrl-l
" - 当前文件中的关键补          ctrl-x ctrl-n
" - dict(dictionary) 补全       ctrl-x ctrl-k
" - thesaurus 补全              ctrl-x ctrl-t
" - 当前的 include              ctrl-x ctrl-i
" - tag 补全                    ctrl-x ctrl-]
" - 文件名补全                  ctrl-x ctrl-f
" - 定义或宏补全                ctrl-x ctrl-d
" - 在 vim 的命令补全           ctrl-x ctrl-v
" - 用户定义的补全              ctrl-x ctrl-u
" - omni 补全                   ctrl-x ctrl-o
" - 拼写检查                    ctrl-x s 
" - 在 complete 中的关键字      ctrl-x ctrl-p
" - 停止补全                    ctrl-x ctrl-z
"   
"CTRL-Y		  Yes: Accept the currently selected match and stop completion.
"CTRL-E		  End completion, go back to what was there before selecting a
"<BS> and CTRL-H   Delete one character, find the matches for the shorter word
"            before the cursor.  This may find more matches.
"CTRL-L	     Add one character from the current match, may reduce the
"   	     number of matches.
"any printable, non-white character:
"   	     Add this character and reduce the number of matches.
"
" thesaurus 补全
" 
" thesaurus 补全类似于 dict 补全，但有些不同，dict 补全会将匹配的单词列出，而
" thesaurus 不仅会列出所有匹配项，更会将，一行的单词列出，就算不匹配。
" 
" 用户定义的补全 `:h complete-functions`                                     
" omni 补全 `:h omnifunc`
"
"\endmd

inoremap <C-]> <C-X><C-]>
"inoremap <C-F> <C-X><C-F>
inoremap <C-L> <C-X><C-L>

" 取消补全
"inoremap <C-I> <C-E>

"### thesaurus
set thesaurus+=~/vimfiles/complete/thesaurus/cpp.txt

"### dictionary
"tags: dict, 
"插入模式下 Ctrl-X Ctrl-K 触发
set dict+=~/vimfiles/complete/dictionary/cpp-std.txt
set dict+=~/vimfiles/complete/dictionary/add_to_dict_from_editing.txt
set dict+=~/vimfiles/complete/dictionary/cpp-keywords.txt
set dict+=~/vimfiles/complete/dictionary/cpp-std-header.txt
set dict+=~/vimfiles/complete/dictionary/qtbase-dict.txt
set dict+=~/vimfiles/tmp/CMakeLists.txt
set dict+=~/vimfiles/complete/cmake_command.txt
set dict+=~/vimfiles/complete/cmake_keyword.txt


"### 将当前行或选中区域保存到字典补全文件 {{{
"--------------------------------------------------------------------------------""
"将文件的部份内容追加到补全文件中
"- 选中文本
"- 执行命令行命令
":h command
"-range
"
"examples: 显示选中范围内的开始行和最后一行
"function! Cont() range
    """execute (a:firstline + 1) .. "," .. a:lastline .. 's/^/\t\\ '
    "echo a:firstline
    "echo a:lastline
    "let lastline1 = getline(a:lastline)
    "echo lastline1
    "let firstline1 = getline(a:firstline)
    "echo firstline1
"endfunction

"command! -range Cnt <line1>,<line2>call Cont()

"dictionary : CTRL_X CTRL_K
":w >> ~/vimfiles/complete/dictory/all.txt

command -nargs=0 -range AppToDict <line1>,<line2>call AppendToDict()
"command -nargs=0 -range AppToDict call AppendToDict()
"func! AppendToDict()  " 后面不加 range ，你选中多少行，就会重复调用多少次
func! AppendToDict() range
    "execute "normal :w >> ~/vimfiles/complete/dictionary/all.txt"
    "打开文件（以追加文件的方式打开）
    "获取当前行，追加至打开的文件
    "关闭文件
    let user_profile = expand("~")
    let dict_file = user_profile.."/vimfiles/complete/dictionary/add_to_dict_from_editing.txt" 
    let cur_line_str = []
    for i in range(a:firstline, a:lastline)
        call add(cur_line_str, getline(i))
    endfor
    if filewritable(dict_file)
        call writefile(cur_line_str, dict_file, "a") 
    else
        echo "File " ..dict_file.. " isn't writable."
    endif
endfunc

"}}} ### 将当前行或选中区域保存到字典补全文件


"### tags
"需要使用 ctags 程序(请先下载)
"插入模式下 Ctrl-N 触发
set tags+=D:/Qt/6.5.0/Src/widgets/tags
"set tags+=~/vimfiles/tags/tags
"set tags+=D:/user/code/practice/qt/tdesktop/tags
"set tags+=D:/Qt/Tools/mingw1120_64/lib/gcc/x86_64-w64-mingw32/11.2.0/include/c++/tags,$lin/libraries/jsoncpp/tags,$lin/libraries/include/lin/tags

"}}} ## 补全设置

"## python {{{
if &filetype == "python"
    set foldmethod=indent
endif

" 这里就根据你自己的 python 安装位置, 进行调整
if windowsversion() == "10.0"
    set runtimepath+="D:\\Programs\\Python\\Python311\\python311.dll"
    set runtimepath+=C:/Users/16207/vimfiles/bitmaps
    "set pythonthreedll="D:\\Programs\\Python\\Python311\\python311.dll"
    set pythonthreedll=D:\Programs\Python\Python311\python311.dll 
    set pythonthreehome=D:\Programs\Python\Python311
    "set pythonthreehome="D:\\Programs\\Python\\Python311"
    "colorscheme OceanicNext
else
    set runtimepath+="D:\\Users\\Programs\\Python\\Python38\\python38.dll"
    set pythonthreedll=D:\\Users\\Programs\\Python\\Python38\\python38.dll 
endif

"}}} ## python

"## Symbol {{{
"tags: symbol

"┌─────────────┐
"│             │
"└─────────────┘

"/zbf": [ "┌─────────────┐", "│             │", "├─────────────┤", "└─────────────┘", "┌", "┬", "┐", "┌", "─", "┐", "┍", "┯", "┑", "╔", "╦", "╗", "├", "┼", "┤", "│", "┼", "│", "┝", "┿", "┥", "╠", "╬", "╣", "└", "┴", "┘", "└", "─", "┘", "┕", "┷", "┙", "╚", "╩", "╝", "┏", "┳", "┓", "┏", "━", "┓", "┎", "┰", "┒", "╔", "═", "╗", "┣", "╋", "┫", "┃", "╋", "┃", "┠", "╂", "┨", "║", "╬", "║", "┗", "┻", "┛", "┗", "━", "┛", "┖", "┸", "┚", "╚", "═", "╝", "╓", "╥", "╖", "╒", "╤", "╕", "┏", "┱", "┐", "┌", "┲", "┓", "╟", "╫", "╢", "╞", "╪", "╡", "┡", "╃", "┤", "├", "╄", "┩", "╙", "╨", "╜", "╘", "╧", "╛", "└", "┴", "┘", "└", "┴", "┘", "┌", "┬", "┐", "┏", "┳", "┓", "╭", "─", "╮", "╱", "─", "╲", "┟", "╁", "┧", "┞", "╀", "┦", "│", "╳", "│", "│", "┼", "│", "┗", "┻", "┛", "└", "┴", "┘", "╰", "─", "╯", "╲", "─", "╱", "┄", "┈", "┉", "┅", "┇", "┋", "┊", "┆" ]

"}}} ## Symbol

"}}} # 自定义的设置

"# 平台相关的设置 {{{
"tags: platform

"if has('win32')
"echo "win32"
"elseif has('unix')
"echo "unix"
"elseif has ('mac')
"echo "mac"
"else
"echo "else"
"endif


"对操作系统版本的判断
"使用 windowsversion() 函数：
"版本：win11 ，结果 10.0

"}}} # 平台相关的设置

"# 自制插件的设置 {{{
"~/vimfiles/pack/MyVim/start
"~/vimfiles/pack/MyVim/record.md

"## linlin popup menu setting

if !exists("g:loaded_popupmenu")
    call linlin_popup_menu#AddMenuItem('t', "查看标签行", 'execute :tabs')
    call linlin_popup_menu#AddMenuItem('g', "Goyo", "execute Goyo")
    "call linlin_popup_menu#AddMenuItem("复制", 'execute normal gv"+y')
    "存在popup窗口不能关闭的问题
    call linlin_popup_menu#AddMenuItem('p', "粘贴", 'execute normal "+p')
    "call linlin_popup_menu#AddMenuItem('c', "进入 C++ basic 目录", 'execute cd ~/code/cpp/basic')
    call linlin_popup_menu#AddMenuItem('w', "开启换行", 'execute set wrap')
    call linlin_popup_menu#AddMenuItem('x', "编辑我的插件", 'execute tabnew ~/vimfiles/pack/MyVim/start')
    "call linlin_popup_menu#AddMenuItem("打开我的插件目录", 'execute cd ~/code/cpp/basic')
    call linlin_popup_menu#AddMenuItem("k", "查看窗口布局", 'execute echo winlayout()')
    call linlin_popup_menu#AddMenuItem("l", "在左侧添加一个宽度为 60 的窗口", 'execute call PlaceholderWindow()')
endif

"查看当前信息：
"1. pwd
"2. 历史文件
"3. 上次使用时间
"4. 本次使用持续时间

"### 得到当前时间
"nnoremap <LEADER>d :call append(line('.'), strftime('%c'))<CR>


"使用: `:h strftime` 查看相应的介绍

"- strftime
"- localtime
"    - 从 1970 年 1 月开始的秒数
"- getftime
"    - 得到指定文件的最后修改时间，从 1970 年 1 月开始的秒数
"- strptime
"    - 将指定格的字符串时间转换为 Unix 时间戳

"2024-7-27
"我安装了两个插件：
"Plug 'SirVer/ultisnips' 这个插件依赖于 python3
"Plug 'honza/vim-snippets'
"UltiSnips 提供了更方便的获取时间的方法——在编辑的时候

"## 编辑 me.vim
command -nargs=0 LMe :e $HOME/vimfiles/pack/MyVim/start/me/plugin/me.vim
command -nargs=0 LCpp :cd $linp/cpp/basic
