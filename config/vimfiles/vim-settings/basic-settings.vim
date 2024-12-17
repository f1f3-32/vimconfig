"  _       _           _                   _                           
" | |     (_)  _ __   ( )  ___    __   __ (_)  _ __ ___    _ __    ___ 
" | |     | | | '_ \  |/  / __|   \ \ / / | | | '_ ` _ \  | '__|  / __|
" | |___  | | | | | |     \__ \    \ V /  | | | | | | | | | |    | (__ 
" |_____| |_| |_| |_|     |___/     \_/   |_| |_| |_| |_| |_|     \___|
"
"================================================================================
"                H                                                           H  
"             HHHHHH                                 HHHHHHH                HH  
"           HHH    HH                              HHH     HH               HH  
"          HH       HH                            HHt       HH             HH   
"         HH         HE                          HH         HH             H    
"        HH          HH                         HH           H            HH    
"       HH            Hi                       HH            H            H     
"      HH             HH                      HH             H           HH     
"     HH               HH                    HH             iH          HH      
"    HH                iH                  WHH              HH         HH       
"   HH                  HH                HHL               HH        HH        
"  HH                    HH             HHH                 jH       HH         
" HH                      HHH.        HHHW                   H     HHH          
" HW                        HHHHHHHHHHHt                     HHHHHHHW           
"HH                             iHE                            ,H,              
"================================================================================
" 时间：2024年7月26日
" vim 的配置，用标记折叠的方式组织起来，感觉很好


"# 基础设置（没有任何依赖项） {{{
"tags: basic setting

"查看选项的具体效果，请使用 `:help <option-name>`

"## option 设置 {{{

"autoload-plugin
"packloadall          " 加载所有插件
"silent! helptags ALL " 为所有插件加载帮助文档
"noh                  "清楚高亮显示
set hlsearch            "高亮‘/’搜索到的匹配项

filetype plugin on
filetype indent on   " 根据文件类型自动缩进
filetype on
set fileencodings=utf-8,gbk

"### gui options {{{
    
"set showtabline=1
"set guioptions-=T
"set guioptions-=m

"取消菜单、工具栏的显示
"set guioptions=
set guifont=AnonymicePro_Nerd_Font_Mono:h16
set laststatus=2

"https://juliankay.com/development/setting-up-vim-to-work-with-powershell/
set shell=pwsh
set shellcmdflag=-Command
"set guifont=Lucida_Console:h18
"set guifont=Courier_New:b:h16


let m_show_gui = v:false

