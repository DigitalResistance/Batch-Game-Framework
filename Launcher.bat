@echo off
set ver=1.0

:eularet
if NOT EXIST %tmp%/{DevName}/Mode.txt (
set mode=1 
MODE CON: COLS=80 LINES=25
goto modebypss
) 
for /f "delims=" %%x in (%tmp%/{DevName}/mode.txt) do set mode=%%x
if %mode% == 1 MODE CON: COLS=80 LINES=25
if %mode% == 2 mode CON: COLS=1000 LINES=1010

:modebypss
if NOT EXIST %tmp%/tmp.tmp goto eula
echo %ver% >%tmp%/{DevName}/localLauncherVer.txt
set {DevName}=%tmp%/{DevName}
title {GameName} Launcher: Error
del tmp.bat
del /A:H tmp.bat
cls
EndLocal
goto verCheck

:verCheckRet
IF NOT EXIST %cd%\NUL echo dir 
cls
if %errorlevel% == 3 goto notWork
if EXIST %userprofile%/NUL echo dir
cls
if %errorlevel% == 9009 goto notWork
cls
del %tmp%/{DevName}/dir.txt
echo %cd%\Launcher.bat >%tmp%/{DevName}/dir.txt
if NOT EXIST Launcher.bat goto renFile
if '%cd%' == '%systemroot%/System32' cd %userprofile%/Desktop
title {GameName} Launcher

:top
for /f "delims=" %%x in (%tmp%/{DevName}/col.txt) do set build=%%x
color %build%
cls
echo {GameName} Launcher by {DevName}
echo.
echo [U]pdates/Installation
echo [R]un {GameName}
echo [S]ettings
echo.
echo [E]xit
choice /c URSE /n
if %ERRORLEVEL% == 1 goto MenuUpdates
if %ERRORLEVEL% == 2 goto run
if %ERRORLEVEL% == 3 goto MenuSettings
if %ERRORLEVEL% == 4 goto exit
exit /b

:MenuUpdates
cls
echo {GameName} Launcher by {DevName}
echo.
echo [I]nstall Latest Version 
echo [P]erform A Launcher Update
echo [U]ninstall {GameName}
echo.
echo [M]ain Menu
choice /c IPUM /n
if %errorlevel% == 1 goto install
if %errorlevel% == 2 goto call 
if %errorlevel% == 3 goto uninstall
if %errorlevel% == 4 goto top
exit /b

:MenuSettings
cls
echo {GameName} Launcher by {DevName}
echo.
echo [C]hange Color
echo [T]oggle Fullscreen Mode
echo [A]bout The Program
echo [R]efresh Launcher
echo.
echo [M]ain Menu
choice /c CTAMR /n
if %errorlevel% == 1 goto color
if %errorlevel% == 2 goto ChangeMode
if %errorlevel% == 3 goto about
if %errorlevel% == 4 goto top
if %errorlevel% == 5 start Launcher.bat & exit
exit /b

rem ######################################

:call
cls

:back21
cls
ping google.com -n 1 -w 100>nul 2>&1 && set error=pass
if NOT '%error%' == 'pass' goto noInternet3
if NOT EXIST %tmp%/{DevName}/{GameName}.bat goto callFail
echo Checking Version...
powershell -command "& { iwr https://www.dropbox.com/s/zrptn4ro5bsjzmp/OnlineGameVer.txt?dl=1 -OutFile %tmp%/{DevName}/OnlineLauncherVer.txt }" 
timeout /t 1 /NOBREAK >nul
title {GameName} Launcher
cls
for /f "delims=" %%x in (%tmp%/{DevName}/OnlineLauncherVer.txt) do set OnlineLauncherVer=%%x
for /f "delims=" %%x in (%tmp%/{DevName}/LocalLauncherVer.txt) do set LocalLauncherVer=%%x
cls
if %OnlineLauncherVer% == %LocalLauncherVer% goto LatestLauncherV
cls
echo There is an update available for the launcher! (Local: %locallauncherver% Available: %OnlinelauncherVer%)
echo.
echo Would you like to install it?
echo.
echo [Y]es
echo [N]o
choice /c YN /n
if %errorlevel% == 2 goto top
cls
echo Updating...
echo cmd /c " del Launcher.bat & timeout /t 2 /NOBEAK & ren LauncherO.bat Launcher.bat & call Launcher.bat " >tmp.bat
powershell -command "& { iwr https://www.dropbox.com/s/fj579rqh8p0hte5/Launcher.bat?dl=1 -OutFile LauncherO.bat }
title {GameName} Launcher
timeout /t 2 /NOBREAK >nul
cls
call tmp.bat
exit

