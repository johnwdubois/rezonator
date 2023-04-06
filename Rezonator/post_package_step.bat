@echo off

:: Useful for printing all variables
:: set 

:: Check if we are exporting to linux (else exit)
if not "%YYPLATFORM_name%" == "Linux" exit 0

:: Change current working directory
pushd "%YYoutputFolder%"

:: Start patching the package
echo "Patching Linux (64 bit) package"

powershell Expand-Archive '%YYprojectName%.zip' _temp\

:: Write the patch file to the temp directory
echo #!/bin/bash >> _temp\run.sh
echo unset LD_LIBRARY_PATH >> _temp\run.sh
echo ./%YYprojectName% >> _temp\run.sh

:: Ensure the EOL format is converted to LF
powershell -noninteractive -NoProfile -ExecutionPolicy Bypass -Command "& {[IO.File]::WriteAllText('_temp\run.sh', ([IO.File]::ReadAllText('_temp\run.sh') -replace \"`r`n\", \"`n\"))};"

:: Recompress the patched project into a zip file
powershell Compress-Archive -Force _temp\* '%YYprojectName%.zip'

rmdir /s /q _temp

:: Return to the previous directory
popd

echo ""
echo "############################################ INFORMATION ############################################"
echo "The package was successfully patched!"
echo " - You should set your game's entry point on the steam dashboard to be: run.sh"
echo "#####################################################################################################"
echo ""

exit /b 0

:: ----------------------------------------------------------------------------------------------------
:exitError
echo "ERROR : Unable to complete"
exit /b 1

