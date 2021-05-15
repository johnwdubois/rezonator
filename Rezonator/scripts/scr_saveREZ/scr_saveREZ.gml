/*
	Purpose: Save all user created data into a special type of JSON file, a Rez file
*/
function scr_saveREZ(autosave) {

	show_debug_message("scr_saveREZ(), STARTING... " + scr_printTime());
	show_debug_message("scr_saveREZ(), global.fileSaveName: " + string(global.fileSaveName));
	
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

		
		
			var mapFileLineRipGrid = scr_gridToJSONLists(global.fileLineRipGrid);
			var mapWordGrid = scr_gridToJSONLists(wordGrid);
			var mapWordGridColList = scr_getListOfGridCols(wordGrid);
			var mapDynaWordGrid = scr_gridToJSONLists(dynamicWordGrid);
			var mapWordDrawGrid = scr_gridToJSONLists(wordDrawGrid);
			var mapUnitGrid = scr_gridToJSONLists(unitGrid);
			var mapLineGrid = scr_gridToJSONLists(lineGrid);
			var mapimportGrid = scr_gridToJSONLists(global.importGrid);
			var mapimportCSVGrid = scr_gridToJSONLists(global.importCSVGrid);
			var mapMorphGrid = scr_gridToJSONLists(obj_control.morphGrid);
			var maptokenImport = scr_gridToJSONLists(global.tokenImportGrid);
			var mapwordImport = scr_gridToJSONLists(global.wordImportGrid);
			var mapunitImport = scr_gridToJSONLists(global.unitImportGrid);
			var mapDiscoImport = scr_gridToJSONLists(global.discoImportGrid);
			var mapCustomLabelGrid = scr_gridToJSONLists(global.customLabelGrid);
		
			ds_map_add_list(map, "fileLineRipGrid", mapFileLineRipGrid);
			ds_map_add_list(map, "wordGrid", mapWordGrid);
			ds_map_add_list(map, "wordGridColList", mapWordGridColList);
			ds_map_add_list(map, "dynaWordGrid", mapDynaWordGrid);
			ds_map_add_list(map, "wordDrawGrid", mapWordDrawGrid);
			ds_map_add_list(map, "unitGrid", mapUnitGrid);
			ds_map_add_list(map, "lineGrid", mapLineGrid);
			ds_map_add_list(map, "importGrid", mapimportGrid);
			ds_map_add_list(map, "importCSVGrid", mapimportCSVGrid);
			ds_map_add(map, "importGridWidth", global.importGridWidth);
			ds_map_add(map, "importCSVGridWidth", global.importCSVGridWidth);
			ds_map_add_list(map, "morphGrid", mapMorphGrid);
			var tempList = ds_list_create();
			if (global.importGridColNameList != undefined) {
				ds_list_copy(tempList, global.importGridColNameList);
			}
			ds_map_add_list(map, "importGridColNameList", tempList);
		


		


		
			//custom label saves
			ds_map_add_list(map, "tokenImport", maptokenImport);
			ds_map_add_list(map, "wordImport", mapwordImport);
			ds_map_add_list(map, "unitImport", mapunitImport);
			ds_map_add_list(map, "discoImport", mapDiscoImport);
			ds_map_add_list(map, "CustomLabelGrid", mapCustomLabelGrid);
			
			var tempTokenImportColNameList = ds_list_create();
			if (scr_isNumericAndExists(global.tokenImportColNameList, ds_type_list)) {
				ds_list_copy(tempTokenImportColNameList, global.tokenImportColNameList);
			}
			ds_map_add_list(map, "tokenImportColNameList", tempTokenImportColNameList);

			var tempUnitImportColNameList = ds_list_create();
			if (scr_isNumericAndExists(global.unitImportColNameList, ds_type_list)) {
				ds_list_copy(tempUnitImportColNameList, global.unitImportColNameList);
			}
			ds_map_add_list(map, "unitImportColNameList", tempUnitImportColNameList);
		
			var tempCurrentDisplayTokenColsList = ds_list_create();
			if (scr_isNumericAndExists(obj_control.currentDisplayTokenColsList, ds_type_list)) {
				ds_list_copy(tempCurrentDisplayTokenColsList, obj_control.currentDisplayTokenColsList);
			}
			ds_map_add_list(map, "currentDisplayTokenColsList", tempCurrentDisplayTokenColsList);
		
			var tempCurrentDisplayUnitColsList = ds_list_create();
			if (scr_isNumericAndExists(obj_control.currentDisplayTokenColsList, ds_type_list)) {
				ds_list_copy(tempCurrentDisplayUnitColsList, obj_control.currentDisplayUnitColsList);
			}
			ds_map_add_list(map, "currentDisplayUnitColsList", tempCurrentDisplayUnitColsList);		
			
			var tempWordImportColNameList = ds_list_create();
			if (scr_isNumericAndExists(global.wordImportColNameList, ds_type_list)) {
				ds_list_copy(tempWordImportColNameList, global.wordImportColNameList);
			}
			ds_map_add_list(map, "wordImportColNameList", tempWordImportColNameList);
			
			var tempChainEntryFieldList = ds_list_create();
			if (scr_isNumericAndExists(global.chainEntryFieldList, ds_type_list)) {
				ds_list_copy(tempChainEntryFieldList, global.chainEntryFieldList);
			}
			ds_map_add_list(map, "chainEntryFieldList", tempChainEntryFieldList);
			
			var tempChainFieldList = ds_list_create();
			if (scr_isNumericAndExists(global.chainFieldList, ds_type_list)) {
				ds_list_copy(tempChainFieldList, global.chainFieldList);
			}
			ds_map_add_list(map, "chainFieldList", tempChainFieldList);
			
			var tempNavTokenFieldList = ds_list_create();
			if (scr_isNumericAndExists(navTokenFieldList, ds_type_list)) {
				ds_list_copy(tempNavTokenFieldList, navTokenFieldList);
			}
			ds_map_add_list(map, "navTokenFieldList", tempNavTokenFieldList);
			
			var tempTokenFieldList = ds_list_create();
			if (scr_isNumericAndExists(tokenFieldList, ds_type_list)) {
				ds_list_copy(tempTokenFieldList, tokenFieldList);
			}
			ds_map_add_list(map, "tokenFieldList", tempTokenFieldList);
			
			var tempNavUnitFieldList = ds_list_create();
			if (scr_isNumericAndExists(navUnitFieldList, ds_type_list)) {
				ds_list_copy(tempNavUnitFieldList, navUnitFieldList);
			}
			ds_map_add_list(map, "navUnitFieldList", tempNavUnitFieldList);
			
			var tempUnitFieldList = ds_list_create();
			if (scr_isNumericAndExists(unitFieldList, ds_type_list)) {
				ds_list_copy(tempUnitFieldList, unitFieldList);
			}
			ds_map_add_list(map, "unitFieldList", tempUnitFieldList);
			
			var tempTranslationList = ds_list_create();
			if (scr_isNumericAndExists(global.translationList, ds_type_list)) {
				ds_list_copy(tempTranslationList, global.translationList);
			}
			ds_map_add_list(map, "translationList", tempTranslationList);
		
		
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
			var mapUnitInStackGrid = scr_gridToJSONLists(unitInStackGrid);
			var mapCliqueGrid = scr_gridToJSONLists(cliqueGrid);
			var mapGoldStandardGrid = scr_gridToJSONLists(goldStandardGrid);
		

			ds_map_add_list(map, "unitInStackGrid", mapUnitInStackGrid);
			ds_map_add_list(map, "cliqueGrid", mapCliqueGrid);
			ds_map_add_list(map, "goldStandardGrid", mapGoldStandardGrid);
		
		
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

	show_debug_message("scr_saveREZ(), END... " + scr_printTime());
	
	// if this is a batch import, loop back to opening screen to auto-import another file
	if (autosave && directory_exists(global.importGroupOutputDir) && global.importGroupOutputDir != "") {
		room_goto(rm_openingScreen);
	}

	global.stackGrabSave = false;
}
