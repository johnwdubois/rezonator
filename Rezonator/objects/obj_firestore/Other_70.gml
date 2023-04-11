/// @description check version & prompt update
show_debug_message("obj_firestore, Async Social");

if (async_load[? "type"] == "FirebaseFirestore_Document_Read") {
	// DOC READ
	if (async_load[? "status"] == 200) {
		var value = string(async_load[? "value"]);
		show_debug_message("document read: " + string(value));
		var docMap = json_decode(value);
		if (scr_isNumericAndExists(docMap, ds_type_map)) {
		
			global.newVersionStr = scr_strOnlyNumAndPeriod(docMap[? "Version"]);
			show_debug_message("global.newVersionStr: " + global.newVersionStr);

			if (is_string(global.newVersionStr) && global.newVersionStr != "") {
			
				global.newVersionStrFull = "Version " + string(global.newVersionStr);
				show_debug_message("global.currentVersionStr: " + string(global.currentVersionStr) + " , global.newVersionStr: " + global.newVersionStr);
				
				if (scr_checkVersion(global.currentVersionStr, global.newVersionStr)) {
					show_debug_message("Version up to date! initialVersionCheck: " + string(global.initialVersionCheck) + ", manualVersionCheck: " + string(global.manualVersionCheck));
					if (room == rm_openingScreen) {
						if (global.manualVersionCheck) {
							scr_createDialogBox(DIALOG_VERSION_UPTODATE);
						}
					}
					else if (room == rm_mainScreen) {
						if (global.manualVersionCheck) {
							scr_createDialogBox(DIALOG_VERSION_UPTODATE);
						}
					}
				}
				else {
					// recommend downloading new version
					show_debug_message("CHECK OUT MY NEW REZONATOR PLEASE");
					scr_createDialogBox(DIALOG_VERSION_OUTOFDATE, true);
					with (obj_openingScreen) {
						showDownloadDialogue = true;
						alreadyShownDownloadDialogue = false;
					}
				}
			}
		}
	}
	else {
		show_debug_message("ERROR IN LOADING: " + string(async_load[? "errorMessage"]));
	}
}

global.manualVersionCheck = false;