"""Function: (隐藏/显示)菜单、工具栏的显示
function! SwitchGui()
    if g:m_show_gui
        let g:m_show_gui = v:false
        set guioptions-=m
        set guioptions-=T
    else
        let g:m_show_gui = v:true
        set guioptions+=m
        set guioptions+=T
    endif
endfunction


"}}} ## gui options

set textwidth=80       " 限制一行的长度，不错的功能
"set backspace=2        " 修正终端上的退格键 Backspace 的行为
"set softtabstop=4
"set relativenumber     "相对行号
"set paste              " 开启这个选项，复制进来的文本的换行符就不会乱
"set cindent            " C 语言的缩进
set noswapfile
set nobackup
set noundofile
set virtualedit=all 
set scrolloff=5     
set t_Co=256        " 开启 256 色

set foldlevel=3
set foldmethod=marker
"set cursorline
"set cursorcolumn

set syntax=on       " 开启语法高亮
set backspace=3
set sidescroll=10       " 自动的滚动文本，当移动的文本没有显示时
set shiftwidth=4        " 用于自动缩进的空格数量
set expandtab           " 将制表符 Tab 展开为空格，这对于 Python 尤其有用
set tabstop=4           " tab 的空格数量
set number              " 显示行号
set nowrap
set mouse=a          " 开启鼠标，默认是不能使用鼠标的
set autoindent " 开启自动缩进
"set iminsert=2     " 在 gvim 中存在很大的问题——我使用的是 rime 的郑码，进入
"insert mode 会导致输入法变为郑码，但我想用的是英文，因为，我用 vim
"是为了写代码。使用这个选项，不如直接使用 windows 的输入切换方式。

"}}} ## option 设置

"## runtimepath 路径 {{{

"查看当前的 runtimepath
set runtimepath+=~\.vim\UltiSnips
set runtimepath+=~\.vim

"}}} ## rumtimepath 路径

"## mapping {{{

"### leader key {{{
"let mapleader = "\\"
let mapleader = "\<space>"
"let mapleader = " "
nnoremap <LEADER>z ZZ
"nnoremap <LEADER>v :Goyo<CR>
nnoremap <LEADER>t <c-w>T
nnoremap <LEADER>c :!start cmd<CR>
nnoremap <LEADER>o  :tabnew $MYVIMRC<CR>
nnoremap <LEADER>ms :set foldmethod=syntax<CR>
nnoremap <LEADER>mr :set nornu<CR>
nnoremap <LEADER>mo :browse oldfiles<CR>
nnoremap <LEADER>q :
nnoremap <Leader>g :call SwitchGui()<CR>
nnoremap <Leader>h <C-W>h
nnoremap <Leader>j <C-W>j
nnoremap <Leader>k <C-W>k
nnoremap <Leader>l <C-W>l
inoremap <C-D> <ESC>:call CopyLine_InsertMode()<CR>a

"}}}  leader key

"normal mode
"--------------------------------------------------------------------------------
"function key
nnoremap <F3> :tabnew<CR>
nnoremap <F7> :w<CR>
nnoremap <F8> <C-U>
nnoremap <F10> :wqa<CR>
"nnoremap <LEADER>mn :set nu<CR>
"nnoremap <LEADER>md :tabnew $HOME/AppData/Local/nvim/pack/plugins/start/me<CR>

"insert mode
""--------------------------------------------------------------------------------
inoremap <F2> <CTRL-E>
inoremap <F9> <Esc>

inoremap <c-q> <Esc>:
"inoremap <c-s> <esc>:w<cr>
"inoremap <C-L> <C-X><C-L>
"inoremap <C-D> <C-X><C-D>
"inoremap <C-F> <C-X><C-F>
"inoremap <C-]> <C-X><C-]>



"g-prefix mode
"-------------------------------------------------------------------------------
"使用 :h g 
"查看默认的映射
nnoremap go :call OnlyTab()<CR>
nnoremap cx :call CopyLine()<CR>
nnoremap <M-o> <C-W>o
inoremap <M-j> <ESC>
"nnoremap <Space> <C-d>
nnoremap <M-w> <C-w>
nnoremap <M-d> <C-d>
nnoremap <M-u> <C-u>
inoremap <M-n> <C-n>
inoremap <M-p> <C-p>
nnoremap <c-q> :
"nnoremap <c-v> <c-q> "与终端中的快捷键冲突
nnoremap <C-n> :bel vnew<cr>
nnoremap <c-s> :w<cr>

"}}} ## mapping

"## autocmd : au {{{

"au! BufNewFile *.cpp,*.h,*.hpp setlocal foldmethod=syntax
"au! BufRead *.cpp,*.h,*.hpp setlocal foldmethod=syntax
au! BufRead *.ixx set filetype=cpp
au! BufRead *.md set wrap

"}}} ## autocmd

"## abbreviations {{{

"iab ce std::cout <<  << std::endl;<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left> 
"iab ff for(int i = 0; i < n; ++i)<CR>{<CR><SPACE><SPACE><SPACE><SPACE>
"iab rr std::random_device rd;<CR>std::uniform_int_distribution dist(0, 10);
 
"}}} ## abbreviations

"## colorscheme {{{
"tags: cs, color

set tgc
hi Normal guibg=NONE 
" 在 windows terminal 上，可以是背景色变为透明。


"}}} ## colorscheme

"## 自定义状态栏 {{{

"set statusline=[%n]%1*%F%=%0*%2*%l,%c\ %p%%%0*\|ascii=%b,hex=%B%{((&fenc==\"\")?\"\":\"\ \|\ \\".&fenc)}\ \|\ \%{$USER}\ @\ %{hostname()}\    
"set statusline=[%n]\ %#HIComment%F%=\ \|\ %l,%c\ %p%%\ \|\ ascii=%b,hex=%B%{((&fenc==\"\")?\"\":\"\ \|\ \\".&fenc)}\ \|\ \%{$USER}\ @\ %{hostname()}\     " 没有效果
"set statusline=[%n]\ %f%m%r%h\ \|\ \ \ \|%=\|\ %l,%c\ %p%%\ \|\ ascii=%b,hex=%b%{((&fenc==\"\")?\"\":\"\ \|\\".&fenc)}\ \|\ \%{$USER}\ @\ %{hostname()}\
"set statusline=[%n]\ %f%m%r%h\ \|\ \ pwd:\ %{CurrentDir()}\ \|%=\|\ %l,%c\ %p%%\ \|\ ascii=%b,hex=%b%{((&fenc==\"\")?\"\":\"\ \|\\".&fenc)}\ \|\ \%{$USER}\ @\ %{hostname()}\

"}}} ## 自定义状态栏

"## register {{{

" 清空寄存器
"let @a ="" 

"}}} ## register

"}}} # 基础设置


"# 自定义的函数（并不是依赖项） {{{

"保存当前光标位置
"复制行
"进入插入模式

"Function: 向下复制行(插入模式)而不改变光标位置
function! CopyLine_InsertMode()
    let l:old_cursor = getcursorcharpos()
    execute "normal vYp"
    call setcursorcharpos(l:old_cursor[1]+1, l:old_cursor[2])
endfunction

"Function: 向下复制行而不改变光标位置
function! CopyLine()
    let l:old_cursor = getcursorcharpos()
    execute "normal vYp"
    call setcursorcharpos(l:old_cursor[1]+1, l:old_cursor[2])
endfunction

"Function: 使窗口位于中间，并打开顶部打开一个预览窗口
function! PlaceholderWindow()
    "TODO：通过窗口ID在监一个以缓冲是否启用切分视图，在三个窗口的任意一个关闭后，标记为未启用；
    "wincmd T
    let winid = win_getid()

    " 创建垂直窗口
    "vnew

    vsplit

    " 调整当前窗口的大小
    vertical resize 80
    call win_gotoid(winid)

    "创建当前窗口的水平副本
    split
    resize 10
    call win_gotoid(winid)
endfunction

"Function: C++ 插入预防宏
function! Ifndef()
    let name = input("请输入宏名：")
    if empty(name) == 1
        return
    endif
        let macro_name = toupper(name) .. "_H_"
        let content = [
                    \ "#ifndef " .. macro_name,
                    \ "#define " .. macro_name,
                    \]
        call append(line("0"), content)
        call append(line("$"), "#endif // " .. macro_name)
endfunction

"Function: 将包含网址的行，变为 markdown 超链接格式
function! MDLink()
    execute "normal I[](\<Esc>A)\<Esc>0a"
endfunction

command -nargs=0 MDLink call MDLink()


"### 中文输入法问题 {{{

"https://blog.51cto.com/u_15273875/3858820
":help iminsert
"if has('multi_byte_ime')
    ""没有开启 IME 时的光标背景色
    "hi Cursor guifg=bg guibg=Orange gui=NONE
    ""开启 IME 时的光标背景色
    "hi CursorIM guifg=NONE guibg=Skyblue gui=NONE
    ""关闭 vim 的自动切换 IME 输入法（插入模式和正常模式）
    "inoremap <silent> <ESC> <ESC>:set iminsert=0<CR>
    ""set imi=2 
"endif


"if has('gui_running')
  "set imactivatekey=C-space  
  "inoremap <ESC> <ESC>:set iminsert=2<CR>
"endif


"2024年07月23日
"这个中文输入法的问题没有最完美的解决方法，其实现在这样的效果是可以的，所以，不要纠结了！
"操作系统：windows11
    "所使用的输入法：rime
        "默认情况下：输入法被禁用
        "在 nromal 模式下开启或在 insert 模式下开启：从 normal 进入 insert
        "，输入法会存在，退出 insert
        "，输入法会禁用，再次进入，输入法会开启（以rime的英文模式退出，还是中文模式退出，都会开启）.
    "所使用的输入法：sougou
        " 使用感受就是最完美的。

"2024年11月28日
" 并不好用，不过也不纠结了，中文输入法的问题是天生的缺陷，在 windows terminal 中关于中文输入法的问题还可以接受，不过在 gvim 中就有一点难受，总的来说，不值得纠结——因为纠结就是在浪费生命。

"}}} ### 中文输入法问题

"}}} # 自定义的函数

