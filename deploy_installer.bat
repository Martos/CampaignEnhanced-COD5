@echo off

echo Copy files ..

xcopy /S /I /Q /Y /F "%localappdata%\Activision\CodWaW\mods\CampaignEnhanced" "%WORKDIR_PATH%\CampaignEnhanced"
xcopy /S /I /Q /Y /F "%CODWAW_PATH%\d3d9.dll" "%WORKDIR_PATH%"

makensis CE_installer_nsis_script.nsi

echo Done.
echo Cleaning ..

rmdir /Q /S CampaignEnhanced
del /Q d3d9.dll

echo Done.

pause

exit /b