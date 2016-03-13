@echo off
title {GameName}
if '%ver%' == '' goto notauth
for /f "delims=" %%x in (%tmp%/{DevName}/col.txt) do set Build=%%x
color %build%

:tof33
set user=
set password=
cls
echo Welcome to {GameName}, by {DevName}
echo.
pause

:top
title {GameName}: Login
cls
echo Please log in or type exit to exit
echo.
set /p user=Username:
cls
if /i %user% == {User1} goto login{User1}
if /i %user% == {User2} goto login{User2}
if /i %user% == {User3} goto login{User3}
if /i %user% == Exit goto exit
echo Username Not Found!
pause
cls
goto top

:login{User1}
cls
echo Please log in or type logout to choose another username
echo.
set /p password=Password:
if /i %password% == {User1Password} goto code
if /i %password% == logout goto top
cls
echo Incorrect Password!
pause
cls
goto login{User1}

:login{User2}
cls
echo Please log in or type logout to choose another username
echo.
set /p password=Password:
if /i %password% == {User2Password} goto code
if /i %password% == logout goto top
cls
echo Incorrect Password!
pause
cls
goto login{User2}

:login{User3}
cls
echo Please log in or type logout to choose another username
echo.
set /p password=Password:
if /i %password% == {User3Password} goto code
if /i %password% == logout goto top
cls
echo Incorrect Password!
pause
cls
goto login{User3}

:NetworkCheck
if %userdomain% == {BannedNetwork} goto NetworkError
cls
goto returnNetCheck

:NetworkError
cls
echo You are not authorized to use this account here. Please use it elsewhere!
echo.
pause
cls
exit

:code
if /i %user% == {User1} goto NetworkCheck
if %user% == {User2} set user={User2}
if %user% == {User3} set user={User3}

:returnNetCheck
if /i "%user%" == "{User1}" (
set user=User:~%username% >nul
)
if /i %user% == {User3] set user=%username%

REM *** INSERT GAME CODE HERE ***

:zchange
cls
echo -----------------------------------Changelog----------------------------------
echo.
for /f "delims=" %%x in (%tmp%/{DevName}/localgamever.txt) do set gamever=%%x
echo Game Version: %gamever%
echo.
echo.
echo v1.4----------
echo.
echo -Change 5
echo -Change 6
echo.
echo v1.3----------
echo.
echo -Change 3
echo -Change 4
echo.
echo v1.2----------
echo.
echo -Change 2
echo.
echo v1.1----------
echo.
echo -Change 1
echo.
echo.
echo.
pause
goto GameFunction

:notauth
cls
title {GameName}: Error
echo This program can only be ran from the launcher!
echo.
pause
exit
