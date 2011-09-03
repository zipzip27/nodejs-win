;NodeJS Installer Script
;Written by Bangon Kali.
;https://code.google.com/p/nodejs-win/

;--------------------------------
;Includes
   
  !include "MUI2.nsh"            ; Modern UI
  !include "EnvVarUpdate.nsh"    ; http://j.mp/reuJ0J
  !include "winmessages.nsh"     ; Environ Variables.

  
;--------------------------------
;General

  ;Name and file
  Name "NodeJS"
  OutFile "node_setup_win7.exe"

  ;Default installation folder
  InstallDir "$PROGRAMFILES\NodeJS"

  ;Get installation folder from registry if available
  InstallDirRegKey HKCU "Software\NodeJS" ""

  ;Request application privileges for Windows Vista
  RequestExecutionLevel highest

;--------------------------------
;Version Information

  VIProductVersion "1.0.0.1"
  VIAddVersionKey /LANG=${LANG_ENGLISH} "ProductName" "NodeJS"
  VIAddVersionKey /LANG=${LANG_ENGLISH} "Comments" "This is a simple NodeJS Install Package for Windows"
  VIAddVersionKey /LANG=${LANG_ENGLISH} "CompanyName" "Joyent"
  VIAddVersionKey /LANG=${LANG_ENGLISH} "LegalTrademarks" "Node.js is a trademark of Joyent, Inc. See the trademark policy for more information."
  VIAddVersionKey /LANG=${LANG_ENGLISH} "LegalCopyright" "Copyright 2010 Joyent, Inc "
  VIAddVersionKey /LANG=${LANG_ENGLISH} "FileDescription" "NodeJS is a JavaScript interpreter. Visit nodejs.org for more information. This is a simple package installer for Windows."
  VIAddVersionKey /LANG=${LANG_ENGLISH} "FileVersion" "1.0.0"  

;--------------------------------
;Variables

  Var StartMenuFolder
  
;--------------------------------
;Interface Settings

  !define MUI_ABORTWARNING
   
;--------------------------------
;Pages

  !insertmacro MUI_PAGE_WELCOME
  !insertmacro MUI_PAGE_LICENSE "license.rtf"
  !insertmacro MUI_PAGE_COMPONENTS
  !insertmacro MUI_PAGE_DIRECTORY
  !insertmacro MUI_PAGE_INSTFILES
  !insertmacro MUI_PAGE_FINISH
  
  ;Start Menu Folder Page Configuration
  !define MUI_STARTMENUPAGE_REGISTRY_ROOT "HKCU" 
  !define MUI_STARTMENUPAGE_REGISTRY_KEY "Software\NodeJS" 
  !define MUI_STARTMENUPAGE_REGISTRY_VALUENAME "Start Menu Folder"
  
  ; HKLM (all users) vs HKCU (current user) defines
  !define env_hklm 'HKLM "SYSTEM\CurrentControlSet\Control\Session Manager\Environment"'
  !define env_hkcu 'HKCU "Environment"'
  
  !insertmacro MUI_PAGE_STARTMENU Application $StartMenuFolder
  
  !insertmacro MUI_UNPAGE_WELCOME
  !insertmacro MUI_UNPAGE_CONFIRM
  !insertmacro MUI_UNPAGE_INSTFILES
  !insertmacro MUI_UNPAGE_FINISH

;--------------------------------
;Languages

  !insertmacro MUI_LANGUAGE "English"

;--------------------------------
;Installer Sections

Section "Full Install" SecInstallation

  SetOutPath "$INSTDIR"

  ;ADD YOUR OWN FILES HERE...
  File node.exe
  File /r node_modules
  
  ;Store installation folder
  WriteRegStr HKCU "Software\NodeJS" "" $INSTDIR

  ;Create uninstaller
  WriteUninstaller "$INSTDIR\Uninstall.exe"
  
  !insertmacro MUI_STARTMENU_WRITE_BEGIN Application
    
    ;Create shortcuts
    CreateDirectory "$SMPROGRAMS\$StartMenuFolder"
    CreateShortCut "$SMPROGRAMS\$StartMenuFolder\Uninstall.lnk" "$INSTDIR\Uninstall.exe"
    CreateShortCut "$SMPROGRAMS\$StartMenuFolder\NodeJS.lnk" "$INSTDIR\node.exe"
  
  !insertmacro MUI_STARTMENU_WRITE_END
  
  ;Append to Path
  ${EnvVarUpdate} $0 "PATH" "A" "HKLM" "$INSTDIR"
  
  ; set variable
  WriteRegExpandStr ${env_hklm} "NODE_PATH" "$INSTDIR\node_modules"
  ; make sure windows knows about the change
  SendMessage ${HWND_BROADCAST} ${WM_WININICHANGE} 0 "STR:Environment" /TIMEOUT=5000
  
SectionEnd

;--------------------------------
;Descriptions

  ;Language strings
  LangString DESC_SecInstallation ${LANG_ENGLISH} "Full NodeJS Installation, Including MySQL and Socket.IO."

  ;Assign language strings to sections
  !insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
    !insertmacro MUI_DESCRIPTION_TEXT ${SecInstallation} $(DESC_SecInstallation)
  !insertmacro MUI_FUNCTION_DESCRIPTION_END

;--------------------------------
;Uninstaller Section

Section "Uninstall"
  SetOutPath $TEMP

  ;--------------------------------
  ; Delete files and folders

  Delete "$INSTDIR\Uninstall.exe"
  Delete "$INSTDIR\node.exe"
  
  RMDir /r "$INSTDIR\node_modules"
  RMDir "$INSTDIR"
  
  ;--------------------------------
  ;Remove Start Menu
  !insertmacro MUI_STARTMENU_GETFOLDER Application $StartMenuFolder

  Delete "$SMPROGRAMS\$StartMenuFolder\Uninstall.lnk"
  Delete "$SMPROGRAMS\$StartMenuFolder\NodeJS.lnk"
  RMDir "$SMPROGRAMS\$StartMenuFolder"  
  
  ;--------------------------------
  ; Delete registry key settings
  
  DeleteRegKey /ifempty HKCU "Software\NodeJS"
  
  ;--------------------------------
  ; Remove environment variable settings!
  
  ; Remove path
  ${un.EnvVarUpdate} $0 "PATH" "R" "HKLM" "$INSTDIR"
  
  ; delete variable
  DeleteRegValue ${env_hklm} NODE_PATH
  ; make sure windows knows about the change
  SendMessage ${HWND_BROADCAST} ${WM_WININICHANGE} 0 "STR:Environment" /TIMEOUT=5000
  
SectionEnd
