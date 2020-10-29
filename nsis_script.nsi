; RunnerInstaller.nsi
 
;---------------------------------------------------------------------------------------------------
;
; Usable Variables Index
;
; ${PRODUCT_NAME}          = Name of the game, as defined by project name
; ${PRODUCT_PUBLISHER}     = Company name
; ${FILE_DESC}             = Description of the game
; ${FULL_VERSION}          = Full version of the game, e.g. 1.0.0.0
; ${COPYRIGHT_TXT}         = Copyright info
; ${MAKENSIS}              = NSIS directory, usually "<GameMaker Studio Folder>\makensis"
; ${LICENSE_NAME}          = License file
; ${ICON_FILE}             = Executable icon file
; ${PRODUCT_HELP_URL}      = (Optional) Your game's help/distribution website
; ${PRODUCT_HELP_TITLE}    = (Optional) Help url title, used for filename in Start Menu shortcut
; ${PRODUCT_SUPPORT_URL}   = (Optional) Your game's/company's website
; ${PRODUCT_SUPPORT_TITLE} = (Optional) Support url title, used for filename in Start Menu shortcut
;  
;---------------------------------------------------------------------------------------------------
 
; Required Includes
!include MUI2.nsh
 
; Scan for NSIS plugins
!AddPluginDir "."
 
; The default installation directory (Only uncomment one of the following)
!define INSTALL_DIRECTORY "$PROFILE\${PRODUCT_NAME}"                           ; Install in Users/Username/
;!define INSTALL_DIRECTORY "$PROGRAMFILES\${PRODUCT_PUBLISHER}\${PRODUCT_NAME}" ; Install in Program Files/Company Name/Game Name/
;!define INSTALL_DIRECTORY "$PROGRAMFILES\${PRODUCT_NAME}"                      ; Install in Program Files/Game Name/
 
; Optional extra info values
!define PRODUCT_HELP_TITLE    "${PRODUCT_NAME} Website" ; Help/distribution url title
!define PRODUCT_HELP_URL      "" ; Your game's help/distribution url
 
!define PRODUCT_SUPPORT_TITLE "${PRODUCT_PUBLISHER} Website" ; Support url title
!define PRODUCT_SUPPORT_URL   "" ; Your game's url, could be your company's website
 
!define PRODUCT_COMMENTS      "" ; Comments, they appear on the Programs Add and Remove list
 
; The file to write
OutFile "${INSTALLER_FILENAME}"
 
; The name of the installer
Name "${PRODUCT_NAME}"
 
; Text caption for Installer/Uninstaller window title and dialogs
Caption "${PRODUCT_NAME} Setup"
UninstallCaption "Uninstall ${PRODUCT_NAME}"
 
; Branding text, appears on bottom separator
BrandingText "${PRODUCT_NAME}"
 
; Set default installation directory
InstallDir "${INSTALL_DIRECTORY}"
 
; Check the App Path, if the game is already installed, it will use the stored path as default install directory
!define PRODUCT_APPPATH "Software\Microsoft\Windows\CurrentVersion\App Paths\${PRODUCT_NAME}"
InstallDirRegKey HKLM "${PRODUCT_APPPATH}" ""
 
; Request administrator application privileges for Windows Vista and later
RequestExecutionLevel admin
 
; Add Version Information to installer executable
VIProductVersion "${FULL_VERSION}"
VIAddVersionKey /LANG=1033 "FileVersion"     "${FULL_VERSION}"
VIAddVersionKey /LANG=1033 "ProductVersion"  "${FULL_VERSION}"
VIAddVersionKey /LANG=1033 "ProductName"     "${PRODUCT_NAME}"
VIAddVersionKey /LANG=1033 "CompanyName"     "${PRODUCT_PUBLISHER}"
VIAddVersionKey /LANG=1033 "LegalCopyright"  "${COPYRIGHT_TXT}"
VIAddVersionKey /LANG=1033 "FileDescription" "${FILE_DESC}"
 
; Installer options and variables
!define MUI_HEADERIMAGE
!define MUI_HEADERIMAGE_BITMAP_NOSTRETCH
!define MUI_ICON                               "${ICON_FILE}"
!define MUI_UI_HEADERIMAGE_RIGHT               "${IMAGE_FINISHED}"
!define MUI_WELCOMEFINISHPAGE_BITMAP           "${IMAGE_FINISHED}"
!define MUI_HEADERIMAGE_BITMAP                 "${IMAGE_HEADER}"
!define MUI_WELCOMEFINISHPAGE_BITMAP_NOSTRETCH
 
; Custom uninstaller icon
;!define MUI_UNICON "${ICON_FILE}"
 
