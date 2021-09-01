:START

@echo off


set ServerDirectory=%~dp0


:: Server Ports (Server, Rust+ App, Query and RCON)
set serverport=28015
set appport=28083
set queryport=28017
set rconport=28018

:: Other Vars
set rconpassword=CHANGEME!!
set serveridentity=Identity
set serverhostname="Hostname"
set serverdescription=""
set serverurl="http://.."
set serverheaderimage="http://.."
set serverlogoimage="http://.."
set server_tags="monthly,pve"
set serverlevel=Procedural Map
set serverworldsize=4500
set serverseed=289704872
set servermaxplayers=50



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

cd %ServerDirectory%

start /WAIT RustDedicated.exe -batchmode -nographics ^
+server.port %serverport% ^
+rcon.port %rconport% ^
+rcon.password "%rconpassword%" ^
+app.port %appport% ^
+query.port %queryport% ^
+rcon.web 1 ^
+server.identity "%serveridentity%" ^
+server.level "%serverlevel%" ^
+server.worldsize "%serverworldsize%" ^
+server.seed "%serverseed%" ^
+server.maxplayers %servermaxplayers% ^
+server.hostname %serverhostname% ^
+server.description %serverdescription% ^
+server.url %serverurl% ^
+server.headerimage %serverheaderimage% ^
+server.logoimage %serverlogoimage% ^
+server.tags %server_tags% 


GOTO START
