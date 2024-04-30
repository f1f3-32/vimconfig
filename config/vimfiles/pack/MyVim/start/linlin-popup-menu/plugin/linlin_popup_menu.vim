" 实现一个弹出菜出，能执行函数，和命令
" File: popup_menu.vim
" Author: 林林
" Since: 2024/1/4
" Last Change: 2024/1/7
" License:
" MIT License
"
" Permission is hereby granted, free of charge, to any person obtaining
" a copy of this software and associated documentation files (the
" "Software"), to deal in the Software without restriction, including
" without limitation the rights to use, copy, modify, merge, publish,
" distribute, sublicense, and/or sell copies of the Software, and to
" permit persons to whom the Software is furnished to do so, subject to
" the following conditions:
"
" The above copyright notice and this permission notice shall be
" included in all copies or substantial portions of the Software.
"
" THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
" EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
" MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
" NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
" LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
" OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
" WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


if exists("g:loaded_popupmenu")
    finish
endif

let loaded_popupmenu = 1


" 菜单项目的基本操作与容器
"--------------------------------------------------------------------------------
 
" Funcion: 创建弹出菜单  {{{

"function! s:menuCallback(id, result)
"    echo "callback"
"endfunction

" Function: 添加一个菜单条目
" Note: {{{
" name:
"   条目名
" funcref: 
"   函数名或一个 execute 命令
"   1. funcref: 函数名
"   2. execute 命令:
      " 例子: "execute normal ggVG"
      " 意思是全选 
"function! s:testEcho()
"    echo "Test Ok"
"endfunction

      

