@echo off
:: #####################
:: ## Configure Below ##
:: #####################

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

set ServerDirectory=%~dp0
cd "%ServerDirectory%"

 
RustDedicated.exe -batchmode -nographics ^
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
+server.tags %server_tags% ^
-LogFile "%logpath%%fileName%" 
