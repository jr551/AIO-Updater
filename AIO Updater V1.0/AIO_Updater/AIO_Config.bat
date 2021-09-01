@echo off
:: #####################
:: ## Configure Below ##
:: #####################

:: Server Ports (Server, Rust+ App, Query and RCON)
set serverport=28015
set appport=28083
set queryport=28017
set rconport=28018

:: RCON Password
set rconpassword=CHANGEME!!

:: Name Of Folder In C:\Rust\server
set serveridentity=Identity

:: Customise the server listing and appearance

set serverhostname="Hostname"
set serverdescription=""
set serverurl="http://.."
set serverheaderimage="http://.."
set serverlogoimage="http://.."
set server_tags="monthly,pve"

:: Server Level
set serverlevel=Procedural Map

:: World Size
set serverworldsize=4500

:: Server Seed
set serverseed=289704872

:: Max Player Count
set servermaxplayers=50

:: ##########################
:: ## End Of Configuration ##
:: ##########################

echo Setting Server Variables...

:: Change to C:\rust if this is not the same folder
set ServerDirectory=%~dp0

cd "%ServerDirectory%"

GOTO :server_start

:server_start

for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set "dt=%%a"
set "YY=%dt:~2,2%" & set "YYYY=%dt:~0,4%" & set "MM=%dt:~4,2%" & set "DD=%dt:~6,2%"
set "HH=%dt:~8,2%" & set "Min=%dt:~10,2%" & set "Sec=%dt:~12,2%"
set logpath=.\server\rsm\logs\%YYYY%-%MM%-%DD%\
if not exist %logpath% mkdir %logpath%
set fileName=%HH%-%Min%-%Sec%.txt
 
start RustDedicated.exe -batchmode -nographics ^
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
+server.hostname=%serverhostname% ^
+server.description=%serverdescription% ^
+server.url=%serverurl% ^
+server.headerimage=%serverheaderimage% ^
+server.logoimage=%serverlogoimage% ^
+server.tags=%server_tags% ^
-LogFile "%logpath%%fileName%" 

exit
