;--------------------------------
;Include Modern UI

  !include "MUI2.nsh"

  !define MUI_ICON ".\screens\CoDWaW_ID_ICON1.ico"
  !define MUI_HEADERIMAGE
  !define MUI_HEADERIMAGE_BITMAP ".\screens\cod.bmp"
  !define MUI_HEADERIMAGE_RIGHT

;--------------------------------
;General

  ;Name and file
  Name "Campaign Enhanced"
  OutFile "Campaign Enhanced Setup.exe"
  Unicode True

  Var /GLOBAL InstDirB

  ;Request application privileges for Windows Vista
  RequestExecutionLevel user

;--------------------------------
;Interface Settings

  !define MUI_ABORTWARNING

;--------------------------------
;Pages

  !insertmacro MUI_PAGE_COMPONENTS
  !insertmacro MUI_PAGE_INSTFILES
  
;--------------------------------
;Languages
 
  !insertmacro MUI_LANGUAGE "English"

;--------------------------------
;Installer Sections

Section "Campaign Enhanced" SecDummy

  StrCpy $InstDirB "$LOCALAPPDATA\Activision\CodWaW\mods\CampaignEnhanced"
  SectionIn RO
  SetOutPath "$InstDirB"
  File /nonfatal /a /r "CampaignEnhanced\"

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