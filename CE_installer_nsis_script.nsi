;--------------------------------
;Include Modern UI

  !include "MUI2.nsh"

;--------------------------------
;General

  ;Name and file
  Name "CampaignEnhanced"
  OutFile "CampaignEnhanced Setup.exe"
  Unicode True

  ;Default installation folder
  InstallDir "$LOCALAPPDATA\Activision\CodWaW\mods\CampaignEnhanced"
  
  ;Get installation folder from registry if available
  InstallDirRegKey HKCU "Software\WaW-Campaign-Enhanced" ""

  ;Request application privileges for Windows Vista
  RequestExecutionLevel user

;--------------------------------
;Interface Settings

  !define MUI_ABORTWARNING

;--------------------------------
;Pages

  !insertmacro MUI_PAGE_COMPONENTS
  !insertmacro MUI_PAGE_DIRECTORY
  !insertmacro MUI_PAGE_INSTFILES
  
  !insertmacro MUI_UNPAGE_CONFIRM
  !insertmacro MUI_UNPAGE_INSTFILES
  
;--------------------------------
;Languages
 
  !insertmacro MUI_LANGUAGE "English"

;--------------------------------
;Installer Sections

Section "Campaign Enhanced" SecDummy

  SectionIn RO

  SetOutPath "$INSTDIR"
  
  ;ADD YOUR OWN FILES HERE...
  File /nonfatal /a /r "CampaignEnhanced\"
  
  ;Store installation folder
  WriteRegStr HKCU "Software\WaW-Campaign-Enhanced" "" $INSTDIR
  
  ;Create uninstaller
  WriteUninstaller "$INSTDIR\Uninstall.exe"

SectionEnd

;--------------------------------
;Descriptions

  ;Language strings
  LangString DESC_SecDummy ${LANG_ENGLISH} "Mod files"

  ;Assign language strings to sections
  !insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
    !insertmacro MUI_DESCRIPTION_TEXT ${SecDummy} $(DESC_SecDummy)
  !insertmacro MUI_FUNCTION_DESCRIPTION_END

;--------------------------------
;Uninstaller Section

Section "Uninstall"

  ;ADD YOUR OWN FILES HERE...

  Delete "$INSTDIR\Uninstall.exe"

  RMDir "$INSTDIR"

  DeleteRegKey /ifempty HKCU "Software\WaW-Campaign-Enhanced"

SectionEnd