:callfail
cls
echo You must install {GameName} before you can update the launcher!
echo.
pause
goto top


:latestlauncherv
cls
echo The latest version of {GameName} Launcher is already installed!
echo.
pause
goto top

:exit
cls 
cls
echo Exiting {GameName} Lancher...
timeout /t 1 /NOBREAK >nul
exit
cls
color 8
cls
title {GameName} Launcher: Error
echo Program Shutdown Error [Code 3]
echo.
echo Please Type Exit to Exit
exit /b


:ChangeMode
cls
if %mode% == 1 goto mode1000
if %mode% == 2 goto mode100
goto MenuSettings

:mode1000
mode CON: COLS=1000 LINES=1010
set mode=2
echo %mode% >%tmp%/{DevName}/mode.txt
goto MenuSettings

:mode100
MODE CON: COLS=80 LINES=25
set mode=1
echo %mode% >%tmp%/{DevName}/mode.txt
goto MenuSettings


:run
cls
echo Starting...
echo.
echo TIP: Press Q on the Game's Option Menu To Read The Changelog!
timeout /t 3 /NOBREAK >nul
if NOT exist %tmp%\{DevName}\{GameName}.bat goto needFiles
cls
call %tmp%\{DevName}\{GameName}.bat
exit

:install
cls
mkdir %tmp%\{DevName}
mkdir %tmp%\{DevName}\Errors
del %tmp%\{DevName}\ver.txt
cls
echo Checking Version...
ping google.com -n 1 -w 100>nul 2>&1 && set error=pass
if NOT '%error%' == 'pass' goto noInternet 
powershell -command "& { iwr https://{Website}/OnlineGameVer.txt -OutFile %tmp%/{DevName}/OnlineGameVer.txt }" 
timeout /t 1 /NOBREAK >nul
title {GameName} Launcher
cls
for /f "delims=" %%x in (%tmp%/{DevName}/OnlineGameVer.txt) do set OnlineGameVer=%%x
for /f "delims=" %%x in (%tmp%/{DevName}/LocalGameVer.txt) do set LocalGameVer=%%x
cls
if NOT EXIST %tmp%/{DevName}/{GameName}.bat goto installNoNotice
if %OnlineGameVer% == %LocalGameVer% goto LatestGameV
cls
echo There is an update available for {GameName}! (Local: %localgamever% Available: %OnlineGameVer%)
echo.
echo Would you like to install it?
echo.
echo [Y]es
echo [N]o
choice /c YN /n
if %errorlevel% == 2 goto top
cls
:installNoNotice
del %tmp%\{DevName}\{GameName}.bat
cls
echo Downloading Files...
powershell -command "& { iwr https://{Website}/{GameName}.bat -OutFile %tmp%\{DevName}\{GameName}.bat }" 
powershell -command "& { iwr https://{Website}/{PowerShell}.ps1 -OutFile %tmp%\{DevName}\{PowerShell}.ps1 }" 
title {GameName} Launcher
echo %OnlineGameVer% >%tmp%/{DevName}/LocalGameVer.txt
cls
echo The latest version has been sucsessfuly installed!
echo.
pause
cls
echo Do you want to run {GameName}?
echo.
echo [Y]es 
echo [N]o
choice /c YN /n
if %ERRORLEVEL% == 1 goto Run
if %ERRORLEVEL% == 2 goto top
exit /b

