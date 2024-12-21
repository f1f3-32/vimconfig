# 使用方法 {{{

`tags: use, usage, use vim, use method`

2024-07-28 01:40

本文件使用标记折叠方法组织内容

TODO:

- popup windows
  - display vim session list and could be use number selecte
  - display command list, like the lazy-nvim's list
- organization my pulgins
  - select license
  - make it github repo

## 例子 {{{

### 折叠的使用方法 {{{

"--------------------------------------------------------------------------------
`tags: fold, use fold`

`:set foldmethod`
查看折叠方法

`:set foldmethod*marker`

通过帮助系统查看有关折叠的快捷键：
`:h z`

作者常用的（在 normal 模式下使用）:

```
zM      递归的折叠所有部分
zR      展开所有折叠的部分（包括递归）
zm      增加一层(:h foldlevel)折叠
zr      减去一层折叠
zc      打开光标下的折叠
za      打开/关闭光标下的折叠
zj      去到下一个折叠上
zk      去到上一个折叠上
```

}}} ### 折叠的使用方法

### 获取指定目录下的所有文件的路径 {{{

"--------------------------------------------------------------------------------
`tags: path, dir`

#### windows {{{

CMD

 `:r! dir /b /s src/`"
  
    选中读取的内容

 `:'<,'>sort /.*\.h/  r`

 依据文件的后缀进行排序
##### 开头为 " 的行排在一起

`:'<,'>g/"Plug/move 165`

}}} #### windows

}}} ### 获取指定目录下的所有文件的路径

}}} ## 例子

### 查找替换 : substitute, find, replace {{{

"--------------------------------------------------------------------------------
2024-07-28 01:16

#### 替换多个**文件**中指定文本

```
被替换者: test_123

替换者: new_123

在同一个目录<dir>中的所有 h 文件中

:cd <dir>
:args *.h
:argdo %s/test_123/new_123/ge | update
上面一行命令的解释：
argdo 对所有在 args 中的文件执行后面的命令
%s/被替换者/替换者/ge
g 整个文件的所有符合条件者都被替换
e 没有找到的情况，不报错
| 用于执行多个命令
update 保存对文件执行的操作（只对已经修改的缓冲有效）
```

#### 替换换行符

"--------------------------------------------------------------------------------

`tags: newline, dos, crlf, \r\n, \n`

`:%s/\n/ /g`

#### 包含 .md 的目标被排除

"--------------------------------------------------------------------------------

`^\w\+.*\.\(md\)\@!`

解释：找到所有文件类型不为 md 的行

```
examples:
abc.md  排除
abc.txt 包含
test.cpp 包含
```
}}} ### 查找替换

## option 的设置

"--------------------------------------------------------------------------------

`set imd`
是一个布尔选项，上面一行表示开启

`set noimd`
上面一个表示取消

## 缓冲设置

### 创建一个临时缓存

"--------------------------------------------------------------------------------

```setlocal bufhidden=nofile
setlocal buftype=nofile
setlocal noswapfile
file temp
```
缓存不可保存，可以退出，在退出程序时，内容将丢失。

## pwsh 使用方法

--------------------------------------------------------------------------------""
找到指定目录下的所有 cpp 文件，然后从中找到包含字符串 include 的文件
`r!get-childitem -path $linp\cpp\basic\*.cpp | select-string -pattern "include"`

## 将行移动到指定的标记位置

`:move 'a`

## vim 滚屏和跳转

`https://www.zhaixue.cc/vim/vim-jump.html`

如果你想进行长距离的光标移动，使用光标移动命令就太耗时了，此时可以直接使用vim滚屏跳转命令，直接在屏幕中移动

```
xG：跳转到指定的第 x 行，G 移动到文件按末尾，
``：（2 次单引号)返回到跳转前的位置
gg: 移动到文件开头
x%: 移动到文件中间，就使用 50%
H: 移动到 home
M: 移动到屏幕中间
L: 移动到一屏末尾
ctrl+G: 查看当前的位置状态
半屏或全屏滚动
半屏滚动: ctrl+u/ctrl+d
全屏滚动: ctrl+f/ctrl+b
如果文件很大，需要滚动很多屏，此时你还可以直接跳转到文件末尾zz：将光标置于屏幕的中间
zt: 将光标移动到屏幕的顶部
zb：将光标移动到屏幕的底部
在阅读代码的时候，如果你需要在几个点之间来回跳转，还可以设置跳转标记mx,my,mz 设置三个位置
`x,`y,`z 跳转到设置
```

## 搜索目标为二

`/m\|a`

# easyalign 插件的使用方法

如何对齐以下的代码？

原始代码：

```
static const int a;
const int b
```

1. 例子一：

```
static const int a;
const int b
```

使用： `* `

结果：

```
static const int a;
const  int   b
```

2. 例子二：

```
    static const int a;
    const int b
```

使用： `- `

结果：

```
static const int a;
const int        b
```


}}} # 使用方法
