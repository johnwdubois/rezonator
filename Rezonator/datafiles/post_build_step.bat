@echo off

:: Useful for printing all variables
:: set

:: ########################################### EDIT VARIABLES ###########################################

:: Replace with your steamworks sdk path (download from here: https://partner.steamgames.com/doc/sdk)
set STEAM_SDK_PATH=%~dp0..\steamworks_sdk

:: ######################################################################################################

:: Ensure the path ends with a backslash
if not %STEAM_SDK_PATH:~-1% == \ (
   set SDK_PATH=%STEAM_SDK_PATH%\
) else (
   set SDK_PATH=%STEAM_SDK_PATH%
)

:: Ensure the directory exists
if not exist "%SDK_PATH%" goto error_incorrect_STEAMWORKS_path

:: Ensure we are on the output path
pushd "%YYoutputFolder%"

:: Call setup method depending on the platform
:: NOTE: the setup method can be (:Windows_copy_dependencies, :MacOS_copy_dependencies or :Ubuntu_copy_dependencies)
call :%YYPLATFORM_name%_copy_dependencies
if ERRORLEVEL 1 (
    echo ""
    echo "#################################### INFORMATION #####################################"
    echo "Steam Extension is not available in this target: %YYPLATFORM_name% (no setup required)"
    echo "######################################################################################"
    echo ""
)
popd

:exit
exit /b 0

:: ----------------------------------------------------------------------------------------------------
:Windows_copy_dependencies
   if "%YYPLATFORM_option_windows_use_x64%" == "True" (
      echo "Copying Windows (64 bit) dependencies"
      if not exist "steam_api64.dll" copy "%SDK_PATH%redistributable_bin\win64\steam_api64.dll" "steam_api64.dll"
   ) else (
      echo "Copying Windows (32 bit) dependencies"
      if not exist "steam_api.dll" copy "%SDK_PATH%redistributable_bin\steam_api.dll" "steam_api.dll"
   )
   if ERRORLEVEL 1 call :exitError
goto :eof

:: ----------------------------------------------------------------------------------------------------
:macOS_copy_dependencies
   echo "Copying macOS (64 bit) dependencies"
   if "%YYTARGET_runtime%" == "VM" (

      :: This is used for VM
      powershell Expand-Archive '%YYprojectName%.zip' _temp\
      copy /y "%SDK_PATH%redistributable_bin\osx\libsteam_api.dylib" "_temp\assets\libsteam_api.dylib"
      powershell Compress-Archive -Force _temp\* '%YYprojectName%.zip'
      rmdir /s /q _temp

   ) else (

      :: This is used from YYC compilation
      copy "%SDK_PATH%redistributable_bin\osx\libsteam_api.dylib" "%YYprojectName%\%YYprojectName%\Supporting Files\libsteam_api.dylib"
   )
   if ERRORLEVEL 1 call :exitError
goto :eof

:: ----------------------------------------------------------------------------------------------------
:Linux_copy_dependencies
   echo "Copying Linux (64 bit) dependencies"
   powershell Expand-Archive '%YYprojectName%.zip' _temp\

   if not exist "assets/libsteam_api.so" (
      copy "%SDK_PATH%redistributable_bin\linux64\libsteam_api.so" "_temp\assets\libsteam_api.so"
      powershell Compress-Archive -Force _temp\* '%YYprojectName%.zip'
   )
   rmdir /s /q _temp
   if ERRORLEVEL 1 call :exitError
goto :eof

:: ----------------------------------------------------------------------------------------------------
:exitError
   echo ""
   echo "######################################################## ERROR #########################################################"
   echo "The setup script was unable to copy dependencies"
   echo "########################################################################################################################"
   echo ""
exit 1

:: ----------------------------------------------------------------------------------------------------
:: If the steamworks SDK path doesn't exit ask the user to edit this file
:error_incorrect_STEAMWORKS_path
   echo ""
   echo "######################################################## ERROR #########################################################"
   echo "The specified steamworks SDK path doesn't exist please edit the file 'post_build_step.bat' in your project's root folder"
   echo "########################################################################################################################"
   echo ""
exit 1
