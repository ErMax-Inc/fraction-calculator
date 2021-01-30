@echo off        
:: BatchGotAdmin        
:-------------------------------------        
REM  --> Check for permissions  
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"  
REM --> If error flag set, we do not have admin.  
if '%errorlevel%' NEQ '0' (    echo Requesting administrative privileges...    goto UACPrompt) else ( goto gotAdmin )  
:UACPrompt  
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"  
    echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"  
    "%temp%\getadmin.vbs"  
    exit /B
:gotAdmin

set /p unin=Are you sure you want to uninstall Fraction Calculator? Type 'YES' to uninstall, or press Enter to exit. 
if not %unin%==YES (
exit
)
cd %APPDATA%
cd Microsoft
cd Windows
cd Start Menu
cd Programs
rd "Fraction Calculator" /s /q
cd %PROGRAMFILES%
start rd "FraCal" /s /q
set /p out=Uninstall finished! Press Enter to exit. 