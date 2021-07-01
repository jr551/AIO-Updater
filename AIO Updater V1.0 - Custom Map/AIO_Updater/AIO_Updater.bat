:START

@echo off

set ServerDirectory=C:\Rust
set SteamCMD=C:\Rust\AIO_Updater\steamcmd
set Curl=C:\Rust\AIO_Updater\curl
set AIO=C:\Rust\AIO_Updater
set PROCESSNAME=RustDedicated.exe

ECHO *************************
ECHO ** UPDATING OXIDE/RUST **
ECHO *************************
echo.
echo Checking For Rust Update...
echo.
echo.
%SteamCMD%\steamcmd.exe +login anonymous +force_install_dir %ServerDirectory% +app_update 258550 validate﻿ +quit

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
.\7za\7za.exe x -spe "C:\Rust\Oxide.Rust.zip" -o"C:\Rust" -aoa
echo.
echo.
timeout 5 >nul

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
