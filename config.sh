#!/bin/bash

Config() {
    echo _vimrc 是 windows 上的配置文件名, linux 上为 .vimrc 。
    echo vimfiles 是 windows 上插件目录名，linux 上为 .vim 。
    cp_vimrc = false
    cp_vimfiles = false
    if [ "~/.vimrc" -ot "./config/_vimrc" ]
    then
        cp_vimrc = true
    else
        echo "~/.vimrc 比 ./config/_vimrc 新，请问是否进行复制（y/n)？"
        read is_ok
        if [ is_ok = "y" ]
        then
            cp_vimrc = true
        fi
    fi

    if [ "~/.vim" -ot  "./config/vimfiles" ]
    then
        cp_vimfiles = true
    else
        echo "~/.vim 比 ./config/vimfiles 新，请问是否进行复制（y/n）？"
        read is_ok
        if [ is_ok == "y" ]
        then
            cp_vimfiles = true
        fi
    fi

    if [ cp_vimrc ]
    then
        cp -R -u ./config/_vimrc ~/.vimrc
        echo "./config/_vimrc 已经复制到 ~/.vimrc，原文件(~/.vimrc)已被覆盖。"
    else
        echo "复制 vimrc 失败！"
    fi

    if [ cp_vimfiles ]
    then
        cp -R -u ./config/vimfiles/* ~/.vim/
        echo "./config/vimfiles/* 已经复制到 ~/.vim/ , 原目录中的同名的文件已被覆盖。"
    else
        echo "复制 vimfiles 失败！"
    fi
}

Obtain_Exist_Config() {
    # cp -R -u ~/.vim/pack ./config/vimfiles/
    cp -R -u ~/.vim/* ./config/vimfiles/
    cp -u ~/.vimrc ./config/_vimrc
    echo Obtain exist config successful.
}

Display_Config() {
    echo ./config
    ls ./config/ -l
    echo -e ""
    echo ./config/vimfiles/pack
    ls ./config/vimfiles/pack -l
}

if [ $# -gt 0 ]
then
    for i in $*
    do
        case $i in
            "-c") Config
                ;;
            "-o") Obtain_Exist_Config
                ;;
            "-d") Display_Config
                ;;
            "-h") cat help.txt
                ;;
        esac
    done
else
    echo Please use option
    cat help.txt
fi


