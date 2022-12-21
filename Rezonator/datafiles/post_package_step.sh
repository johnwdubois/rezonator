#!/bin/bash
set echo off

# Useful for printing all variables
# ( set -o posix ; set ) | less

# Check if we are exporting to linux (else exit)
if [[ "$YYPLATFORM_name" != "Linux" ]]; then exit 0; fi

# Change current working directory
pushd "$YYoutputFolder" 1>/dev/null

# Start patching the package
echo "Patching Linux (64 bit) package"

unzip "./${YYprojectName}.zip" -d ./_temp

# Write the patch file to the temp directory
echo "#!/bin/bash" >> _temp/run.sh
echo "unset LD_LIBRARY_PATH" >> _temp/run.sh
echo "./${YYprojectName}" >> _temp/run.sh

# Add execute permissions
chmod +x _temp/run.sh

cd _temp; zip -FS -r "../${YYprojectName}.zip" *

cd ..
rm -r _temp

rmdir /s /q _temp

# Return to the previous directory
popd 1>/dev/null

echo ""
echo "############################################ INFORMATION ############################################"
echo "The package was successfully patched!"
echo " - You should set your game's entry point on the steam dashboard to: run.sh"
echo "#####################################################################################################"
echo ""

exit 0

