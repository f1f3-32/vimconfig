"## map plugin cmd {{{
""--------------------------------------------------------------------------------
"" 映射命令 
""" hasmapto 防止重复映射

"没有什么用，还不如直接在 vimrc 中进行映射
"if !hasmapto('<Plug>MeCompileRun')
    "map <Leader>f <Plug>MeCompileRun
"endif

"map <Plug>MeCompileRun <SID>CompileRun
"map <SID>CompileRun :call me#Compile()<CR>          

if !hasmapto('<Plug>MeDivider')
    map <Leader>a <Plug>MeDivider
endif

map <Plug>MeDivider <SID>SIDDivider
map <SID>SIDDivider :call me#Divider()<CR>

if !hasmapto('<Plug>MeImpl')
    map <Leader>d <Plug>MeImpl
endif

map <Plug>MeImpl <SID>Implement
map <SID>Implement :call me#CreateImplement()<CR>


if !hasmapto('<Plug>CreateClass')
    map <Leader>c <Plug>GenerateDoxygen
endif

map <Plug>GenerateDoxygen <SID>SIDGenerateDoxygen
map <SID>SIDGenerateDoxygen :call me#GenerateDoxygenComment()<CR>

if !exists(":cdir")
    command -nargs=0 Cdir call me#ChangeShellDir()
endif

"}}}

"## 编译源文件 {{{
"""     根据文件类型编译源文件，有新需求需要自己扩展
function! me#Compile()
    execute "w"
    let winid = 0
    if &filetype == 'c'
        "if !isdirectory('build')
            "execute "!mkdir build"
        "endif
        "execute "!gcc % -o ./build/%< && ./build/%<"
        execut 'start cmd /c "gcc % && a.exe && pause"'
    elseif &filetype == 'cpp'
        if has('win32')
            execute "!start cmd /c g++ % -std=c++20 & a.exe & echo. & echo _____________________ &pause "
        elseif has('unix')
            execute "!g++ % -std=c++20 && ./a.out "
        endif
        "echo. 逗号前不要有空格，作用是换行
        "出错的话，cmd 窗口会直接关闭
    elseif &filetype == "java"
        execute "!start java %"
    elseif &filetype == "tex"
        execute "!start xelatex % && okular %<.pdf"
    elseif &filetype == "python"
        execute "!start python %"
    elseif &filetype == "qml"
        execute "!start qml %"
    elseif &filetype == "sh"
        execute "!./%"
    elseif &filetype == "vim"
        execute "source %"
    endif
endfunction
"}}}

"## delimate {{{
""" 给文件添加一个分隔线
"""     可以根据文件类型进行注释,但自动在下一行添加注释的功能会造成影响
function! me#Divider()
    let filename  = split(expand('%'), '/')
    if &filetype == 'c'|| &filetype == 'cpp' || &filetype == 'java'
        execute "normal o\<Esc>80a-\<Esc>"
    elseif filename[-1] == 'CMakeLists.txt' || &filetype == 'python'
        execute "normal o\<Esc>a#\<Esc>80a-\<Esc>"
    elseif &filetype == 'py'
        execute "normal o\<Esc>a#\<Esc>80a-\<Esc>"
    elseif &filetype == 'vim'
        execute "normal o\<Esc>a\"\<Esc>80a-\<Esc>"
    else
        execute "normal o\<Esc>80a-\<Esc>"
    endif
endfunction
"}}}

