:START

@echo off

set ServerDirectory=C:\Rust
set SteamCMD=C:\Rust\AIO_Updater\steamcmd
set Curl=C:\Rust\AIO_Updater\curl
set AIO=C:\Rust\AIO_Updater

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

cd %ServerDirectory%

start C:\Rust\AIO_Updater\AIO_Config.bat

timeout 15 >nul
echo.
echo Checking If RustDedicated Is Still Running...

goto WAITLOOP

:WAITLOOP
tasklist /FI "IMAGENAME eq RustDedicated.exe" 2>NUL | find /I /N "RustDedicated.exe">NUL
if "%ERRORLEVEL%"=="0" goto RUNNING
goto NOTRUNNING

:RUNNING
timeout 15 >nul
goto WAITLOOP

:NOTRUNNING
echo.
echo.
echo RustDedicated Has Been Teminated, Restarting...
echo.

cd %AIO%

GOTO START
