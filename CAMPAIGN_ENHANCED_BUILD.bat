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

copy /Y "%CODWAW_PATH%\mods\CampaignEnhanced\mod.csv" "%CODWAW_PATH%\zone_source\mod.csv"

cd "%CODWAW_PATH%\bin"

linker_pc.exe -nopause -language %LANGUAGE% -moddir CampaignEnhanced mod

cd "%CODWAW_PATH%\mods\CampaignEnhanced"

"%CODWAW_PATH%\bin\7za.exe" a "%CODWAW_PATH%\mods\CampaignEnhanced\CampaignEnhanced.iwd" -tzip -r "%CODWAW_PATH%\mods\CampaignEnhanced\sound"
"%CODWAW_PATH%\bin\7za.exe" a "%CODWAW_PATH%\mods\CampaignEnhanced\CampaignEnhanced.iwd" -tzip -r "%CODWAW_PATH%\mods\CampaignEnhanced\weapons"

mkdir %WORKDIR_PATH%\dist
mkdir %WORKDIR_PATH%\dist\%LANGUAGE%
mkdir %WORKDIR_PATH%\dist\%LANGUAGE%\CampaignEnhanced

copy /Y "%CODWAW_PATH%\zone\%LANGUAGE%\mod.ff" "%WORKDIR_PATH%\dist\%LANGUAGE%\CampaignEnhanced"
copy /Y "%CODWAW_PATH%\mods\CampaignEnhanced\CampaignEnhanced.iwd" "%WORKDIR_PATH%\dist\%LANGUAGE%\CampaignEnhanced"
copy /Y "%CODWAW_PATH%\mods\CampaignEnhanced\mod.arena" "%WORKDIR_PATH%\dist\%LANGUAGE%\CampaignEnhanced"
Xcopy %WORKDIR_PATH%\dist\%LANGUAGE%\CampaignEnhanced %localappdata%\Activision\CodWaW\mods\CampaignEnhanced /Y /E /H /C /I

exit /b
