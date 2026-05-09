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

rmdir /s /q "%CODWAW_PATH%\mods\CampaignEnhanced"
mkdir "%CODWAW_PATH%\mods\CampaignEnhanced"

xcopy %WORKDIR_PATH%\raw\*.* "%CODWAW_PATH%\raw\" /Y /E /H /C /I
xcopy %WORKDIR_PATH%\zone_source\*.* "%CODWAW_PATH%\zone_source\" /Y /E /H /C /I
xcopy %WORKDIR_PATH%\source_data\*.* "%CODWAW_PATH%\source_data\" /Y /E /H /C /I
xcopy %WORKDIR_PATH%\mods\CampaignEnhanced\*.* "%CODWAW_PATH%\mods\CampaignEnhanced\" /Y /E /H /C /I

exit /b