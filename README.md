# AIO-Updater
A start bat to auto update uMod and RustDedicated. also will restart RustDedicated if it closes


### HOW TO USE

1. create a folder called "Rust" directly in "C:/" drive
2. copy over the "AIO_updater" folder to the newly created folder
3. Edit the fields within the "AIO_Config.bat"
4. launch "AIO_Updater.bat"

### Tips

- Don't close any windows!! As one is the Rust Rcon and the other is checking if RustDedicated is still running, so if RustDedicated closes it will automatically start it back up. 
- If you are wanting to use a Custom Map please use the "AIO Updater V1.0 - Custom Map".
- All others (Barren,Hapis, Procedural, etc) can use the other folder, just change "set serverlevel=Procedural Map" To the appropriate map.
- server.hostname, server.description, server.headerimage, server.logoimage, server.url and any other that are not in the "AIO_Config.bat" are configured in "C:\Rust\server\YourServerIdentity\cfg\server.cfg".
