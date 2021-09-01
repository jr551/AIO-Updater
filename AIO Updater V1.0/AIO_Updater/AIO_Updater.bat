:START

@echo off

:: Change to C:\rust if this is not the same folder
set ServerDirectory=%~dp0
set SteamCMD=%~dp0\steamcmd
set Curl=%~dp0\curl
set AIO=%~dp0
set PROCESSNAME=RustDedicated.exe
set StartDelay=5

ECHO *************************
ECHO ** UPDATING OXIDE/RUST **
ECHO *************************
echo.
echo Checking For Rust Update...
echo.
echo.
%SteamCMD%\steamcmd.exe +login anonymous +force_install_dir %ServerDirectory% +app_update 258550 +quit

timeout 5 >nul
echo.
echo.
echo Downloading Oxide...
echo.
echo.
%Curl%\curl.exe -L https://umod.org/games/rust/download --output %ServerDirectory%\Oxide.Rust.zip

timeout 5 >nul
echo.
echo.
echo Extracting Oxide...
echo.
echo.
.\7za\7za.exe x -spe "%ServerDirectory%\Oxide.Rust.zip" -o"%ServerDirectory%" -aoa
echo.
echo.

echo Waiting %StartDelay% Seconds Before Starting Server
timeout %StartDelay% >nul
echo.
echo.

ECHO *********************
ECHO ** STARTING SERVER **
ECHO *********************

echo.
echo Saving Currently Opened ProcessID's Of RustDedicated

setlocal EnableExtensions EnableDelayedExpansion
set "RETPIDS="
set "OLDPIDS=p"
for /f "TOKENS=1" %%a in ('wmic PROCESS where "Name='%PROCESSNAME%'" get ProcessID ^| findstr [0-9]') do (set "OLDPIDS=!OLDPIDS!%%ap")

timeout 10 >nul

cd %ServerDirectory%

start %AIO%\AIO_Config.bat

timeout 5 >nul

echo.
echo Checking If RustDedicated Is Still Running...

timeout 30 >nul

::Check and find processes missing in the old pid list
for /f "TOKENS=1" %%a in ('wmic PROCESS where "Name='%PROCESSNAME%'" get ProcessID ^| findstr [0-9]') do (
if "!OLDPIDS:p%%ap=zz!"=="%OLDPIDS%" (set "RETPIDS=%%a !RETPIDS!")
)

:WAITLOOP
tasklist /FI "pid eq %RETPIDS%" 2>NUL | find "%RETPIDS%">NUL
if %ERRORLEVEL%==0 (
  timeout /t 2 /nobreak >nul
  goto :RUNNING
)

goto NOTRUNNING

:RUNNING
timeout 30 >nul
goto WAITLOOP

:NOTRUNNING
echo.
echo.
echo RustDedicated Has Been Teminated, Restarting...
echo.

cd %AIO%

GOTO START
