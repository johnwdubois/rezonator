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
		|| (!file_exists(global.fileSaveName) && !obj_stacker.splitSave)
		|| global.stackGrabSave) {
			
			show_debug_message("scr_saveREZ(), not autosave, loading new file");
			global.fileSaveName = get_save_filename_ext("REZ file|*.rez", "", program_directory, "Save REZ");

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
	
	// create maps to hold copies of other maps we want in the REZ file
	var nodeMapCopy = ds_map_create();
	var tokenImportTagMapCopy = ds_map_create();
	var unitImportTagMapCopy = ds_map_create();
	var stackTagMapCopy = ds_map_create();
	var entryFieldMapCopy = ds_map_create();
	var chainFieldMapCopy = ds_map_create();

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
			var tempTokenImportColNameList = scr_copyListToMap(global.tokenImportColNameList, map, "tokenImportColNameList");
			var tempUnitImportColNameList = scr_copyListToMap(global.unitImportColNameList, map, "unitImportColNameList");
			var tempCurrentDisplayTokenColsList = scr_copyListToMap(obj_control.currentDisplayTokenColsList, map, "currentDisplayTokenColsList");
			var tempCurrentDisplayUnitColsList = scr_copyListToMap(obj_control.currentDisplayUnitColsList, map, "currentDisplayUnitColsList");
			var tempWordImportColNameList = scr_copyListToMap(global.wordImportColNameList, map, "wordImportColNameList");
			var tempChainEntryFieldList = scr_copyListToMap(global.chainEntryFieldList, map, "chainEntryFieldList");
			var tempChainFieldList = scr_copyListToMap(global.chainFieldList, map, "chainFieldList");
			var tempNavTokenFieldList = scr_copyListToMap(navTokenFieldList, map, "navTokenFieldList");
			var tempTokenFieldList = scr_copyListToMap(tokenFieldList, map, "tokenFieldList");
			var tempNavUnitFieldList = scr_copyListToMap(navUnitFieldList, map, "navUnitFieldList");
			var tempUnitFieldList = scr_copyListToMap(unitFieldList, map, "unitFieldList");
			var tempTranslationList = scr_copyListToMap(global.translationList, map, "translationList");
			
			
			

		
			//save special feild colnames
			ds_map_add(map, "unitImportUnitDelimColName", global.unitImportUnitDelimColName);
			ds_map_add(map, "unitImportTurnDelimColName", global.unitImportTurnDelimColName);
			ds_map_add(map, "wordImportWordDelimColName", global.wordImportWordDelimColName);
			ds_map_add(map, "unitImportUnitEndColName", global.unitImportUnitEndColName);
			ds_map_add(map, "unitImportUnitStartColName", global.unitImportUnitStartColName);
			ds_map_add(map, "unitImportSpeakerColName", global.unitImportSpeakerColName);
			ds_map_add(map, "tokenImportTranscriptColName", global.tokenImportTranscriptColName);
			ds_map_add(map, "tokenImportDisplayTokenColName", global.tokenImportDisplayTokenColName);
		
			// mainscreen display information
			ds_map_add(map, "showParticipantName", obj_control.showSpeakerName);
			ds_map_add(map, "justify", obj_control.justify);
			
			ds_map_add(map, "functionChainList_focusedUnit", obj_panelPane.functionChainList_focusedUnit);
			ds_map_add(map, "functionChainList_focusedUnitIndex", obj_panelPane.functionChainList_focusedUnitIndex);
			
		
			if (global.stackGrabSave) {
				ds_map_add(map, "subLineGridBeginning", obj_fileLoader.subLineGridBeginning);
				ds_map_add(map, "subLineGridEnd", obj_fileLoader.subLineGridEnd);
			}
			else {
				ds_map_add(map, "subLineGridBeginning", -1);
				ds_map_add(map, "subLineGridEnd", -1);
			}
			
			
			// deep-copy tokenImportTagMap
			tokenImportTagMapCopy = json_decode(json_encode(global.tokenImportTagMap));
			ds_map_add_map(map, "tokenImportTagMap", tokenImportTagMapCopy);
			
			// deep-copy unitImportTagMap
			unitImportTagMapCopy = json_decode(json_encode(global.unitImportTagMap));
			ds_map_add_map(map, "unitImportTagMap", unitImportTagMapCopy);
			
			// deep-copy entryFieldMap
			entryFieldMapCopy = json_decode(json_encode(global.entryFieldMap));
			ds_map_add_map(map, "entryFieldMap", entryFieldMapCopy);
			
			// deep-copy chainFieldMap
			chainFieldMapCopy = json_decode(json_encode(global.chainFieldMap));
			ds_map_add_map(map, "chainFieldMap", chainFieldMapCopy);
			
			// deep-copy nodeMap
			nodeMapCopy = json_decode(json_encode(global.nodeMap));
			ds_map_add_map(map, "nodeMap", nodeMapCopy);
			
		 	
			// save the displayTokenField & speakerField
			ds_map_add(map, "displayTokenField", global.displayTokenField);
			ds_map_add(map, "speakerField", global.speakerField);
			
			// save discourse node
			ds_map_add(map, "discourseNode", global.discourseNode);
		
		}
		else if (object_index == obj_chain) {
		
			ds_map_add(map, "chainColorID1", chainColorID[1]);
			ds_map_add(map, "chainColorID2", chainColorID[2]);
			ds_map_add(map, "chainColorID3", chainColorID[3]);
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
	else {
		scr_saveFileBuffer(working_directory + filename_name(global.fileSaveName), global.fileSaveName, jsonString);
	}

	for(var i = 0; i < ds_list_size(rootList); i++)
	{
	    var map = rootList[| i];
	    map[? "importGridColNameList"] = undefined;
	    map[? "tokenImportColNameList"] = undefined;
	    map[? "unitImportColNameList"] = undefined;
	    map[? "tokenImportTagMap"] = undefined;
	    map[? "unitImportTagMap"] = undefined;
		map[? "stackTagMap"] = undefined;
	}

	ds_map_destroy(wrapper);
	
	// destroy various map/list deep-copies
	ds_map_destroy(nodeMapCopy);
	ds_map_destroy(tokenImportTagMapCopy);
	ds_map_destroy(unitImportTagMapCopy);
	ds_map_destroy(stackTagMapCopy);
	ds_map_destroy(entryFieldMapCopy);
	ds_map_destroy(chainFieldMapCopy);
	ds_list_destroy(tempImportGridColNameList);
	ds_list_destroy(tempTokenImportColNameList);
	ds_list_destroy(tempUnitImportColNameList);
	ds_list_destroy(tempCurrentDisplayTokenColsList);
	ds_list_destroy(tempCurrentDisplayUnitColsList);
	ds_list_destroy(tempWordImportColNameList);
	ds_list_destroy(tempChainEntryFieldList);
	ds_list_destroy(tempChainFieldList);
	ds_list_destroy(tempNavTokenFieldList);
	ds_list_destroy(tempNavUnitFieldList);
	ds_list_destroy(tempTokenFieldList);
	ds_list_destroy(tempUnitFieldList);
	ds_list_destroy(tempTranslationList);
	
	
	
	// set allSaved to true so user does not get prompted to save when they quit
	if (not autosave) {
		obj_control.allSaved = true;
	}

	show_debug_message("scr_saveREZ, END... " + scr_printTime());
	
	// if this is a batch import, loop back to opening screen to auto-import another file
	if (autosave && directory_exists(global.importGroupOutputDir) && global.importGroupOutputDir != "") {
		room_goto(rm_openingScreen);
	}

	global.stackGrabSave = false;
}
