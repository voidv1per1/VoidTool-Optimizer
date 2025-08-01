@echo off
:: =================== ADMIN CHECK ===================
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo ===========================================================
    echo  ERROR: This tool must be run as Administrator!
    echo ===========================================================
    echo.
    pause
    exit /b
)
:: =================== END ADMIN CHECK ===================

title Official VoidTools Tweaker
color 05
setlocal enabledelayedexpansion
set LOGFILE=%~dp0VoidTools_Log.txt

:mainmenu
cls
echo                          #     # ####### ### ######  ####### ####### ####### #       
echo                          #     # #     #  #  #     #    #    #     # #     # #       
echo                          #     # #     #  #  #     #    #    #     # #     # #       
echo                          #     # #     #  #  #     #    #    #     # #     # #       
echo                           #   #  #     #  #  #     #    #    #     # #     # #       
echo                            # #   #     #  #  #     #    #    #     # #     # #       
echo                             #    ####### ### ######     #    ####### ####### #######                                                                                                                                 
echo                           ===========================================================
echo.
echo                                   Official VoidTools Ultimate - discord.gg/aPZrYSjcbV
echo                           ===========================================================
echo.
echo                 [1] Performance     [2] Privacy     [3] Network     [4] Windows Services
echo.
echo                 [5] Windows Settings    [6] Network Settings    [7] CPU Settings    [8] GPU Settings
echo.
echo                 [9] Extra Tweaks     [B] Apply Best Settings     [R] Create Restore Point     [0] Exit
echo.
set /p mainchoice=                         Select an option: 
echo [%date% %time%] Main menu choice: %mainchoice% >> "%LOGFILE%"
echo ^G

if "%mainchoice%"=="1" goto performance
if "%mainchoice%"=="2" goto privacy
if "%mainchoice%"=="3" goto network
if "%mainchoice%"=="4" goto services
if "%mainchoice%"=="5" goto winsettings
if "%mainchoice%"=="6" goto netsettings
if "%mainchoice%"=="7" goto cpusettings
if "%mainchoice%"=="8" goto gpusettings
if "%mainchoice%"=="9" goto extra
if /i "%mainchoice%"=="B" goto bestsettings
if /i "%mainchoice%"=="R" goto restorepoint
if "%mainchoice%"=="0" exit
goto mainmenu

:notify
echo.
echo Completed, Thank you!
echo ^G
echo.
set /p dummy=Press Enter to continue...
goto %1

:progress
setlocal EnableDelayedExpansion
set "progress="
for /L %%i in (1,1,25) do (
    set "progress=!progress!█"
    cls
    echo Processing: [!progress! ]
    ping -n 1 127.0.0.1 > nul
)
endlocal
echo.

goto :eof

:performance
cls
echo.
echo                             =================== PERFORMANCE TWEAKS ===================
echo.
echo                 [1] Clear Temp Files     [2] Clear Prefetch     [3] Defrag C: Drive
echo                 [4] Clean Memory Cache   [5] Optimize SSD TRIM  [6] Back to Main Menu
echo.
set /p pchoice=                         Pick: 
echo [%date% %time%] Performance: %pchoice% >> "%LOGFILE%"

if "%pchoice%"=="1" call :progress & del /q /f /s %temp%\*.* && call :notify performance
if "%pchoice%"=="2" call :progress & del /q /f /s C:\Windows\Prefetch\*.* && call :notify performance
if "%pchoice%"=="3" call :progress & defrag C: /O && call :notify performance
if "%pchoice%"=="4" call :progress & rundll32.exe advapi32.dll,ProcessIdleTasks && call :notify performance
if "%pchoice%"=="5" call :progress & fsutil behavior set DisableDeleteNotify 0 && call :notify performance
if "%pchoice%"=="6" goto mainmenu
goto performance

:privacy
cls
echo.
echo                             =================== PRIVACY TWEAKS ===================
echo.
echo                 [1] Disable Telemetry   [2] Disable Cortana   [3] Disable Location
echo                 [4] Disable Ad ID       [5] Clear Activity History   [6] Back to Main Menu
echo.
set /p prchoice=                         Pick: 
echo [%date% %time%] Privacy: %prchoice% >> "%LOGFILE%"