:LatestGameV
cls
echo The latest version of {GameName} is already installed!
echo.
pause
goto top


:needFiles
cls
echo You need to install {GameName} first!
echo Please select what you would like to do next:
echo.
echo [I]nstall
echo [E]xit
choice /c IE /n
if %ERRORLEVEL% == 1 goto install
if %ERRORLEVEL% == 2 goto top
exit /f

:noInternet
cls
echo You must be connected to the internet to preform this action!
echo.
echo Please select what you would like to do next:
echo.
echo [R]un Currently Installed Version
echo [T]ry Agean
echo [E]xit
choice /c RTE /n
if %ERRORLEVEL% == 1 goto Run
if %ERRORLEVEL% == 2 goto install
if %ERRORLEVEL% == 3 goto top
exit /b

:Uninstall
if NOT EXIST %tmp%/{DevName} goto ihatecmd
cls
echo Are you sure you would like to uninstall {GameName}?
echo.
echo [Y]es
echo [N]o
echo [U]ninstall the launcher
choice /c YNU /n
if %errorlevel% == 2 goto top
if %errorlevel% == 3 (
set fromstartu=1
goto lun
)
cls
echo Uninstalling {GameName}...
timeout /t 3 /NOBREAK >nul
rd %tmp%\{DevName}\Errors
del /q %tmp%\{DevName}\*
rd %tmp%\{DevName}
cls
echo {GameName} has been uninstalled!
echo.
pause
:foodU
set errorlevel=
cls
echo Would you like to uninstall the launcher?
echo.
echo [Y]es
echo [N]o
choice /c YN /n
if %errorlevel% == 2 goto top
:lun
cls
echo Are you sure? You will not be able to play {GameName} anymore!
if %fromstartu% == 1 echo You will also not be able to uninstall the launcher!
echo.
echo [Y]es
echo [N]o
choice /c YN /n
if %errorlevel% == 2 goto top
cls
echo Waiting...
echo.
timeout /t 3 /NOBREAK >nul
del %tmp%\tmp.tmp
del %tmp%\tmpi.tmp
echo cmd /c " del /A:H tmp.bat & del Launcher.bat & ren Delete_This.bat tmp.bat & attrib tmp.bat +h & msg %username% The Launcher has been Uninstalled! & del /A:H tmp.bat & cls & Echo The program has been deleted! Type exit to exit the Command Prompt! & title Windows Command Host " >Delete_This.bat
call Delete_This.bat
exit 

:ihatecmd
cls
echo You do not have any version of {GameName} installed!
echo.
pause
cls
goto foodU
exit






:about
title About {GameName}
for /f "delims=" %%x in (%tmp%/{DevName}/LocalGameVer.txt) do set GameVer=%%x
if NOT EXIST %tmp%/{DevName}/LocalGameVer.txt set GameVer=Not Installed
cls
echo Launcher Version: %ver%
echo.
echo Program Version: %GameVer%
echo.
echo Developed by: {DevName} with open source code integrated from https://github.com/SP-Alex/Batch-Game-Framework , licensed under the GNU Lesser General Public License Version 3.
echo.
echo Licenced To Run On: %computername% for %username% in %cd%
echo.
echo Current Developer Remarks: Press Z on the menu to refresh the launcher
echo.
echo.
echo [C]hangelog
echo [E]xit
choice /c EC /n
if %errorlevel% == 1 goto top
if %errorlevel% == 2 goto changelog
exit






:noInternet3
cls
echo You must be connected to the internet to preform this action!
echo.
echo Please select what you would like to do next:
echo.
echo [R]un currently Installed Version
echo [T]ry agean
echo [E]xit
choice /c RTE /n
if %ERRORLEVEL% == 1 goto top
if %ERRORLEVEL% == 2 goto back21
if %ERRORLEVEL% == 3 goto top
exit /b

