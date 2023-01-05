/// @description check version & prompt update
show_debug_message("Async Social Called");

if (async_load[? "type"] == "FirebaseFirestore_Document_Read") {
	// DOC READ
	if (async_load[?"status"] == 200) {
		var value = string(async_load[? "value"]);
		show_debug_message("document read: " + string(value));
		var docMap = json_decode(value);
		if (scr_isNumericAndExists(docMap, ds_type_map)) {
		
			newestVersionNum = docMap[? "Version"];
			show_debug_message("newestVersionNum: " + string(newestVersionNum));

			if (is_string(newestVersionNum) && newestVersionNum != "") {
			
				newVersionStr = "Version " + string(newestVersionNum);
				show_debug_message("global.versionString: " + string(global.versionString) + " , newestVersionStr: " + newVersionStr); 
				
				if (newVersionStr == global.versionString) {
					show_debug_message("Version up to date! initialVersionCheck: " + string(initialVersionCheck));
					if (room == rm_openingScreen) {
						if (!initialVersionCheck) {
							if (!instance_exists(obj_dialogueBox)) {
								instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
								obj_openingScreen.versionUpToDate = true;
								obj_dialogueBox.alertWindowActive = true;
							}
						}
					}
					else if (room == rm_mainScreen) {
						if (!instance_exists(obj_dialogueBox)) {
							instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
							obj_control.versionUpToDate = true;
							obj_dialogueBox.alertWindowActive = true;
						}
					}
				}
				else {
					// recommend downloading new version
					show_debug_message("CHECK OUT MY NEW REZONATOR PLEASE");
					if (room == rm_openingScreen) {
						with (obj_openingScreen) showDownloadDialogue = true;
					}
					else if (room == rm_mainScreen) {
						if (!instance_exists(obj_dialogueBox)) {
							instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
							obj_control.downloadDialogue = true;
							obj_dialogueBox.questionWindowActive = true;
						}
					}
				}
			}
		}
	}
	else{
		show_debug_message("ERROR IN LOADING: " + string(async_load[? "errorMessage"]));
	}
}

initialVersionCheck = false;