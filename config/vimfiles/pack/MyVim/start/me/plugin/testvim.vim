" 1. testvim#funcname
function! testvim#EchoOK()
    echo "Ok! Your test is successful!"
    call me#TestEcho()
    echo "Ok! Your test is successful!"
    " 可以调用 
    " s:funcname 这样的函数可以调用吗？
    
    "call s:testEcho1()
    "未知函数
    "去掉s:
    call testEcho1()
endfunction

" 去翻看已有的插件的源码