:color
cls
for /f "delims=" %%x in (%tmp%/{DevName}/col.txt) do set col55=%%x
cls
echo You can choose between 5 different colors that the program can display.
echo If you have {GameName} installed, your color will be saved.
echo.
pause
:cho1
cls
echo Please choose:
echo.
echo [R]ed
echo [Y]ellow
echo [B]lue
echo [G]reen
echo [W]hite (Deafult)
choice /c RYBGW /n
if %errorlevel% == 1 goto r
if %errorlevel% == 2 goto y
if %errorlevel% == 3 goto b
if %errorlevel% == 4 goto g
if %errorlevel% == 5 goto w
exit

:r
cls
color c
set c=c
cls
echo Color changed!
pause
goto color2

:y
cls
color 6
set c=6
cls
echo Color changed!
pause
goto color2

:b
cls
color b
set c=b
cls
echo Color changed!
pause
goto color2

:w
cls
color 7
set c=7
cls
echo Color changed!
pause
goto color2

:g
cls
color a
set c=a
cls
echo Color changed!
pause
goto color2
 

:color2
cls
if %c% == c set color9=Red
if %c% == 6 set color9=Yellow
if %c% == b set color9=Blue
if %c% == a set color9=Green
if %c% == 7 set color9=White
cls
:Color44
cls
color %c%
echo You have chosen %color9%! Do you want to keep it like this?
echo.
echo [Y]es
echo [C]hange Color
echo [N]o, Change it Back
choice /c YCN /n
if %ERRORLEVEL% == 1 goto appColor
if %ERRORLEVEL% == 2 goto colRebound
if %ERRORLEVEL% == 3 goto ColReset
cls
goto top

:colReset
cls
color 7
for /f "delims=" %%x in (%tmp%/{DevName}/col.txt) do set col=%%x
color %col%
cls
echo The Color has been reset!
echo.
pause
goto top

:colRebound
color %col55%
goto cho1

:appColor
cls
del %tmp%/{DevName}/col.txt
echo %c% >%tmp%/{DevName}/col.txt
cls
if EXIST %tmp%/{DevName}/col.txt echo The color has been applied and saved!
if NOT EXIST %tmp%/{DevName}/col.txt echo The color has been applied!
echo.
pause
goto top

:notWork
cd %userprofile%/Music
cls
if %errorlevel% == 1 goto userInvalid & cd /d "%~dp0"
cd /d "%~dp0"
color 8
echo.
echo The directory (folders) you are using will not work for this program.
echo.
echo Try chaging the directory (folders) you put the file in.
echo.
echo Make sure the folders all contain one word:
echo EX: Folder1/Folder2/Folder3/Folder4/Folder5
echo.
echo.
echo ---------------------------------Error Info------------------------------------
echo.
echo Code: 12 \ Type: InvalidDirectory \ Launcher Version: %ver%
echo.
echo Directory: [%cd%] -Error 
echo.
echo User Profile: %userprofile%
echo.
echo Please report this error to: {DevName}. Feel free to send him an E-Mail at {DevEmail} with the subject "{GameName} Error"
echo.
echo ---------------------------------Error Info------------------------------------
echo.
echo.
pause
cls
for /f "delims=" %%x in (%tmp%/{DevName}/col.txt) do set errColor=%%x
color %errColor%
cls
echo Would you like to save the error report so you can print or report it?
echo.
echo [Y]es
echo [N]o
choice /c YNB /n
if %errorlevel% == 2 goto errNotSaved
if %errorlevel% == 3 goto bypass
mkdir %tmp%\{DevName}
mkdir %tmp%\{DevName}\Errors
set name2=ERR%random%
cls
echo Error Report- [Code: 12] [Type: InvalidDirectory] [Launcher Version: %ver%]  [Current Directory: %cd%] [Date: %date%] [Time: %time%] >%tmp%/{DevName}/Errors/%name2%.txt
cls
echo An error report has been saved!
echo.
pause
cls
echo Would you like to print or open the file so you can submit it?
echo.
echo [P]rint
echo [O]pen
echo [E]xit
choice /c PEO /n
if %errorlevel% == 2 goto exit
if %errorlevel% == 3 goto openReport
cls
echo Making an attempt to print the report... 
notepad /p %tmp%/{DevName}/Errors/%name2%.txt
timeout /t 3 /NOBREAK >nul
goto exit