if "%prchoice%"=="1" call :progress & sc stop DiagTrack & sc config DiagTrack start= disabled && call :notify privacy
if "%prchoice%"=="2" call :progress & reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v AllowCortana /t REG_DWORD /d 0 /f && call :notify privacy
if "%prchoice%"=="3" call :progress & reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" /v Value /t REG_SZ /d Deny /f && call :notify privacy
if "%prchoice%"=="4" call :progress & reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v Enabled /t REG_DWORD /d 0 /f && call :notify privacy
if "%prchoice%"=="5" call :progress & RunDll32.exe shell32.dll,ClearRecentDocs && call :notify privacy
if "%prchoice%"=="6" goto mainmenu
goto privacy

:network
cls
echo.
echo                             =================== NETWORK TWEAKS ===================
echo.
echo                 [1] Flush DNS     [2] Reset Winsock   [3] Release IP
echo                 [4] Renew IP      [5] Reset TCP/IP    [6] Back to Main Menu
echo.
set /p nchoice=                         Pick: 
echo [%date% %time%] Network: %nchoice% >> "%LOGFILE%"

if "%nchoice%"=="1" call :progress & ipconfig /flushdns && call :notify network
if "%nchoice%"=="2" call :progress & netsh winsock reset && call :notify network
if "%nchoice%"=="3" call :progress & ipconfig /release && call :notify network
if "%nchoice%"=="4" call :progress & ipconfig /renew && call :notify network
if "%nchoice%"=="5" call :progress & netsh int ip reset && call :notify network
if "%nchoice%"=="6" goto mainmenu
goto network

:services
cls
echo.
echo                             =================== WINDOWS SERVICES ===================
echo.
echo                 [1] Disable Xbox Services   [2] Disable Remote Registry
echo                 [3] Disable Error Reporting [4] Back to Main Menu
echo.
set /p schoice=                         Pick: 
echo [%date% %time%] Services: %schoice% >> "%LOGFILE%"

if "%schoice%"=="1" call :progress & sc stop XblAuthManager & sc config XblAuthManager start= disabled && call :notify services
if "%schoice%"=="2" call :progress & sc stop RemoteRegistry & sc config RemoteRegistry start= disabled && call :notify services
if "%schoice%"=="3" call :progress & sc stop WerSvc & sc config WerSvc start= disabled && call :notify services
if "%schoice%"=="4" goto mainmenu
goto services

:winsettings
cls
echo.
echo                             =================== WINDOWS SETTINGS ===================
echo.
echo                 [1] Enable Dark Mode   [2] Disable Animations   [3] Disable Tips
echo                 [4] Hide File Extensions   [5] Back to Main Menu
echo.
set /p wschoice=                         Pick: 
echo [%date% %time%] WinSettings: %wschoice% >> "%LOGFILE%"

if "%wschoice%"=="1" call :progress & reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v AppsUseLightTheme /t REG_DWORD /d 0 /f && call :notify winsettings
if "%wschoice%"=="2" call :progress & reg add "HKCU\Control Panel\Desktop\WindowMetrics" /v MinAnimate /t REG_SZ /d 0 /f && call :notify winsettings
if "%wschoice%"=="3" call :progress & reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SubscribedContent-338387Enabled /t REG_DWORD /d 0 /f && call :notify winsettings
if "%wschoice%"=="4" call :progress & reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v HideFileExt /t REG_DWORD /d 0 /f && call :notify winsettings
if "%wschoice%"=="5" goto mainmenu
goto winsettings

:netsettings
cls
echo.
echo                             =================== NETWORK SETTINGS ===================
echo.
echo                 [1] Disable Auto Updates   [2] Enable Metered Connection
echo                 [3] Optimize Bandwidth     [4] Back to Main Menu
echo.
set /p nschoice=                         Pick: 
echo [%date% %time%] NetSettings: %nschoice% >> "%LOGFILE%"

if "%nschoice%"=="1" call :progress & sc stop wuauserv & sc config wuauserv start= disabled && call :notify netsettings
if "%nschoice%"=="2" call :progress & reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\NetworkList\DefaultMediaCost" /v Ethernet /t REG_DWORD /d 2 /f && call :notify netsettings
if "%nschoice%"=="3" call :progress & netsh interface tcp set global autotuninglevel=highlyrestricted && call :notify netsettings
if "%nschoice%"=="4" goto mainmenu
goto netsettings

