;--------------------------------
;Include Modern UI
  !include "MUI2.nsh"
  !include "LogicLib.nsh"

  !define MUI_ICON ".\screens\CoDWaW_ID_ICON1_0-00-00-002.ico"
  !define MUI_HEADERIMAGE
  !define MUI_HEADERIMAGE_BITMAP ".\screens\cod.bmp"
  !define MUI_HEADERIMAGE_RIGHT

;--------------------------------
;General

  Name "Campaign Enhanced"
  OutFile "Campaign Enhanced Setup.exe"
  Unicode True

  RequestExecutionLevel admin

  InstallDirRegKey HKLM "SOFTWARE\WOW6432Node\Activision\Call of Duty WAW" "installpath"

  Var /GLOBAL InstDirB

;--------------------------------
;Interface Settings

  !define MUI_ABORTWARNING

;--------------------------------
;Pages

  !insertmacro MUI_PAGE_WELCOME
  !insertmacro MUI_PAGE_COMPONENTS
  !insertmacro MUI_PAGE_DIRECTORY 
  !insertmacro MUI_PAGE_INSTFILES
  
;--------------------------------
;Languages
 
  !insertmacro MUI_LANGUAGE "English"

;--------------------------------
;Installer Sections

Section "T4M" SecT4m
  SectionIn RO
  
  SetOutPath "$INSTDIR"
  
  IfFileExists "$INSTDIR\CoDWaW.exe" 0 +3
    File /nonfatal /a /r "d3d9.dll"
    Goto done
    
  MessageBox MB_ICONSTOP "Call of Duty: World at War non trovato in: $INSTDIR. $\r$\nInstallazione T4M annullata."
  
  done:
SectionEnd

Section "Campaign Enhanced" SecDummy
  StrCpy $InstDirB "$LOCALAPPDATA\Activision\CodWaW\mods\CampaignEnhanced"
  SectionIn RO
  SetOutPath "$InstDirB"
  File /nonfatal /a /r "CampaignEnhanced\"
SectionEnd

;--------------------------------
;Descriptions

  LangString DESC_SecDummy ${LANG_ENGLISH} "Mod files"
  LangString DESC_SecT4m ${LANG_ENGLISH} "T4M Support"

  !insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
    !insertmacro MUI_DESCRIPTION_TEXT ${SecDummy} $(DESC_SecDummy)
    !insertmacro MUI_DESCRIPTION_TEXT ${SecT4m} $(DESC_SecT4m)
  !insertmacro MUI_FUNCTION_DESCRIPTION_END