# AIO-Updater - Forked version with various changes (Jr551 fork)

A start bat to auto update uMod and RustDedicated. also will restart RustDedicated if it closes


### HOW TO USE

1. create a folder called "Rust" directly in "C:/" drive
2. copy over the "AIO_updater" folder to the newly created folder
3. Edit the fields within the "AIO_Config.bat"
4. launch "AIO_Updater.bat"

### Running More Than One Server

- To run a second server create a new folder in C:\ and give it a name.
- You will need to edit both "AIO_Updater.bat" and "AIO_Config.bat"
- Find all lines that contain C:\Rust\xxxxx\xxxxx and replace "Rust" with the name of the folder you created earlier and save.
- The StartDelay option in AIO_Updater.bat needs to be configured with atleast 60 seconds between each server to prevent unwanted behavior.
- Drop The AIO_Updater folder also in that new folder then open "AIO_Updater.bat"
- This guide could be used if you dont want the folder to be called "Rust"

### Tips

- Don't close any windows!! As one is the Rust Rcon and the other is checking if RustDedicated is still running, so if RustDedicated closes it will automatically start it back up. 
- If you are wanting to use a Custom Map please use the "AIO Updater V1.0 - Custom Map".
- All others (Barren,Hapis, Procedural, etc) can use the other folder, just change "set serverlevel=Procedural Map" To the appropriate map.
