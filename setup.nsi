;NodeJS Installer Script
;Written by Bangon Kali.
;https://code.google.com/p/NodeJS-win/

;--------------------------------
;Includes
   
  !include "MUI2.nsh"            ; Modern UI
  !include "EnvVarUpdate.nsh"    ; http://j.mp/reuJ0J
  !include "winmessages.nsh"     ; Environ Variables.

  
;--------------------------------
;General

  ;Name and file
  !define VERSION_NODE "0.5.6"
  !define VERSION_PACKAGE "4"
  
  Name "NodeJS ${VERSION_NODE}.${VERSION_PACKAGE}"
  OutFile "..\node\node_setup_${VERSION_NODE}.${VERSION_PACKAGE}.exe"

  ;Default installation folder
  InstallDir "$PROGRAMFILES\NodeJS"

  ;Get installation folder from registry if available
  InstallDirRegKey HKCU "Software\NodeJS" ""

  ;Request application privileges for Windows Vista
  RequestExecutionLevel highest

;--------------------------------
;Version Information

  VIProductVersion "${VERSION_NODE}.${VERSION_PACKAGE}"
  VIAddVersionKey /LANG=${LANG_ENGLISH} "ProductName" "NodeJS ${VERSION_NODE}"
  VIAddVersionKey /LANG=${LANG_ENGLISH} "Comments" "This is a simple NodeJS Install Package for Windows"
  VIAddVersionKey /LANG=${LANG_ENGLISH} "CompanyName" "Joyent"
  VIAddVersionKey /LANG=${LANG_ENGLISH} "LegalTrademarks" "Node.js ${VERSION_NODE} is a trademark of Joyent, Inc. See the trademark policy for more information."
  VIAddVersionKey /LANG=${LANG_ENGLISH} "LegalCopyright" "Copyright 2010 Joyent, Inc "
  VIAddVersionKey /LANG=${LANG_ENGLISH} "FileDescription" "NodeJS ${VERSION_NODE} is a JavaScript interpreter. Visit NodeJS.org for more information. This is a simple package installer for Windows."
  VIAddVersionKey /LANG=${LANG_ENGLISH} "FileVersion" "${VERSION_NODE}"


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
  SetOverwrite on

   
  ; Change the output directory to 
  SetOutPath "$INSTDIR"
  File node.exe
  
  SetOutPath "$INSTDIR\node_modules"
  File /a /r node_modules\*.*
  
  ; The go to the documents
  SetOutPath "$DOCUMENTS\NodeJS\Examples"
  
  ; Install the examples folder
  File /a /r examples\*.*
  
  ;Store installation folder
  WriteRegStr HKCU "Software\NodeJS" "" $INSTDIR

  ;Create uninstaller
  WriteUninstaller "$INSTDIR\Uninstall.exe"
  
  ; Start menu stuff
  !insertmacro MUI_STARTMENU_WRITE_BEGIN Application
    
    ;Create shortcuts
    CreateDirectory "$SMPROGRAMS\$StartMenuFolder"
    CreateShortCut "$SMPROGRAMS\$StartMenuFolder\Uninstall.lnk" "$INSTDIR\Uninstall.exe"
    CreateShortCut "$SMPROGRAMS\$StartMenuFolder\NodeJS.lnk" "$INSTDIR\node.exe"
    CreateShortCut "$SMPROGRAMS\$StartMenuFolder\Examples.lnk" "$DOCUMENTS\NodeJS\Examples"
    
  !insertmacro MUI_STARTMENU_WRITE_END
  
  ; Append to Path
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
  Delete "$SMPROGRAMS\$StartMenuFolder\Examples.lnk"
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