:cpusettings
cls
echo.
echo                             =================== CPU SETTINGS ===================
echo.
echo                 [1] High Perf Plan   [2] Disable Core Parking
echo                 [3] Set CPU Priority High   [4] Back to Main Menu
echo.
set /p cpchoice=                         Pick: 
echo [%date% %time%] CPU: %cpchoice% >> "%LOGFILE%"

if "%cpchoice%"=="1" call :progress & powercfg -setactive SCHEME_MIN && call :notify cpusettings
if "%cpchoice%"=="2" call :progress & reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583" /v ValueMax /t REG_DWORD /d 0 /f && call :notify cpusettings
if "%cpchoice%"=="3" call :progress & wmic process where name="explorer.exe" CALL setpriority 128 && call :notify cpusettings
if "%cpchoice%"=="4" goto mainmenu
goto cpusettings

:gpusettings
cls
echo.
echo                             =================== GPU SETTINGS ===================
echo.
echo                 [1] Clear Shader Cache   [2] Enable HW Acceleration
echo                 [3] Set Best Performance [4] Back to Main Menu
echo.
set /p gpchoice=                         Pick: 
echo [%date% %time%] GPU: %gpchoice% >> "%LOGFILE%"

if "%gpchoice%"=="1" call :progress & del /q /f /s "%LocalAppData%\NVIDIA\GLCache\*.*" && call :notify gpusettings
if "%gpchoice%"=="2" call :progress & reg add "HKCU\Software\Microsoft\Avalon.Graphics" /v DisableHWAcceleration /t REG_DWORD /d 0 /f && call :notify gpusettings
if "%gpchoice%"=="3" call :progress & reg add "HKCU\Software\Microsoft\Direct3D" /v DisableDPGStateOptimization /t REG_DWORD /d 0 /f && call :notify gpusettings
if "%gpchoice%"=="4" goto mainmenu
goto gpusettings

:extra
cls
echo.
echo                             =================== EXTRA TWEAKS ===================
echo.
echo                 [1] Enable Game Mode   [2] Enable Fast Boot
echo                 [3] Clear Logs         [4] Back to Main Menu
echo.
set /p echoice=                         Pick: 
echo [%date% %time%] Extra: %echoice% >> "%LOGFILE%"

if "%echoice%"=="1" call :progress & reg add "HKCU\Software\Microsoft\GameBar" /v AllowAutoGameMode /t REG_DWORD /d 1 /f && call :notify extra
if "%echoice%"=="2" call :progress & powercfg /hibernate on && call :notify extra
if "%echoice%"=="3" call :progress & wevtutil cl Application & wevtutil cl System && call :notify extra
if "%echoice%"=="4" goto mainmenu
goto extra

:restorepoint
cls
echo.
echo Creating System Restore Point...
powershell.exe -Command "Checkpoint-Computer -Description 'VoidTools Restore Point' -RestorePointType 'MODIFY_SETTINGS'"
echo.
echo [%date% %time%] Restore point created >> "%LOGFILE%"
call :notify mainmenu

:bestsettings
cls
echo.
echo Applying best tweaks for optimal performance...
call :progress
del /q /f /s %temp%\*.*
call :progress
del /q /f /s C:\Windows\Prefetch\*.*
call :progress
ipconfig /flushdns
call :progress
netsh winsock reset
call :progress
powercfg -setactive SCHEME_MIN
call :progress
sc stop DiagTrack & sc config DiagTrack start= disabled
call :progress
sc stop XblAuthManager & sc config XblAuthManager start= disabled
call :progress
fsutil behavior set DisableDeleteNotify 0
call :progress
reg add "HKCU\Software\Microsoft\GameBar" /v AllowAutoGameMode /t REG_DWORD /d 1 /f
call :progress
rundll32.exe advapi32.dll,ProcessIdleTasks
echo.
echo [%date% %time%] Best settings applied >> "%LOGFILE%"
call :notify mainmenu
