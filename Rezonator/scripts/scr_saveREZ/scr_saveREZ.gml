/*
	Purpose: Save all user created data into a special type of JSON file, a Rez file
*/
function scr_saveREZ(autosave) {

	show_debug_message("scr_saveREZ, STARTING... " + scr_printTime());
	show_debug_message("scr_saveREZ, autosave: " + string(autosave) + ", global.fileSaveName: " + string(global.fileSaveName));

	// get fileSaveName if we don't already have it
	if (not autosave) {
		if (global.fileSaveName == "undefined"
		|| string_length(global.fileSaveName) < 1
		|| (!file_exists(global.fileSaveName) && !directory_exists(obj_control.clipStackDir))) {
			
			show_debug_message("scr_saveREZ(), not autosave, loading new file");
			if(global.previousSaveDirectory == "" or !is_string(global.previousSaveDirectory)){
				global.fileSaveName = get_save_filename_ext("REZ file|*.rez", "", program_directory, "Save REZ");
			}
			else{
				global.fileSaveName = get_save_filename_ext("REZ file|*.rez", "", global.previousSaveDirectory, "Save REZ");	
			}

			if (global.fileSaveName == "" or global.fileSaveName == "undefined") {
				global.fileSaveName = "undefined";
				show_message(scr_get_translation("msg_saving-error"));
				global.stackGrabSave = false;
				exit;
			}
	
			if (string_count(program_directory, global.fileSaveName) > 0) {
				show_message(scr_get_translation("msg_saving-rez-directory"));
				scr_saveREZ(false);
				exit;
			}
		}
	}

	// Prevent users from overwriting default discourse files
	if(os_type == os_macosx){
		if(filename_path(global.fileSaveName) == global.rezonatorDefaultDiscourseDirString + "/" and not autosave) {
			show_message(scr_get_translation("msg_saving-default-directory"));
			global.fileSaveName = "";
			scr_saveREZ(false);
			exit;
		}
	}
	else {
		if (filename_path(global.fileSaveName) == global.rezonatorDefaultDiscourseDirString + "\\" and not autosave) {
			show_message(scr_get_translation("msg_saving-default-directory"));
			global.fileSaveName = "";
			scr_saveREZ(false);
			exit;
		}
	}
	
	show_debug_message("here 1 " + scr_printTime());
	
	// create maps to hold copies of other maps we want in the REZ file
	var nodeMapCopy = ds_map_create();

	// create a list to contain all of the data we will save	
	var rootList = ds_list_create();

	// go to every object with savable data and collect all of it into rootList
	with (obj_saveParent) {
		var map = ds_map_create();
		ds_list_add(rootList, map);
		ds_list_mark_as_map(rootList, ds_list_size(rootList) - 1);

		var mapObjectIndex = object_get_name(object_index);
		ds_map_add(map, "objectIndex", mapObjectIndex);
	
	
		if (object_index == obj_control) {

			var tempImportGridColNameList = scr_copyListToMap(global.importGridColNameList, map, "importGridColNameList");
			var tempChainEntryFieldList = scr_copyListToMap(global.chainEntryFieldList, map, "chainEntryFieldList");
			var tempChainFieldList = scr_copyListToMap(global.chainFieldList, map, "chainFieldList");
			var tempLinkFieldList = scr_copyListToMap(global.linkFieldList, map, "linkFieldList");
			var tempChunkFieldList = scr_copyListToMap(chunkFieldList, map, "chunkFieldList");
			var tempNavChunkFieldList = scr_copyListToMap(navChunkFieldList, map, "navChunkFieldList");
			var tempNavTokenFieldList = scr_copyListToMap(navTokenFieldList, map, "navTokenFieldList");
			var tempTokenFieldList = scr_copyListToMap(tokenFieldList, map, "tokenFieldList");
			var tempNavUnitFieldList = scr_copyListToMap(navUnitFieldList, map, "navUnitFieldList");
			var tempUnitFieldList = scr_copyListToMap(unitFieldList, map, "unitFieldList");
			var tempTranslationList = scr_copyListToMap(global.translationList, map, "translationList");
			
			show_debug_message("here 2 " + scr_printTime());

		
			//save special feild colnames
			ds_map_add(map, "unitDelimField", global.unitDelimField);
			ds_map_add(map, "unitImportTurnDelimColName", global.unitImportTurnDelimColName);
			ds_map_add(map, "psentDelimField", global.psentDelimField);
			ds_map_add(map, "wordImportWordDelimColName", global.wordDelimField);
			ds_map_add(map, "unitImportUnitEndColName", global.unitImportUnitEndColName);
			ds_map_add(map, "unitImportUnitStartColName", global.unitImportUnitStartColName);
			ds_map_add(map, "unitImportSpeakerColName", global.unitImportSpeakerColName);
			ds_map_add(map, "tokenImportTranscriptColName", global.tokenImportTranscriptColName);
			ds_map_add(map, "tokenImportDisplayTokenColName", global.tokenImportDisplayTokenColName);
		
			// mainscreen display information
			ds_map_add(map, "showParticipantName", obj_control.showSpeakerName);
			ds_map_add(map, "justify", obj_control.justify);
			
			ds_map_add(map, "functionChainList_focusedUnit", obj_panelPane.functionChainList_focusedUnit);
			ds_map_add(map, "functionChainList_focusedUnitSeq", obj_panelPane.functionChainList_focusedUnitIndex);
			
			show_debug_message("here 3 " + scr_printTime());
			
			// deep-copy nodeMap
			nodeMapCopy = json_decode(json_encode(global.nodeMap));
			show_debug_message("here 4 " + scr_printTime());
			ds_map_add_map(map, "nodeMap", nodeMapCopy);
			show_debug_message("here 5 " + scr_printTime());
			
			
		 	
			// save the displayTokenField & participantField
			ds_map_add(map, "displayTokenField", global.displayTokenField);
			ds_map_add(map, "participantField", global.participantField);
			
			// save discourse node
			ds_map_add(map, "docNode", global.discourseNode);
			
			
			// save import type
			ds_map_add(map, "importType", global.importType);
			
			// save version num
			ds_map_add(map, "version", global.versionString);
			
			// save user ID
			ds_map_add(map, "userID", global.userName);
			
			// save text direction
			ds_map_add(map, "textDirection", obj_control.drawLineState);
			
			// save session length
			scr_getCurrentSessionTime();
			ds_map_add(map, "sessionLength", obj_control.fullSessionLength);
			
			
			ds_map_add(map, "resonanceCounter", obj_chain.rezChainNameCounter);
			ds_map_add(map, "trailCounter", obj_chain.trackChainNameCounter);
			ds_map_add(map, "stackCounter", obj_chain.stackChainNameCounter);
			ds_map_add(map, "audioFile", obj_audioUI.audioFile);
			
			
			
		}
	}

	// wrap the root list in a map
	var wrapper = ds_map_create();
	ds_map_add_list(wrapper, "ROOT", rootList);
	show_debug_message("After map created");

	// encode the wrapper to a json
	var jsonString = json_encode(wrapper);
	show_debug_message("After json encoded");

	// beautify/stylize the json if this is not an auto-save
	if (not autosave) {
		jsonString = scr_jsonBeautify(jsonString);
		show_debug_message("After json beautified");
	}

	// save the file with the JSON encoded string
	if (autosave) {
		if (directory_exists(global.importGroupOutputDir) && global.importGroupOutputDir != "") {
			var importGroupFileName = ds_list_find_value(global.importGroupFileList, global.importGroupFileIndex);
			var importGroupFilePath = global.importGroupOutputDir + "\\" + filename_change_ext(filename_name(importGroupFileName), "") + ".rez";
			show_debug_message("importGroupFileIndex: " + string(global.importGroupFileIndex) + ", Saving to: " + string(importGroupFilePath));
			scr_saveFileBuffer(importGroupFilePath, importGroupFilePath, jsonString);
			global.importGroupFileIndex++;
		}
		
		if (os_type == os_macosx) {
			if (directory_exists(global.rezonatorDirString + "/Autosave")) {
		
				scr_saveFileBuffer(working_directory + "autosave.rez", global.rezonatorDirString + "/Autosave/autosave.rez", jsonString);
			}
			else {
				scr_saveFileBuffer(working_directory + "autosave.rez", working_directory + "autosave.rez", jsonString);
			}
		}
		else {
			if (directory_exists(global.rezonatorDirString + "\\Autosave")) {
		
				scr_saveFileBuffer(working_directory + "autosave.rez", global.rezonatorDirString + "\\Autosave\\autosave.rez", jsonString);
			}
			else {
				scr_saveFileBuffer(working_directory + "autosave.rez", working_directory + "autosave.rez", jsonString);
			}
		}

	}
	else if (obj_control.saveToFirebase) {
		
		var rezfileSubMap = ds_map_create();
		rezfileSubMap[? "usedID"] = global.userName;
		var rezfileFirestorePath = "rezfiles/" + filename_name(global.fileSaveName);
		FirebaseFirestore(rezfileFirestorePath).Set(json_encode(rezfileSubMap));
		
		var nodeList = global.nodeMap[?"nodeList"];		
		var nodeListSize = ds_list_size(nodeList);
		for (var i = 0; i < nodeListSize; i++) {
			var currentNodeID = nodeList[| i];
			var currentNodeSubMap = global.nodeMap[? currentNodeID];
			var currentNodeType = currentNodeSubMap[? "type"];
			
			if (is_string(currentNodeType)) {
				if (currentNodeType == "unit" || currentNodeType == "token" || currentNodeType == "unit" || currentNodeType == "entry" || currentNodeType == "link"
				|| currentNodeType == "stack" || currentNodeType == "card" || currentNodeType == "resonance" || currentNodeType == "rez" || currentNodeType == "track"
				|| currentNodeType == "trail") {
					var currentNodeSubMapJson = json_encode(currentNodeSubMap);
					FirebaseFirestore(rezfileFirestorePath + "/" + currentNodeType + "/" + string(currentNodeID)).Set(currentNodeSubMapJson);
				}
			}
		}
		
	}
	else {
		scr_saveFileBuffer(working_directory + filename_name(global.fileSaveName), global.fileSaveName, jsonString);
	}
	

	ds_map_destroy(wrapper);
	
	// destroy various map/list deep-copies
	ds_map_destroy(nodeMapCopy);
	ds_list_destroy(tempImportGridColNameList);
	ds_list_destroy(tempChainEntryFieldList);
	ds_list_destroy(tempChainFieldList);
	ds_list_destroy(tempNavTokenFieldList);
	ds_list_destroy(tempNavUnitFieldList);
	ds_list_destroy(tempTokenFieldList);
	ds_list_destroy(tempUnitFieldList);
	ds_list_destroy(tempTranslationList);
	
	
	
	// set allSaved to true so user does not get prompted to save when they quit
	if (not autosave) {
		global.previousSaveDirectory = filename_path(global.fileSaveName);
		scr_addToRecentFiles(string(global.fileSaveName));
		obj_control.allSaved = true;
	}

	show_debug_message("scr_saveREZ, END... " + scr_printTime());
	
	// if this is a batch import, loop back to opening screen to auto-import another file
	if (autosave && directory_exists(global.importGroupOutputDir) && global.importGroupOutputDir != "") {
		ds_map_clear(global.nodeMap);
		ds_grid_destroy(global.importGrid);
		show_debug_message("Going to openingScreen, scr_saveREZ");
		room_goto(rm_openingScreen);
	}

	global.stackGrabSave = false;
	
	with (obj_fileLoader) {
		drawAutosaveText = false;
	}
}