; Details visible or hidden (show = visible, hide = collapsed)
ShowInstDetails show
ShowUninstDetails show
 
; Variable to hold DirectX Setup error
Var DirectXSetupError
 
;--------------------------------
; Installer Pages
;--------------------------------
 
!insertmacro MUI_PAGE_WELCOME                   ; Introductory page (Optional)
!insertmacro MUI_PAGE_LICENSE "${LICENSE_NAME}" ; License agreement
!insertmacro MUI_PAGE_COMPONENTS                ; Component selection, shortcuts
!insertmacro MUI_PAGE_DIRECTORY                 ; Installation directory selection page
!insertmacro MUI_PAGE_INSTFILES                 ; Install progress page
   
    ; These indented statements modify settings for finish page
    !define MUI_FINISHPAGE_NOAUTOCLOSE ; don't autoclose the installer when done
    !define MUI_FINISHPAGE_RUN_TEXT "Run ${PRODUCT_NAME}" ; option for launching the game afterwards
    !define MUI_FINISHPAGE_RUN "$INSTDIR\${PRODUCT_NAME}.exe" ; path for the executable to run (default is the game exe)
   
!insertmacro MUI_PAGE_FINISH                    ; Installation done page
 
 
;--------------------------------
; Uninstaller Pages
;--------------------------------
 
!insertmacro MUI_UNPAGE_INSTFILES ; Uninstaller progress page
 
 
;--------------------------------
; Language
;--------------------------------
 
!insertmacro MUI_LANGUAGE "English"
 
 
;--------------------------------
; Installer
;--------------------------------
 
; Main Application component (required)
Section "${PRODUCT_NAME}" SEC_APPLICATION
 
    ; Make this component required
    SectionIn RO
 
    ; Set output path to the installation directory
    SetOutPath $INSTDIR
 
    ; Put file in installation directory
    File "${LICENSE_NAME}"
    File /r "${SOURCE_DIR}\*.*"
   
    ; Load up files necessary for getting filesize
    !include "${MAKENSIS}\Include\Util.nsh"
    !include "${MAKENSIS}\Include\FileFunc.nsh"
 
    ; Get estimated filesize
    ${GetSize} "$INSTDIR" "/S=0K" $0 $1 $2
    IntFmt $0 "0x%08X" $0
   
    ; Create uninstaller executable
    WriteUninstaller "Uninstall.exe"
   
    ; Register the application in the Windows AppPath
    WriteRegStr HKLM "${PRODUCT_APPPATH}" "" "$INSTDIR"
   
    ; Write the uninstall keys for Windows
    WriteRegStr SHCTX "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}" "DisplayName" "${PRODUCT_NAME}"
    WriteRegStr SHCTX "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}" "Publisher" "${PRODUCT_PUBLISHER}"
    WriteRegStr SHCTX "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}" "UninstallString" "$INSTDIR\Uninstall.exe"
    WriteRegStr SHCTX "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}" "DisplayVersion" "${FULL_VERSION}"
    WriteRegStr SHCTX "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}" "DisplayIcon" "$INSTDIR\${PRODUCT_NAME}.exe"
    WriteRegDWORD SHCTX "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}" "EstimatedSize" "$0"
    WriteRegDWORD SHCTX "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}" "NoModify" 1
    WriteRegDWORD SHCTX "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}" "NoRepair" 1
   
    ; Optional info
    ${If} "${PRODUCT_HELP_URL}" != ""
        WriteRegStr SHCTX "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}" "HelpLink" "${PRODUCT_HELP_URL}"
    ${EndIf}
    ${If} "${PRODUCT_SUPPORT_URL}" != ""
        WriteRegStr SHCTX "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}" "UrlInfoAbout" "${PRODUCT_SUPPORT_URL}"
    ${EndIf}
    ${If} "${PRODUCT_COMMENTS}" != ""
        WriteRegStr SHCTX "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}" "Comments" "${PRODUCT_COMMENTS}"
    ${EndIf}
 
SectionEnd
 
; DirectX installer component
Section "DirectX Install" SEC_DIRECTX
 
    ; Make this component required
    SectionIn RO
   
    SetOutPath "$TEMP"
    File "${MAKENSIS}\dxwebsetup.exe"
    DetailPrint "Installing Microsoft DirectX®..."
    ExecWait '"$TEMP\dxwebsetup.exe" /Q' $DirectXSetupError
    DetailPrint "Finished Microsoft DirectX® Setup"
    Delete "$TEMP\dxwebsetup.exe"
    ${If} $DirectXSetupError != "0"
        DetailPrint "Microsoft DirectX® was not installed correctly"
    ${Else}
        DetailPrint "Microsoft DirectX® was successfully installed"       
    ${EndIf}
   
    SetOutPath "$INSTDIR"
 
