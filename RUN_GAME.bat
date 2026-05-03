@echo off
setlocal enabledelayedexpansion

if exist .env (
    for /f "tokens=*" %%i in (.env) do (
        set "%%i"
    )
) else (
    echo Errore: .env not found.
    pause
    exit /b
)

%LINKER_DISK_PATH%

cd "%CODWAW_PATH%\"

START "" CoDWaW_LanFixed.exe +set fs_game "mods/CampaignEnhanced" +set r_fullscreen 0 +set r_mode "1280x720" +set developer 2 +set ui_showList 1 +exec "default_controller.cfg"

exit /b