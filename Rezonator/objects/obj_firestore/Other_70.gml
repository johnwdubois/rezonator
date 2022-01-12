/// @description check version & prompt update
show_debug_message("Async Social Called");

if (async_load[? "type"] == "FirebaseFirestore_Document_Read") {
	// DOC READ
	if (async_load[?"status"] == 200) {
		var value = async_load[? "value"];
		show_debug_message("document read: " + string(value));
		coolMap = json_decode(value);

		newestVersionNum = coolMap[? "Version"];
		show_debug_message("newestVersionNum: " + string(newestVersionNum));

		if (is_string(newestVersionNum) && newestVersionNum != "") {
			
			newVersionStr = "Version " + string(newestVersionNum);
			show_debug_message("global.versionString: " + string(global.versionString) + " , newestVersionStr: " + newVersionStr); 
				
			if (newVersionStr != global.versionString) {
				// recommend downloading new version
				show_debug_message("CHECK OUT MY NEW REZONATOR PLEASE");
				with (obj_openingScreen) showDownloadDialogue = true;
			}
		}
	}
	else{
		show_debug_message("ERROR IN LOADING: " + string(async_load[? "errorMessage"]));
	}
}