SectionEnd
 
 
 
; Desktop shortcut component
; !! Note: Add /o to force the shortcut option unchecked, e.g. Section /o "Desktop Shortcut" SEC_DESKTOP_SHORTCUT
Section "Desktop Shortcut" SEC_DESKTOP_SHORTCUT
    CreateShortCut "$DESKTOP\${EXE_NAME}.lnk" "$INSTDIR\${EXE_NAME}.exe" ""
SectionEnd
 
; Start menu shortcuts component
; !! Note: Add /o to force the shortcut option unchecked, e.g. Section /o "Start Menu Shortcuts" SEC_STARTMENU_SHORTCUT
Section "Start Menu Shortcuts" SEC_STARTMENU_SHORTCUT
 
  ; Create shortcuts in Start Menu
  CreateDirectory "$SMPROGRAMS\${EXE_NAME}"
  CreateShortCut "$SMPROGRAMS\${EXE_NAME}\Uninstall.lnk" "$INSTDIR\Uninstall.exe" "" "$INSTDIR\Uninstall.exe" 0
  CreateShortCut "$SMPROGRAMS\${EXE_NAME}\${EXE_NAME}.lnk" "$INSTDIR\${EXE_NAME}.exe" "" "$INSTDIR\${EXE_NAME}.exe"
  CreateShortCut "$SMPROGRAMS\${EXE_NAME}\${EXE_NAME} License.lnk" "notepad.exe" "$INSTDIR\License.txt"
 
  ; Optional website links (auto-created if you fill in the URL values at the top of this script)
  ${If} "${PRODUCT_HELP_URL}" != ""
    WriteINIStr "$SMPROGRAMS\${PRODUCT_NAME}\${PRODUCT_HELP_TITLE}.url" "InternetShortcut" "URL" "${PRODUCT_HELP_URL}"
  ${EndIf}
  ${If} "${PRODUCT_SUPPORT_URL}" != ""
    WriteINIStr "$SMPROGRAMS\${PRODUCT_NAME}\${PRODUCT_SUPPORT_TITLE}.url" "InternetShortcut" "URL" "${PRODUCT_SUPPORT_URL}"
  ${EndIf}
 
SectionEnd
 
; Component Descriptions
LangString DESC_SEC01 ${LANG_ENGLISH} "This will install ${PRODUCT_NAME}. Required."
LangString DESC_SEC02 ${LANG_ENGLISH} "This will install Microsoft DirectX®. Required."
LangString DESC_SEC03 ${LANG_ENGLISH} "This will create a shortcut for ${PRODUCT_NAME} on the Desktop."
LangString DESC_SEC04 ${LANG_ENGLISH} "This will create shortcuts for ${PRODUCT_NAME} on the Start Menu."
 
!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
    !insertmacro MUI_DESCRIPTION_TEXT ${SEC_APPLICATION} $(DESC_SEC01)
    !insertmacro MUI_DESCRIPTION_TEXT ${SEC_DIRECTX} $(DESC_SEC02)
    !insertmacro MUI_DESCRIPTION_TEXT ${SEC_DESKTOP_SHORTCUT} $(DESC_SEC03)
    !insertmacro MUI_DESCRIPTION_TEXT ${SEC_STARTMENU_SHORTCUT} $(DESC_SEC04)
!insertmacro MUI_FUNCTION_DESCRIPTION_END
 
 
;--------------------------------
; Uninstaller
;--------------------------------
 
Section "Uninstall"
   
    ; Remove registry keys
    DeleteRegKey SHCTX "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"
    DeleteRegKey HKLM "${PRODUCT_APPPATH}"
   
    ; Remove files and uninstaller
    RMDir /r "$INSTDIR"
   
    ; Remove desktop icon, if any
    Delete "$DESKTOP\${EXE_NAME}.lnk"
   
    ; Remove start menu shortcuts, if any
    Delete "$SMPROGRAMS\${EXE_NAME}\*.*"
   
    ; Remove directories used
    RMDir "$SMPROGRAMS\${EXE_NAME}"
    RMDir "$INSTDIR"
   
SectionEnd
 
; Show confirmation message before uninstall
Function un.onInit
  MessageBox MB_ICONQUESTION|MB_YESNO|MB_DEFBUTTON2 "Are you sure that you want to completely remove ${PRODUCT_NAME} and all of its components?" IDYES +2
  Abort
FunctionEnd
 
; Show info message after uninstall
Function un.onuninstSuccess
  MessageBox MB_ICONINFORMATION|MB_OK "${PRODUCT_NAME} was successfully removed from your computer."
FunctionEnd