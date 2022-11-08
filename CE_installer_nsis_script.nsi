;--------------------------------
;Include Modern UI

  !include "MUI2.nsh"

  !define MUI_ICON ".\screens\CoDWaW_ID_ICON1_0-00-00-002.ico"
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

Section "T4M" SecT4m

  SectionIn RO
  ReadRegStr $0 HKLM "SOFTWARE\WOW6432Node\Activision\Call of Duty WAW" "installpath"
  ${If} $0 == ""
    MessageBox MB_ICONINFORMATION "Not valid Call of Duty World at War installation find. $\r$\nPlease install T4M manually"
  ${Else}
    SetOutPath "$0"
    File /nonfatal /a /r "d3d9.dll"
  ${EndIf}

SectionEnd

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
  LangString DESC_SecT4m ${LANG_ENGLISH} "T4M Support"

  ;Assign language strings to sections
  !insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
    !insertmacro MUI_DESCRIPTION_TEXT ${SecDummy} $(DESC_SecDummy)
    !insertmacro MUI_DESCRIPTION_TEXT ${SecT4m} $(DESC_SecT4m)
  !insertmacro MUI_FUNCTION_DESCRIPTION_END

;--------------------------------