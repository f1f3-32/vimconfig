
"# plug（插件）相关的设置 {{{

"## plug-vim {{{    

call plug#begin('~/.vim/plugged')

"Plug 'tribela/vim-transparent'

"Plug 'justinmk/vim-sneak'
"2024-08-13 不用了，与我的习惯相冲
"s, S 两个键都是我喜欢用的，vim-sneak
"默认会占用它们，有点不喜欢，不过换一个就行了
"有些麻烦，以后再说吧！

"Plug 'bling/vim-bufferline'
"Plug 'tpope/vim-vinegar'
"Plug 'kana/vim-textobj-user'
"Plug 'thaerkh/vim-workspace'
"Plug 'tomtom/tlib_vim'
"Plug 'shougo/vimproc.vim'
"Plug 'tpope/vim-fugitive'
"Plug 'scrooloose/syntastic'

"Plug 'neoclide/coc.nvim', {'tag': '*', 'branch': 'release'}
"要说一句实话，补全是很好的，但是用的不是很习惯，还是使用 vim
"自带的补全感觉舒服，而且还是很好用的，只要进行自定义就行，就是
"使用 dictionary、thesaurus、omni 和 tags 补全就行。

"生成 vim 启动时间的数据，然后优化启动时间
"Plug 'hyiltiz/vim-plugins-profile'


" 显示可见缓存内容的上下文，它支持非常广泛的文件类型，在查找源代码文件时非常有用。
"在大多数编程语言中，此上下文将显示您正在查看的函数，以及在该函数中可见代码周围的循环或条件。
Plug 'wellle/context.vim'
Plug 'itchyny/lightline.vim'
Plug 'zyedidia/vim-snake'
Plug 'easymotion/vim-easymotion'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'junegunn/vim-easy-align'
Plug 'luochen1990/rainbow'
Plug 'matze/vim-move'
Plug 'mechatroner/rainbow_csv'
Plug 'jiangmiao/auto-pairs'
Plug 'preservim/nerdcommenter'
Plug 'preservim/nerdtree'
Plug 'preservim/tagbar'
Plug 'simnalamburt/vim-mundo'

" 这个插件的功能就很强大了，也很实用
Plug 'tpope/vim-surround'
Plug 'morhetz/gruvbox'
Plug 'vim-scripts/DoxygenToolkit.vim'
Plug 'kien/ctrlp.vim'

Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
" 两个插件共同使用的

Plug 'elzr/vim-json'
Plug 'rafi/awesome-vim-colorschemes'
Plug 'chxuan/cpp-mode'


call plug#end()

"}}} ## plug-vim

"## 对插件进行设置 {{{
" tags: plugins setting


"### EasyAlign {{{
    vnoremap <Enter> <Plug>(EasyAlign)
    "xnoremap <Leader>g :Goyo<CR>
    xnoremap ga <Plug>(EasyAlign)
    nnoremap ga <Plug>(EasyAlign)
" }}} EasyMotion

"### rainbow

let g:rainbow_active=1

"### limelight

" 问题: unsupported color scheme. g:limelight_conceal_ctermfg required
" " 解决:https://github.com/junegunn/limelight.vim#options
" " Color name (:help cterm-colors) or ANSI code

" " Color name (:help gui-colors) or RGB color
"
" " Default: 0.5
"
" " Number of preceding/following paragraphs to include (default: 0)
"
" " Beginning/end of paragraph
" "   When there's no empty line between the paragraphs
" "   and each paragraph starts with indentation
"
" " Highlighting priority (default: 10)
" "   Set it to -1 not to overrule hlsearch

let g:limelight_priority = -1
let g:limelight_eop = '\ze\n^\s'
let g:limelight_bop = '^\s'
let g:limelight_paragraph_span = 1
let g:limelight_default_coefficient = 0.7
let g:limelight_conceal_guifg = '#777777'
let g:limelight_conceal_guifg = 'DarkGray'
let g:limelight_conceal_ctermfg = 240
let g:limelight_conceal_ctermfg = 'gray'

"### EasyMotion

"map <Leader> <Plug>(easymotion-prefix)
map <Leader> <Plug>(easymotion-prefix)
map <Leader>w <Plug>(easymotion-w)
map <Leader>r <Plug>(easymotion-b)

"### DoxygenToolkit