:errNotSaved
cls
echo An Error Report has not been saved.
echo.
pause
goto exit

:openReport
cls
notepad.exe %tmp%/{DevName}/Errors/%name2%.txt
exit


:renFile
cls
title {GameName} Launcher: Error
color 8
echo.
echo You have named this file: %~n0
echo Please Rename this file back to: Launcher
echo.
echo EX: Launcher.bat
echo.
echo.
echo ---------------------------------Error Info------------------------------------
echo.
echo Code: 14 \ Type: InvalidName \ Launcher Version: %ver%
echo.
echo Directory: %cd%
echo.
echo File Name: [%~n0] -Error
echo.
echo Please report this error to: {DevName}. Feel free to send him an E-Mail at {DevEmail} with the subject "{GameName} Error"
echo.
echo ---------------------------------Error Info------------------------------------
echo.
echo.
pause
cls
for /f "delims=" %%x in (%tmp%/{DevName}/col.txt) do set errColor=%%x
color %errColor%
cls
echo Would you like to save the error report so you can print or report it?
echo.
echo [Y]es
echo [N]o
choice /c YNB /n
if %errorlevel% == 2 goto errNotSaved2
if %errorlevel% == 3 goto bypass
mkdir %tmp%\{DevName}
mkdir %tmp%\{DevName}\Errors
set name3=ERR%random%
cls
echo Error Report- [Code: 14] [Type: InvalidName] [Launcher Version: %ver%]  [File Name: %~n0] [Current Directory: %cd%] [Date: %date%] [Time: %time%] >%tmp%/{DevName}/Errors/%name3%.txt
cls
echo An error report has been saved!
echo.
pause
cls
echo Would you like to print or open the file so you can submit it?
echo.
echo [P]rint
echo [O]pen
echo [E]xit
choice /c PEO /n
if %errorlevel% == 2 goto exit
if %errorlevel% == 3 goto openReport2
cls
echo Making an attempt to print the report... 
notepad /p %tmp%/{DevName}/Errors/%name3%.txt
timeout /t 3 /NOBREAK >nul
goto exit

:errNotSaved2
cls
echo An Error Report has not been saved.
echo.
pause
goto exit

:openReport2
cls
notepad.exe %tmp%/{DevName}/Errors/%name3%.txt
exit

:verCheck
REM Check Windows Version
REM ver | findstr /i "5\.0\." > nul
REM IF %ERRORLEVEL% EQU 0 set winver=2000
REM ver | findstr /i "5\.1\." > nul
REM IF %ERRORLEVEL% EQU 0 set winver=XP
REM ver | findstr /i "5\.2\." > nul
REM IF %ERRORLEVEL% EQU 0 set winver=2003
REM ver | findstr /i "6\.0\." > nul
REM IF %ERRORLEVEL% EQU 0 set winver=Vista
REM ver | findstr /i "6\.1\." > nul
REM IF %ERRORLEVEL% EQU 0 set winver=7
REM ver | findstr /i "6\.2\." > nul
REM IF %ERRORLEVEL% EQU 0 set winver=8
REM if '%winver%' == '2000' goto nowin
REM if '%winver%' == 'XP' goto nowin
REM if '%winver%' == '2003' goto nowin
REM if '%winver%' == 'Vista' goto nowin
REM if '%winver%' == '7' goto nowin
if '%winver%' == '8' goto nowin
goto verCheckRet


:Bypassret
cls
color 7
goto top