"## change dir {{{
""" 改变 vim 的目录
"""     依据当前打开文件的路径，将 vim 的路径改为相应的路径
""" TODO: 功能待完成
function! me#ChangeShellDir()
    " 获取当前文件名
    let curname=expand("%")
    " 获取路径长度
    let chang=0
    for i in curname
        let chang += 1
    endfor

    " 获取最后一个分隔符 /
    let i=0
    let j=0
    while i < chang 
        if curname[i] == "/"
            let j=i
        endif 
        let i += 1
    endwhile
    
    " 改变路径
    execute "cd! "..curname[0:j]
    pwd
endfunction
"}}}

"## extra {{{
"""提取操作
function! s:extraImplement(decl_line, class_name)
    " decl line
    "====================================================
    let l:decl_line = trim(a:decl_line)
    let l:left_parenthese = match(l:decl_line, "(")
    let l:right_parenthese = match(l:decl_line, ")")

    " 提取参数
    "====================================================
    "args : and after extra args, delete default value

    let l:arg_part = trim(l:decl_line[l:left_parenthese+1:l:right_parenthese-1])
    
    let l:comma = []
    let l:equal_sign = []
    for i in range(strlen(l:arg_part))
        if l:arg_part[i] == ","
            call add(l:comma, i)
        elseif l:arg_part[i] == "="
            call add(l:equal_sign, i)
        endif
    endfor
    let l:arg_list = []
    "没有参数的情况
    "empty() : is empty return 1; otherwise return 0;
    if strlen(l:arg_part) == 0
        echo "没有参数, 参数长度为：" .. strlen(l:arg_part)
    else
        "一个参数,没有默认值
        if empty(l:comma) && empty(l:equal_sign)
            call add(l:arg_list, l:arg_part)
        "一个参数,有默认值
        elseif empty(l:comma) && !empty(l:equal_sign)
            call add(l:arg_list, trim(l:arg_part[0:l:equal_sign[0]-1]))
        "多个参数
        elseif !empty(l:comma) && !empty(l:equal_sign)
            let l:start = 0
            let l:end = 0
            for i in range(len(l:comma))
                let l:end = l:comma[i]
                call add(l:arg_list, trim(l:arg_part[l:start:l:end-1]))
                let l:start = l:end+1
            endfor      
            call add(l:arg_list, trim(l:arg_part[l:start:]))
        endif
    endif
    "处理参数的等号
    if !empty(l:equal_sign)
        for i in range(len(l:arg_list))
            let l:cur_arg = l:arg_list[i]
            for j in range(strlen(l:cur_arg))
                if l:cur_arg[j] == "="
                    let l:arg_list[i] = trim(l:cur_arg[0:j-1])
                endif
            endfor
        endfor
    endif

    "构造函数的情况
    "====================================================

    if match(l:decl_line, a:class_name) > -1
        let l:decl_line_info = {
            \ "return type" : "",
            \ "function name" : a:class_name,
            \ "arg list" : l:arg_list,
            \ }
        return l:decl_line_info
    endif

    "return type
    "====================================================
    "普通函数有返回类型，构造函数与析构函数没有，还有，在前面的修饰符有很多，如 static, constexpr, dllexport, inline 等等, 后面也有很多，不过后面的可以暂时不管


    "提取修饰符
    "====================================================
    let l:befor_part = trim(l:decl_line[:left_parenthese-1])
    let l:spaces = []
    let l:end = matchend(l:befor_part, "\\s\\+")
    while l:end != -1
        call add(l:spaces, l:end)
        let l:end = matchend(l:befor_part, "\\s\\+", l:end)
    endwhile
    let l:speficier_list = []
    let l:start = 0
    let l:end = 0
    for i in l:spaces
        let l:end = i-2
        call add(l:speficier_list, trim(l:befor_part[l:start:l:end]))
        let l:start = i
    endfor
    call add(l:speficier_list, trim(l:befor_part[l:spaces[-1]:]))
    let l:start = 0
    let l:end = 0


    " 从修饰符中提取返回类型                                                     
    let l:return_type = l:speficier_list[-2]
    "let l:idx = 0
    "let l:return_type = ""
    "if a:decl_line_type == 0
    "    let l:start = 0
    "    let l:idx = match(l:decl_line, "\\s\\+")
    "    let l:return_type = strcharpart(l:decl_line, l:start, l:idx-l:start)
    "endif

    "func name
    "====================================================
    let l:func_name = l:speficier_list[-1]
    "let l:start = l:idx
    "let l:idx = match(l:decl_line, "(")
    "let l:func_name = trim(strcharpart(l:decl_line, l:start, l:idx-l:start))
    

    " 返回一个包含正确信息的字典
    "====================================================
    let l:decl_line_info = {
        \ "return type" : l:return_type,
        \ "function name" : l:func_name,
        \ "arg list" : l:arg_list,
        \ }
    return l:decl_line_info
endfunction
"}}}

"## create implemental {{{
""" 创建实现，依据 h 文件的声明，在 cpp 文件创建实现，另一种情况，文件是 hpp
""" 类型，则在 hpp 文件中创建
""" 
""" class class_name [:] [public|private|protect] [father_class_name]
""" {
""" };
function! me#CreateImplement()
    "检测是否在 h 文件中
    "====================================================
    " 对 h 文件的检测结果是 cpp，自己实现吧！
    let l:ftype = strcharpart(expand("%"), match(expand("%"), "\\.h")+1)
    if l:ftype != "h"
        "echo "The file's type is " .. l:ftype
        return
    endif

    "提取类名，以及类名所在的行数
    "====================================================
    let l:class_name_line_num = search("^\\s*\\<class\\>", 'bn', line("0"))
    "let l:class_name_line_num = find_class_name()
    let l:class_name = ""
    if l:class_name_line_num
        let l:class_name_line = trim(getline(l:class_name_line_num))
        let l:start = match(l:class_name_line, "\\(\\s\\+\\)\\@<=\\w\\+")
        " \\@<= 零宽匹配，不计入最终的首位置
        let l:idx = match(l:class_name_line, ":")
        let l:class_name = trim(l:class_name_line[l:start : l:idx-1])
    else
        echo "没有类的声明！"
        return
    endif

    " 置零以不影响之后的使用
    let l:start = 0
    let l:idx = 0

    " save cursor postion, and after the info extra restore cursor position
    "====================================================
    let l:old_cursor_pos =  getcurpos()

    "从声明行提取信息
    "====================================================
    "decl's type:
        "1. void abc(int abc=32, ...) [const|noexcept...];
        "2. explicit classname(int abc...);
        "3. classname(int abc...);

    "def:  void Class::abc(int abc, ...) {}
    " extra info from the  decl line: return type; func-name; args(remove
    " default value); trailing's const ? no!

    "声明行的类型：
    "1. 构造函数
    "2. 析构函数
    "3. 正常函数
    "4. 操作符重载

    let l:decl_line = trim(getline("."))
    let l:decl_line_info = s:extraImplement(l:decl_line, l:class_name)

    "提取确定位置所需的信息
    "====================================================
    "当前位置，前面声明的行，后面声明的行
    "从声明行向后找，直到类声明行
    call setpos(".", l:old_cursor_pos)
    let l:repeat_line_num = 0
    let l:above_decl_line_num = search("^\\s*.*(.*).*;", "b", l:class_name_line_num)
    if l:above_decl_line_num > 0
        let l:above_decl_line_func_name = s:extraImplement(getline(l:above_decl_line_num), l:class_name)["function name"]
        let l:repeat_line_num = 1
        let l:above_decl_line_num = search("^\\s*.*(.*).*;", "b", l:class_name_line_num)
        while l:above_decl_line_num > l:class_name_line_num
            if match(getline(l:above_decl_line_num), l:above_decl_line_func_name) > -1
                let l:repeat_line_num = l:repeat_line_num + 1
                let l:above_decl_line_num = search("^\\s*.*(.*).*;", "b", l:class_name_line_num)
            else
                break
            endif
        endwhile
    endif
    call setpos(".", l:old_cursor_pos)

    "如果是 h + cpp 组合，则切换到 cpp 文件，创建定义
    "如果是 hpp ，则在类的后面创建实现
    "====================================================
    "通过位置信息确定插入的位置，通过声明信息创建定义字符串
    "声明，定义，实现
    call me#SwitchToSource()
    let l:combine_func_name = l:class_name .. "::" .. l:decl_line_info["function name"]    
    let l:combine_next_func = l:class_name .. "::\\w\\+"
    let l:arg_list = ""
    for i in range(len(l:decl_line_info["arg list"]))
        let l:arg_list = l:arg_list .. l:decl_line_info["arg list"][i] .. ", "
    endfor

    if !empty(l:arg_list)
        let l:arg_list = l:arg_list[:-3]
    endif
    let l:define_func_arg_part = ""
    let l:deconstructor_flag = match(l:decl_line, "\\~")
    if  l:deconstructor_flag > -1
        let l:define_func_arg_part = l:class_name.."::~"..l:class_name.."("..l:arg_list..")"
    else
        let l:define_func_arg_part = l:combine_func_name .. "(" .. l:arg_list .. ")"
    endif

    if l:decl_line_info["function name"] == l:class_name 
        let l:define = [l:define_func_arg_part, "{", "", "}", ""]
    else
        let l:define = ["", l:decl_line_info["return type"] .. " " .. l:define_func_arg_part, "{", "", "}"]
    endif
    
    execute "normal gg"
    
    if l:repeat_line_num == 0
        execute "normal G"
        call appendbufline("", line("$"), l:define)
    else
        while l:repeat_line_num > 0
            let l:append_line_num = search("\\<" .. l:combine_func_name, "W", line("$"))
            let l:repeat_line_num = l:repeat_line_num - 1
        endwhile

        let l:append_line_num = search("\\<" .. l:combine_next_func, "W", line("$"))
        if l:append_line_num == 0
            execute "normal G"
            call appendbufline("", line("$"), l:define)
        else
            let l:append_line_num = search("}", "bn", line("0"))
            call appendbufline("", l:append_line_num, l:define)
        endif
    endif
    execute "normal gg"
    if l:deconstructor_flag > -1
        call search(l:class_name .. "::\\~" .. l:class_name, "W", line("$"))
    else
        call search(l:define_func_arg_part, "W", line("$"))
    endif
    execute "normal 0jjlll"
