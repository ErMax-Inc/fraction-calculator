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

echo.
echo License:
echo.
echo MIT License
echo.
echo Copyright (c) 2020 ErMax Inc.
echo.
echo Permission is hereby granted, free of charge, to any person obtaining a copy
echo of this software and associated documentation files (the "Software"), to deal
echo in the Software without restriction, including without limitation the rights
echo to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
echo copies of the Software, and to permit persons to whom the Software is
echo furnished to do so, subject to the following conditions:
echo.
echo The above copyright notice and this permission notice shall be included in all
echo copies or substantial portions of the Software.
echo.
echo THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
echo IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
echo FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
echo AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
echo LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
echo OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
echo SOFTWARE.
echo.
set /p l=Do you agree with the license? Type 'y' if you agree. 
echo.
if not %l%==y (
exit
)
cd %PROGRAMFILES%
md FraCal
cd %~dp0
cd app
move "Fraction Calculator.exe" "C:\Program Files\FraCal"
move "Version.txt" "C:\Program Files\FraCal"
move "License.txt" "C:\Program Files\FraCal"
move "Uninstall.bat" "C:\Program Files\FraCal"
cd..
cd nircmd
nircmd.exe shortcut "%PROGRAMFILES%\FraCal\Fraction Calculator.exe" "~$folder.programs$\Fraction Calculator" "Fraction Calculator"
nircmd.exe shortcut "%PROGRAMFILES%\FraCal\Uninstall.bat" "~$folder.programs$\Fraction Calculator" "Uninstall"
echo.
set /p out=Installation finished! Delete installation folder? Type 'y' to delete, or press Enter to exit. 
if %out%==y (
cd..
cd..
start rd "Frac Calc" /s /q
exit
)