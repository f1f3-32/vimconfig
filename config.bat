@echo off
chcp 65001
REM 配置 vim
REM 1. 将 ./config/_vimrc 复制到 %USERPROFILE% 目录下
REM   - 如果己有 _vimrc 目录存在，请先备份后再执行此文件
REM 2. 将 ./config/vimfiles 目录复制到 %USERPROFILE% 目录下 
REM   - 如果己有 vimfiles 目录存在，请先备份后再执行此文件

SET /P isOk="是否要覆盖已存在的 vimrc ?(y/n):"

if /I "%isOk%" == "y" call :copy_vimrc

goto :eof

:copy_vimrc
set batch_dir=%~dp0
set batch_disk=%~d0


C:
cd %USERPROFILE%

if exist vimfiles (
    echo Start copy %batch_dir%\config to %cd%\vimfiles...
    xcopy %batch_dir%\config\vimfiles /s /y %USERPROFILE%\vimfiles
    echo Copy done.
) else (
    echo %batch_dir%\config\vimfiles is not exist.
)

if exist _vimrc (
    echo Start copy %batch_dir%\config... to %USERPROFILE%\_vimrc
    copy %batch_dir%\config\_vimrc  /y %USERPROFILE%\_vimrc
    echo Copy done.
) else (
    echo %USERPROFILE%\_vimrc is not exist.
)

%batch_disk%
cd %batch_dir%
goto :eof
