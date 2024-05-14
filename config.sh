#!/bin/bash

Config() {
    if [ "~/.vimrc" -ot "~/vimconfig/config/_vimrc" ]
    then
        echo Start config...
        cp -R -u ./config/vimfiles/* ~/.vim/
        echo .vim directory  config done.
        cp -R -u ./config/_vimrc ~/.vimrc
        echo .vimrc config done.
        echo config done.
        # 这里的复制可能出现没有权限的情况，这种时候需要使用 sudo
    else
        echo config done.
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


