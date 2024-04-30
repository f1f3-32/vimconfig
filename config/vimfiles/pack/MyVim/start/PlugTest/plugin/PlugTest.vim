vim9script noclear
# vim9 的防止二次加载文件时清除第一次的加载

# Vim global plugin for correcting typing mistakes                   
# Last Change:	2021 Dec 30                          
# Maintainer:	Bram Moolenaar <Bram@vim.org>        
# License:	This file is placed in the public domain. 

#if exists("g:loaded_typecorrect")   
#  finish                            
#endif                               
#g:loaded_typecorrect = 1            


#map <unique> <Leader>a  <Plug>TypecorrAdd;
# unique and Plug 是什么？
# :map-<unique>
# 如果映射已经存在，就报错

#g:mapleader = "_"
# 插件的 leader key

#if !hasmapto('<Plug>TypecorrAdd;')           
  #map <unique> <Leader>a  <Plug>TypecorrAdd; 
  #noremap <unique> <script> <Plug>TypecorrAdd;  <SID>Add 
  #<script> 唯一的标识当前脚本
#endif                                        
# 检测映射是否存在，然后进行定义，这样你可以在 vimrc 中定义如下的映射：
# map ,c <Plug>TypecorrAdd;

#def Add(from: string, correct: bool)                     
  #var to = input($"type the correction for {from}: ")    
  #exe $":iabbrev {from} {to}"                            
#enddef                                                   

#noremap <SID>Add  :call <SID>Add(expand("<cword>"), true)<CR> 

# \a -> <Plug>TypecorrAdd; -> <SID>Add -> :call <SID>Add(...)

# noremenu <script> Plugin.Add\ Correction      <SID>Add

#if !exists(":Correct")                                 
  #command -nargs=1  Correct  :call Add(<q-args>, false)
#endif                                                  
# command 可以在命令行模式调用的命令，就像 :ls 一样
# 这里是将 Add 函数添加到用户命令中


# 完整的实现
#--------------------------------------------------------------------------------
# Vim global plugin for correcting typing mistakes             
# Last Change:	2021 Dec 30                                   
# Maintainer:	Bram Moolenaar <Bram@vim.org>                 
# License:	This file is placed in the public domain.             
                                                               
if exists("g:loaded_typecorrect")                              
  finish                                                       
endif                                                          

g:loaded_typecorrect = 1                                       

iabbrev teh the 
iabbrev otehr other
iabbrev wnat want
iabbrev synchronisation
	\ synchronization 
var count = 4                                                  

if !hasmapto('<Plug>TypecorrAdd;')                             
  map <uniqe> ,s  <Plug>TypecorrAdd;                   
endif                                                          

noremap <unique> <script> <Plug>TypecorrAdd;  <SID>Add         
noremenu <script> Plugin.Add\ Correction      <SID>Add         
noremap <SID>Add  :call <SID>Add(expand("<cword>"), 1)<CR>  

def Add(from: string, correct: bool)                           
  var to = input("type the correction for " .. from .. ": ")   
  exe ":iabbrev " .. from .. " " .. to                         
  if correct | exe "normal viws\<C-R>\" \b\e" | endif          
  count += 1                                                   
  echo "you now have " .. count .. " corrections"              
enddef                                                         

if !exists(":Correct")                                         
  command -nargs=1  Correct  call Add(<q-args>, false)         
endif                                                          

# 文档中的这个例子有点难以理解，还是自己一步步的写一遍吧！
# 映射不能使用的原因是：之没有映射的时候运行过了，这个文档不会重复运行，所以修改后不能运行了
# 所以，就是自己还是不够专注，结果浪费了时间。
