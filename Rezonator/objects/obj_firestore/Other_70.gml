/// @description check version & prompt update
show_debug_message("Async Social Called");

if (async_load[? "type"] == "FirebaseFirestore_Document_Read") {
	// DOC READ
	if (async_load[? "status"] == 200) {
		var value = string(async_load[? "value"]);
		show_debug_message("document read: " + string(value));
		var docMap = json_decode(value);
		if (scr_isNumericAndExists(docMap, ds_type_map)) {
		
			global.newestVersionNum = docMap[? "Version"];
			show_debug_message("global.newestVersionNum: " + string(global.newestVersionNum));

			if (is_string(global.newestVersionNum) && global.newestVersionNum != "") {
			
				global.newVersionStr = "Version " + string(global.newestVersionNum);
				show_debug_message("global.versionString: " + string(global.versionString) + " , newestVersionStr: " + global.newVersionStr); 
				
				if (global.newVersionStr == global.versionString) {
					show_debug_message("Version up to date! initialVersionCheck: " + string(global.initialVersionCheck) + ", manualVersionCheck: " + string(global.manualVersionCheck));
					if (room == rm_openingScreen) {
						if (global.manualVersionCheck) {
							if (!instance_exists(obj_dialogueBox)) {
								instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
								obj_openingScreen.versionUpToDate = true;
								obj_dialogueBox.alertWindowActive = true;
							}
						}
					}
					else if (room == rm_mainScreen) {
						if (global.manualVersionCheck) {
							if (!instance_exists(obj_dialogueBox)) {
								instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
								obj_control.versionUpToDate = true;
								obj_dialogueBox.alertWindowActive = true;
							}
						}
					}
				}
				else {
					// recommend downloading new version
					show_debug_message("CHECK OUT MY NEW REZONATOR PLEASE");
					if (room == rm_openingScreen) {
						with (obj_openingScreen) {
							showDownloadDialogue = true;
							alreadyShownDownloadDialogue = false;
						}
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
	else {
		show_debug_message("ERROR IN LOADING: " + string(async_load[? "errorMessage"]));
	}
}

global.manualVersionCheck = false;