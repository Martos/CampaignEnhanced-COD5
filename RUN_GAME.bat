@echo off

E:

cd "%CODWAW_PATH%\"

START "" CoDWaW_LanFixed.exe +set fs_game "mods/CampaignEnhanced" +set r_fullscreen 0 +set r_mode "1024x768" +set developer 1 +set ui_showList 0 +exec "default_controller.cfg"

exit /b