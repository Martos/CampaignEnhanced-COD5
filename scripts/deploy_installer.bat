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

echo Copy files ..

xcopy /S /I /Q /Y /F "%localappdata%\Activision\CodWaW\mods\CampaignEnhanced" "%WORKDIR_PATH%\CampaignEnhanced"
xcopy /S /I /Q /Y /F "%CODWAW_PATH%\d3d9.dll" "%WORKDIR_PATH%"

makensis CE_installer_nsis_script.nsi

echo Done.
echo Cleaning ..

rmdir /Q /S CampaignEnhanced
del /Q d3d9.dll

echo Done.

exit /b