"Use:
":Dox
":DoxLic
":DoxAuthor
":DoxUndoc(DEBUG)
":DoxBlock
nnoremap <c-c> :Dox<cr>
let g:DoxygenToolkit_commentType          = "C++"
let g:DoxygenToolkit_briefTag_pre         = "\\brief "
let g:DoxygenToolkit_templateParamTag_pre = "\\tparam "
let g:DoxygenToolkit_paramTag_pre         = "\\param "
let g:DoxygenToolkit_returnTag            = "\\return "
let g:DoxygenToolkit_throwTag_pre         = "\\throw " " \\exception is also valid
let g:DoxygenToolkit_fileTag              = "\\file "
let g:DoxygenToolkit_authorTag            = "\\author "
let g:DoxygenToolkit_dateTag              = "\\date "
let g:DoxygenToolkit_versionTag           = "\\version "
let g:DoxygenToolkit_blockTag             = "\\name "
let g:DoxygenToolkit_classTag             = "\\class "
let g:DoxygenToolkit_authorName           = "linlin"
let g:DoxygenToolkit_licenseTag           = "My onw license"

"### workspace 

"let g:workspace_autocreate = 1
"let g:workspace_session_name = 'Session.vim'
"let g:workspace_persist_undo_history = 1

"### sneak 

let g:sneak#label = 1
" 2-character Sneak (default)
"nmap <C-f>s <Plug>Sneak_s
"nmap <C-f>S <Plug>Sneak_S
" visual-mode
"xmap <C-f>s <Plug>Sneak_s
"xmap <C-f>S <Plug>Sneak_S
" operator-pending-mode
"omap t <Plug>Sneak_s
"omap t <Plug>Sneak_S

" repeat motion
"map t <Plug>Sneak_;
"map t <Plug>Sneak_,

" 1-character enhanced 'f'
"nmap t <Plug>Sneak_f
"nmap T <Plug>Snenx_F
" visual-mode
"xmap <C-f>t <Plug>Sneak_f
"xmap <C-f>T <Plug>Sneak_F
"" operator-pending-mode
"omap t <Plug>Sneak_f
"omap t <Plug>Sneak_F

"" 1-character enhanced 't'
"nmap t <Plug>Sneak_t
"nmap T <Plug>Sneak_T
"" visual-mode
"xmap <C-f>t <Plug>Sneak_t
"xmap <C-f>t <Plug>Sneak_T
"" operator-pending-mode
"omap t <Plug>Sneak_t
"omap t <Plug>Sneak_T

"" label-mode
"nmap t <Plug>SneakLabel_s
"nmap t <Plug>SneakLabel_S

"### Goyo

" Goyo 要与 Limelight 聚和使用

"### UltiSnips 

"配置的方式，去看文档就行
"2024年08月12日
"突然就不能用了，然后搞了几天，不能正常使用，问题是 pythonthreedll
"的设置方法错了，最后找到了正确的方式：
"
"首先使用 :echo has("python3") 查看是否有 pytyon311.dll ，只有两个返回值 0, 1
"通过 :set pythonthreedll=D:\Programs\Python\Python311\python311.dll
"( 这个位置是我的 )
" 设置动态库，然后再看一遍 :echo has("python3") 返回值是否为 1

"确保 UltiSnips 和 vim-snippets 都已安装
"然后就行了！

"### lightline

let my_lightline_color = [
            \  "16color",
            \  "apprentice",
            \  "ayu_dark",
            \  "ayu_light",
            \  "ayu_mirage",
            \  "darcula",
            \  "default",
            \  "deus",
            \  "jellybeans",
            \  "landscape",
            \  "materia",
            \  "material",
            \  "molokai",
            \  "nord",
            \  "OldHope",
            \  "one",
            \  "PaperColor",
            \  "PaperColor_dark",
            \  "PaperColor_light",
            \  "powerline",
            \  "powerlineish",
            \  "rosepine",
            \  "selenized_black",
            \  "selenized_dark",
            \  "selenized_light",
            \  "selenized_white",
            \  "seoul256",
            \  "simpleblack",
            \  "solarized",
            \  "srcery_drk",
            \  "Tomorrow",
            \  "Tomorrow_Night",
            \  "Tomorrow_Night_Blue",
            \  "Tomorrow_Night_Bright",
            \  "Tomorrow_Night_Eighties",
            \  "wombat"
            \]

let g:lightline = {
            \'colorscheme' : my_lightline_color[8],
            \}

"## CtrlP
"--------------------------------------------------------------------------------"
let g:ctrlp_custom_ignore = {
            \ 'dir': '\v[\/]\.(git|hg)$',
            \ 'file' : '\v\.(exe|so|dll|zip|tart)'
            \}

let g:ctrlp_working_path_mode = 0
"let g:ctrlp_working_path_mode = 'ra'

"## 
"nnoremap <F2> :Vexplore<CR>
"inoremap <silent><expr> <Tab> coc#pum#confirm()
"inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
"inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
"inoremap <S-Alt> <Esc>:w!<cr>
nnoremap <F2> :NERDTreeToggle<CR>
nnoremap <F6> :call me#Compile()<CR>
noremap <C-/> <plug>NERDCommenterInvert
nnoremap <F9> :Tagbar<CR>
colorscheme molokai


"}}} ## 对插件进行设置

"}}} # plug（插件）相关的设置
"tags: make setting

