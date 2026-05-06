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

rmdir /s /q "%CODWAW_PATH%\mods\CampaignEnhanced\weapons\"
rmdir /s /q "%CODWAW_PATH%\mods\CampaignEnhanced\sound\"
rmdir /s /q "%CODWAW_PATH%\mods\CampaignEnhanced\materials\"

del "%CODWAW_PATH%\mods\CampaignEnhanced\CampaignEnhanced.iwd"
del "%CODWAW_PATH%\mods\CampaignEnhanced\mod.csv"
del "%CODWAW_PATH%\mods\CampaignEnhanced\mod.arena"

xcopy %WORKDIR_PATH%\raw\*.* "%CODWAW_PATH%\raw\" /Y /E /H /C /I
xcopy %WORKDIR_PATH%\zone_source\*.* "%CODWAW_PATH%\zone_source\" /Y /E /H /C /I
xcopy %WORKDIR_PATH%\mods\CampaignEnhanced\weapons\*.* "%CODWAW_PATH%\mods\CampaignEnhanced\weapons\" /Y /E /H /C /I
xcopy %WORKDIR_PATH%\mods\CampaignEnhanced\sound\*.* "%CODWAW_PATH%\mods\CampaignEnhanced\sound\" /Y /E /H /C /I
xcopy %WORKDIR_PATH%\mods\CampaignEnhanced\materials\*.* "%CODWAW_PATH%\mods\CampaignEnhanced\materials\" /Y /E /H /C /I

copy /Y "%WORKDIR_PATH%\mods\CampaignEnhanced\mod.csv" "%CODWAW_PATH%\mods\CampaignEnhanced"
copy /Y "%WORKDIR_PATH%\mods\CampaignEnhanced\mod.arena" "%CODWAW_PATH%\mods\CampaignEnhanced"

exit /b