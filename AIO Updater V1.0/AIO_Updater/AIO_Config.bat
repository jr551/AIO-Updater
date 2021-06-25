@echo off
:: #####################
:: ## Configure Below ##
:: #####################
 
:: Server IP
set serverip=0.0.0.0

:: Server Port
set serverport=28015

:: RCON IP
set rconip=0.0.0.0

:: RCON PORT
set rconport=0.0.0.0

:: RCON Password
set rconpassword=CHANGEME!!

:: Rust+ app Port
set appport=28083

:: Query Port
set queryport=28017

:: Name Of Folder In C:\Rust\server
set serveridentity=Identity

:: Server Level
set serverlevel=Procedural Map

:: World Size
set serverworldsize=4500

:: Server Seed
set serverseed=289704872

:: Max Player Count
set servermaxplayers=50

:: Affinity
set affinity=0x000000000000001E

:: ##########################
:: ## End Of Configuration ##
:: ##########################

echo Setting Server Variables...

set ServerDirectory=C:\Rust\
set Bat_Start=C:\Rust\Start_Server_Bat

cd "%ServerDirectory%"

GOTO :server_start

:server_start

for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set "dt=%%a"
set "YY=%dt:~2,2%" & set "YYYY=%dt:~0,4%" & set "MM=%dt:~4,2%" & set "DD=%dt:~6,2%"
set "HH=%dt:~8,2%" & set "Min=%dt:~10,2%" & set "Sec=%dt:~12,2%"
set path=.\server\rsm\logs\%YYYY%-%MM%-%DD%\
if not exist %path% mkdir %path%
set fileName=%HH%-%Min%-%Sec%.txt
 
start /AFFINITY %affinity% RustDedicated.exe -batchmode -nographics ^
+server.ip %serverip% ^
+server.port %serverport% ^
+rcon.ip %rconip% ^
+rcon.port %rconport% ^
+rcon.password "%rconpassword%" ^
+app.port %appport% ^
+query.port %queryport% ^
+server.identity "%serveridentity%" ^
+server.level "%serverlevel%" ^
+server.worldsize "%serverworldsize%" ^
+server.seed "%serverseed%" ^
+server.maxplayers %servermaxplayers% ^
-LogFile "%path%%fileName%" ^

exit
