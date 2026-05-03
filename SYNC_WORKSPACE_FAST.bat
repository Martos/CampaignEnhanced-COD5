@echo off

xcopy %WORKDIR_PATH%\raw\*.* "%CODWAW_PATH%\raw\" /Y /E /H /C /I
xcopy %WORKDIR_PATH%\zone_source\*.* "%CODWAW_PATH%\zone_source\" /Y /E /H /C /I
xcopy %WORKDIR_PATH%\mods\CampaignEnhanced\weapons\*.* "%CODWAW_PATH%\mods\CampaignEnhanced\weapons\" /Y /E /H /C /I
xcopy %WORKDIR_PATH%\mods\CampaignEnhanced\sound\*.* "%CODWAW_PATH%\mods\CampaignEnhanced\sound\" /Y /E /H /C /I

exit /b