:noWin
cls
title {GameName} Launcher: Error
color 8
echo.
echo You Are running this file on a computer with an incompatible version of Windows.
echo Windows %winver% is not compatible with this program. Please try Windows 8.1
echo.
echo EX: Computer Running Windows 8
echo.
echo.
echo ---------------------------------Error Info------------------------------------
echo.
echo Code: 7 \ Type: OutdatedWindows \ Launcher Version: %ver%
echo.
echo Directory: %cd%
echo.
echo Windows Version: [Windows %winver%] -Error
echo.
echo Please report this error to: {DevName}. Feel free to send him an E-Mail at {DevEmail} with the subject "{GameName} Error"
echo.
echo ---------------------------------Error Info------------------------------------
echo.
echo.
pause
cls
for /f "delims=" %%x in (%tmp%/{DevName}/col.txt) do set errColor=%%x
color %errColor%
cls
echo Would you like to save the error report so you can print or report it?
echo.
echo [Y]es
echo [N]o
choice /c YNB /n
if %errorlevel% == 2 goto errNotSaved3
if %errorlevel% == 3 goto Bypass
mkdir %tmp%\{DevName}
mkdir %tmp%\{DevName}\Errors
set name4=ERR%random%
cls
echo Error Report- [Code: 7] [Type: OutdatedWindows] [Windows Version: Windows %winver%] [Launcher Version: %ver%] [Current Directory: %cd%] [Date: %date%] [Time: %time%] >%tmp%/{DevName}/Errors/%name4%.txt
cls
echo An error report has been saved!
echo.
pause
cls
echo Would you like to print or open the file so you can submit it?
echo.
echo [P]rint
echo [O]pen
echo [E]xit
choice /c PEO /n
if %errorlevel% == 2 goto exit
if %errorlevel% == 3 goto openReport3
cls
echo Making an attempt to print the report... 
notepad /p %tmp%/{DevName}/Errors/%name4%.txt
timeout /t 3 /NOBREAK >nul
goto exit

:errNotSaved3
cls
echo An Error Report has not been saved.
echo.
pause
goto exit

:openReport3
cls
notepad.exe %tmp%/{DevName}/Errors/%name4%.txt
exit


:eula
cls
title {GameName}: EULA
echo #####Please Read This Important Information!#####
echo.
echo Thank You for playing {GameName}!
echo {EULALine1}
echo {EULALine2}
echo {EULALine3}
echo.
echo Waiting 20 Seconds...
echo.
timeout /t 20 /NOBREAK >nul
pause
echo DO NOT DELETE!!! >%tmp%/tmp.tmp
goto eularet


:UserInvalid
color 8
echo The Username you are using will not work for this program.
echo.
echo Try chaging the username you are using the file in. (%username%)
echo.
echo Make sure the User Name, specificly the User Folder contain 1 word!
echo EX: C:/Users/johns/ 
echo.
echo.
echo ---------------------------------Error Info------------------------------------
echo.
echo Code: 13 \ Type: InvalidUsername \ Launcher Version: %ver%
echo.
echo Directory: %cd% 
echo.
echo User Profile: [%userprofile%] -Error
echo.
echo Please report this error to: {DevName}. Feel free to send him an E-Mail at {DevEmail} with the subject "{GameName} Error"
echo.
echo ---------------------------------Error Info------------------------------------
echo.
echo.
pause
cls
for /f "delims=" %%x in (%tmp%/{DevName}/col.txt) do set errColor=%%x
color %errColor%
cls
echo NOTE: You cannot save or print this file due to your UserName.
echo.
pause
goto exit

:bypass
cls
echo Bypassing Error... [Warning, Program May Not Work!]
echo.
title {GameName}: Bypass/Insecure
pause
goto bypassret

rem-----------------------------------------------------------------------------------------------------------------------------------------------------------------------

:changelog
MODE CON: COLS=80 LINES=200
cls
echo.
echo -----------------------------------Changelog----------------------------------
echo.
echo.
echo.
echo V1.0------------
echo.
echo -Initial Release
echo.
echo.
pause
MODE CON: COLS=80 LINES=25
cls
goto about