endfunction
"}}}

"## code snippet {{{
""" 代码片段
"""     通过插入横式的快捷键映射，可以使用选择代码片段
"""     补全，通过已输入的单词进行补全
func! me#MySnippets()
    " 读取文件中内容，作为代码片段
    let mylist = [
                \ "cout << << endl;", 
                \ "#include <>", 
                \ "printf(", 
                \]
    
    call complete(col('.'), mylist)
    return ''
endfunc
"}}}

"## generate define {{{
""" 将指针的声明改变为定义
""" 通过定义完行调用
function! me#GenerateDefine()
    let str_nums = input("GenerateDefine :")
    " 输入2，会执行3次，要减一
    let nums = 0
    if str_nums != ""
        let nums = str2nr(str_nums) 
    else
        let nums = 0
    endif
    if nums > 0
        let nums = nums - 1
    endif

    "echo nums
    let cur_line = line(".")
    for i in range(0, nums)
        execute "normal 0evb\"ayvexxxA\b = new \<C-R>a();\ej"
    endfor
    call cursor(cur_line, 0)
    execute "normal f)i"
    "execute "normal :".."cur_line"<cr>"
endfunction
"}}}

"## doxygen comment {{{
""" 插入 doxygen 的注释
""" 提取声明行的信息，据依生成相应的注释
function! me#GenerateDoxygenComment()
    "let class_name_line_num = search("\\s*\\w+\\s\\+\\w\\+::", "nbW", line("0"))
    "let class_name = ""
    "if class_name_line_num
        "let class_name_line = getline(class_name_line_num) 
        "let class_name_line = class_name_line[match(class_name_line, "\\s\\+"):]
        "let class_name = class_name_line[match(class_name_line, "\\w"):match(class_name_line,":")] 
    "else
        "let class_name_line_num = search("class")
        "if class_name_line_num
            "let class_name_line = getline(class_name_line_num)
            "let class_name_line = class_name_line[match(class_name_line, "\\s\\+"):]
            "let class_name = class_name_line[match(class_name_line, "\\w"):match(class_name_line,"\\s")] 
        "endif
    "endif
    "let decl_line = getline(".")
    "let decl_line_info = s:extraImplement(decl_line, class_name)
    "let comment_lines = ["/// \\brief"]
    "let arg_list = decl_line_info["arg list"]
    "for i in arg_list
        "call add(comment_lines, "/// \\param " .. i)
    "endfor
    "call add(comment_lines, "/// \\return " .. decl_line_info["return type"])

    let cur_line = getline(".")
    let match_goal = match(cur_line, ";")
    if match_goal > 0
        execute "normal A ///< "
    else
        let cur_line = getline(".")
        let spaces = ""
        for i in cur_line
            if i == " " || i == "\t"
                let spaces = spaces .. " "
            else
                break
            endif
        endfor
        let brief = "/// \\brief "
        let param = "/// \\param "
        let return1 = "/// \\return "
        let comment_lines = [
                    \ spaces .. brief, 
                    \ spaces .. param, 
                    \ spaces .. return1, 
                    \]
        call append(line(".")-1, comment_lines)
        call cursor(line(".")-3, 12)
    endif
endfunction
"}}}

"## create new file use cursor under text {{{
""" 使用选中的文件新建一个文件
""" TODO: 让用户输入文件后缀
function! me#NewFile()
    "let wordUnderCursor = expand("<cword>")
    execute "y"
    let select_text = getreg("a")
    execute ":new " .. select_text
endfunction
"}}}

"## C++ code sinppet {{{
""" 新 C++ 文件的模板
function! me#CppTmp()
    let cppfile_temp = [
                \ '/*******************************************************************************', 
                \ ' * Author:   lin', 
                \ ' * Since:    2024/3/11 7:23:18', 
                \ ' * License:  ', 
                \ ' * Descript: ', 
                \ ' ******************************************************************************/', 
                \ '', 
                \ '#include <iostream>', 
                \ '#include <string>', 
                \ '#include <lin/common.hpp>', 
                \ '', 
                \ 'using namespace std;', 
                \ '', 
                \ 'int main()', 
                \ '{', 
                \ '    ', 
                \ '    return 0;', 
                \ '}']
    
    call append('0', cppfile_temp)
    call cursor(16, 4)
endfunction
"}}}

"## switch to source {{{
let s:switch_file_flag = 0
""" 在 cpp 与 h 文件中切换
""" 在光标在 h
""" 若 cpp 没有打开，在新窗口中打开 cpp
""" 若 cpp 已经打开，光标跳转到已打开的 cpp
function! me#SwitchToSource()
    let file_type = expand("%:e")
    if s:switch_file_flag
        if file_type == "h"
            drop %<.cpp
            return
        endif
        drop %<.h
        return
    endif

    if file_type == "h"
        vnew %<.cpp
        let s:switch_file_flag = 1
    elseif file_type == "cpp"
        vnew %<.h
        let s:switch_file_flag = 1
    else
        echo "不是 C++ 文件！"
    endif
endfunction
"}}}