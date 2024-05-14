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

" 基本容器与变量 {{{
let menu_item_shortcut = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', ]
let menu_items_count   = 0
let menu_item_name     = []
let menu_funcref       = []
let menu_display_name  = []
let menu_item_max_len  = 0
let s:idx = 0
" }}}

function! linlin_popup_menu#AddMenuItem(name, funcref)
    " 检测条目是否已存在
    let idx = index(g:menu_item_name, a:name)
    if idx != -1
        return v:false
    endif
    call add(g:menu_item_name, a:name)
    if a:funcref[0:6] == "execute"
        call add(g:menu_funcref, a:funcref[7:])
    else
        let Fn = function(a:funcref)
        call add(g:menu_funcref, l:Fn)
    endif
    let g:menu_items_count += 1
    "for i in range(g:menu_items_count)
    let display_item = "[" .. g:menu_item_shortcut[g:menu_items_count-1] .. "] " .. a:name  
    if g:menu_item_max_len < len(display_item)
        let g:menu_item_max_len = len(display_item)
    endif
    call add(g:menu_display_name, l:display_item)
    "endfor
    "echo "当前菜单条目数： " .. g:menu_items_count
endfunction
" }}}



call linlin_popup_menu#AddMenuItem('查看缓冲',       'execute :ls')
call linlin_popup_menu#AddMenuItem('查看标记',       'execute :marks')
call linlin_popup_menu#AddMenuItem('查看寄存器',     'execute :register')
 
 if !hasmapto('<Plug>PopupMenu')
    map - <Plug>PopupMenu
endif

map <Plug>PopupMenu <SID>CreateMenu
map <SID>CreateMenu :call <SID>createPopupMenu()<CR>

function! s:createPopupMenu()
    call popup_create(g:menu_display_name, 
                \ #{title: "请选择你的命令：", 
                \ pos: 'center', 
                \ border: [], 
                \ zindex: 200, 
                \ wrap: 0, 
                \ minheight: g:menu_items_count, 
                \ minwidth: g:menu_item_max_len, 
                \ cursorline: 0, 
                \ close: 'button', 
                \ resize: v:true, 
                \ drag: v:true, 
                \ filter: 's:popupMenuFilter', 
                "\ filter: 'popup_filter_menu', 
                \ padding: [0, 1, 0, 1], 
                \ mapping: 0, 
                \ })
endfunction
" }}}

" Funciton: 筛选，用于处理用户按下的按键
" Note: {{{
" id: 
"   弹出菜单的 id
" key:
"   被按下的键 
" Return:
" true:
"   键已被处理
" false:
"   键未被处理（键会在弹出菜单关闭后，留给 vim 处理） }}}
"let s:cnt = 0 
function! s:popupMenuFilter(id, key)
    if a:key == 'x'
        call popup_close(a:id, a:key)
        return v:true
"   elseif a:key == ';'
"       "let a:key = ':' a:key 是只读变量
"       call popup_close(a:id, a:key)
"       return v:false
    endif
    
    let s:idx = index(g:menu_item_shortcut, a:key)
    "echo "count: " .. s:cnt .. "    key: " .. a:key .. "  idx: " .. s:idx
    "let s:cnt += 1
    "if s:idx > 0  && s:idx < g:menu_items_count
    if !(s:idx == -1) && s:idx < g:menu_items_count
        if type(g:menu_funcref[s:idx]) == 2
            "echo "count: " .. s:cnt .. "    key: " .. a:key .. "  idx: " .. s:idx
            call g:menu_funcref[s:idx]()
        elseif type(g:menu_funcref[s:idx])  == 1
            let result_info =  execute(g:menu_funcref[s:idx])
            echo result_info
        endif
    else
        return popup_filter_menu(a:id, a:key)
        "return v:true
    endif
    call popup_close(a:id, a:key)
    return v:true
endfunction
" }}}

