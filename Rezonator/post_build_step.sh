#!/bin/bash
set echo off

# Useful for printing all variables
# ( set -o posix ; set ) | less

# ########################################### EDIT VARIABLES ###########################################

# Replace with your steamworks sdk path (download from here: https://partner.steamgames.com/doc/sdk)
STEAM_SDK_PATH=$(dirname $(dirname "$0"))/steamworks_sdk

# ######################################################################################################

function error_incorrect_STEAMWORKS_path () {
    echo ""
    echo "######################################################## ERROR ########################################################"
    echo "The specified steamworks SDK path doesn't exist please edit the file 'post_build_step.sh' in your project's root folder"
    echo "#######################################################################################################################"
    echo ""
    exit 1
}

function macOS_copy_dependencies () {

    echo "Copying macOS (64 bit) dependencies"
    if [[ "$YYTARGET_runtime" == "VM" ]]; then
        cp "${STEAM_SDK_PATH}redistributable_bin/osx/libsteam_api.dylib" "libsteam_api.dylib"
    else
        cp "${STEAM_SDK_PATH}redistributable_bin/osx/libsteam_api.dylib" "${YYprojectName}/${YYprojectName}/Supporting Files/libsteam_api.dylib"
    fi
}

function Linux_copy_dependencies () {

    echo "Copying Linux (64 bit) dependencies"
    unzip "./${YYprojectName}.zip" -d ./_temp

    if [[ ! -f "_temp/assets/libsteam_api.so" ]]; then
        cp "${STEAM_SDK_PATH}redistributable_bin/linux64/libsteam_api.so" "_temp/assets/libsteam_api.so"
        cd _temp; zip -FS -r "../${YYprojectName}.zip" *
        cd ..
    fi
    rm -r _temp
}

# Ensure the provided path ends with a slash
if [[ "$STEAM_SDK_PATH" !=  */ ]]; then
    STEAM_SDK_PATH=${STEAM_SDK_PATH}/
fi

# Ensure the path exists
if [[ ! -d "$STEAM_SDK_PATH" ]]; then
    error_incorrect_STEAMWORKS_path
fi

# Ensure we are on the output path
pushd "$YYoutputFolder" 1>/dev/null

# Call setup method depending on the platform
# NOTE: the setup method can be (:MacOS_copy_dependencies or :Linux_copy_dependencies)
{ # try
    ${YYPLATFORM_name}_copy_dependencies 2>/dev/null
} || { # catch
    echo ""
    echo "#################################### INFORMATION ####################################"
    echo "Steam Extension is not available in this target: $YYPLATFORM_name (no setup required)"
    echo "#####################################################################################"
    echo ""
}

popd 1>/dev/null

# exit
exit 0
