@echo off
REM 配置

SET /P isOk="是否要覆盖已存在的 vimrc ?（y/n )"

if /I "%isOk%" == "y" call copy_vimrc

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
goto eof
