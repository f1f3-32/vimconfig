@echo off
REM obtain exists vim config to current directory's config directory
set batch_dir=%~dp0
set batch_disk=%~d0

C:
cd %USERPROFILE%

if exist vimfiles (
    echo Start copy %cd%\vimfiles to %batch_dir%\config...
    xcopy %USERPROFILE%\vimfiles /s /y %batch_dir%\config\vimfiles
) else (
    echo %USERPROFILE%\vimfiles is not exist.
)

if exist _vimrc (
    echo Start copy %USERPROFILE%\_vimrc to %batch_dir%\config...
    copy %USERPROFILE%\_vimrc  /y %batch_dir%\config\_vimrc
) else (
    echo %USERPROFILE%\_vimrc is not exist.
)

%batch_disk%
cd %batch_dir%
