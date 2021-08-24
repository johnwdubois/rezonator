function scr_loadREZ() {
	

	var delimiter = (os_type == os_macosx) ? "/" : "\\";
	var RezDirString = global.rezonatorDirString + delimiter + "Data" + delimiter + "SBCorpus" + delimiter + "REZ";

show_debug_message("global.previousRezDirectory:  "+string(global.previousRezDirectory));
	if (global.previousRezDirectory != "") {
		RezDirString = global.previousRezDirectory;
	
		// trimming the spaces off of RezDirString
		var charAt = string_length(RezDirString);
		while (string_char_at(RezDirString, charAt) == " " and charAt > 0) {
			charAt--;
		}
		RezDirString = string_delete(RezDirString, charAt, string_length(RezDirString) - charAt);
	}







	if (directory_exists(global.rezonatorDirString)) {
		var fileName = get_open_filename_ext("REZ file|*.rez", "", RezDirString, "Open REZ");
	}
	else {
		var fileName = get_open_filename_ext("REZ file|*.rez", "", program_directory, "Open REZ");
	}

	if (fileName == "" or not file_exists(fileName)) {
		room_goto(rm_openingScreen);
		exit;
	}
	else{
		global.previousRezDirectory = filename_path(fileName);
	}
	


	var rezFileVerison = 0;

	global.fileSaveName = fileName;
	if (filename_path(global.fileSaveName) == global.rezonatorDefaultDiscourseDirString + "\\") {
		global.fileSaveName = "";
	}

	var newInstList = ds_list_create();

	if (file_exists(fileName)) {
		var wrapper = scr_loadJSONBuffer(fileName);
	
		if (not ds_exists(wrapper, ds_type_map)) {
			show_message("Error loading " + fileName);
			room_goto(rm_openingScreen);
			exit;
		}
	
		var list = ds_map_find_value(wrapper, "ROOT");
	
		if (is_undefined(list)) {
			show_message("Error loading " + fileName);
			room_goto(rm_openingScreen);
			exit;
		}
	
		global.openedREZFile = true;
	
	
		var listSize = ds_list_size(list);
		for (var i = 0; i < listSize; i++) {
			var map = ds_list_find_value(list, i);
		
			var objectIndex = ds_map_find_value(map, "objectIndex");
		
		
			with (asset_get_index(objectIndex)) {
				if (objectIndex == "obj_control") {
					obj_control.currentCenterDisplayRow = 0;
			
					global.importGridWidth = ds_map_find_value(map, "importGridWidth");
					global.importCSVGridWidth = ds_map_find_value(map, "importCSVGridWidth");
					rezFileVerison = ds_map_find_value(map, "version");
				
					global.unitDelimField = ds_map_find_value(map, "unitDelimField");
					global.unitImportTurnDelimColName = ds_map_find_value(map, "unitImportTurnDelimColName");
					global.wordDelimField = ds_map_find_value(map, "wordImportWordDelimColName");
					global.currentTranslation = ds_map_find_value(map, "currentTranslation");
					global.unitImportSpeakerColName = ds_map_find_value(map, "unitImportSpeakerColName");
					global.unitImportUnitEndColName = ds_map_find_value(map, "unitImportUnitEndColName");
					global.unitImportUnitStartColName = ds_map_find_value(map, "unitImportUnitStartColName");
					global.tokenImportTranscriptColName = ds_map_find_value(map, "tokenImportTranscriptColName");
					global.tokenImportDisplayTokenColName = ds_map_find_value(map, "tokenImportDisplayTokenColName");
					with(obj_panelPane){
						functionChainList_focusedUnit = ds_map_find_value(map, "functionChainList_focusedUnit");
						functionChainList_focusedUnitIndex = ds_map_find_value(map, "functionChainList_focusedUnitIndex");
					}
					
					if(global.tokenImportDisplayTokenColName == undefined ){
						global.tokenImportDisplayTokenColName = "~text";
					}
					
					
					global.translationList = ds_map_find_value(map, "translationList");
					var lineState = ds_map_find_value(map, "textDirection");
					if(is_string(lineState)){
						obj_control.drawLineState = lineState;						
					}
				
					global.importGridColNameList = ds_map_find_value(map, "importGridColNameList");
				
					if (ds_map_find_value(map, "showSpeakerName") != undefined) {
						obj_control.showSpeakerName = ds_map_find_value(map, "showSpeakerName");
						show_debug_message("scr_loadREZ, showSpeakerName: " + string(obj_control.showSpeakerName));
					}
					if (ds_map_find_value(map, "justify") != undefined) {
						obj_control.justify = ds_map_find_value(map, "justify");
					}
					
					if (global.translationList == undefined) {
						global.translationList = ds_list_create();
					}

					global.nodeMap = ds_map_find_value(map, "nodeMap");			
					if (is_undefined(global.nodeMap)) {
						show_debug_message("scr_loadREZ() ... global.nodeMap is undefined");
						global.nodeMap = ds_map_create();
					}
					if(!scr_isNumericAndExists( global.nodeMap[?"nodeList"], ds_type_list)){
						var nodeList = ds_list_create();
						ds_map_add_list(global.nodeMap, "nodeList", nodeList);
					}
					
					global.cliqueMap = global.nodeMap[? "cliqueMap"];
					global.searchMap = global.nodeMap[? "searchMap"];		
					global.treeMap = global.nodeMap[? "treeMap"];
					global.colorMap = global.nodeMap[? "colorMap"];
				
				
					if (is_undefined(global.importGridColNameList)) {
						var tempList3 = ds_list_create();
						global.importGridColNameList = tempList3;
					}
					
					
					// get navTokenFieldList, if supplied
					var navTokenFieldList = ds_map_find_value(map, "navTokenFieldList");
					if (scr_isNumericAndExists(navTokenFieldList, ds_type_list)) {
						ds_list_destroy(obj_control.navTokenFieldList);
						obj_control.navTokenFieldList = navTokenFieldList;
					}
					
					// get navTokenFieldList, if supplied
					var tokenFieldList = ds_map_find_value(map, "tokenFieldList");
					if (scr_isNumericAndExists(tokenFieldList, ds_type_list)) {
						ds_list_destroy(obj_control.tokenFieldList);
						obj_control.tokenFieldList = tokenFieldList;
					}
					
					
					// get navUnitFieldList, if supplied
					var navUnitFieldList = ds_map_find_value(map, "navUnitFieldList");
					if (scr_isNumericAndExists(navUnitFieldList, ds_type_list)) {
						ds_list_destroy(obj_control.navUnitFieldList);
						obj_control.navUnitFieldList = navUnitFieldList;
					}
					
					// get navChunkFieldList, if supplied
					var navChunkFieldList = ds_map_find_value(map, "navChunkFieldList");
					if (scr_isNumericAndExists(navChunkFieldList, ds_type_list)) {
						ds_list_destroy(obj_control.navChunkFieldList);
						obj_control.navChunkFieldList = navChunkFieldList;
					}
					// get chunkFieldList, if supplied
					var chunkFieldList = ds_map_find_value(map, "chunkFieldList");
					if (scr_isNumericAndExists(chunkFieldList, ds_type_list)) {
						ds_list_destroy(obj_control.chunkFieldList);
						obj_control.chunkFieldList = chunkFieldList;
					}
					
					// get navTokenFieldList, if supplied
					var unitFieldList = ds_map_find_value(map, "unitFieldList");
					if (scr_isNumericAndExists(unitFieldList, ds_type_list)) {
						ds_list_destroy(obj_control.unitFieldList);
						obj_control.unitFieldList = unitFieldList;
					}
					
					
					// get chainEntryFieldList, if supplied
					var chainEntryFieldList = ds_map_find_value(map, "chainEntryFieldList");
					if (!is_undefined(chainEntryFieldList)) {
						ds_list_destroy(global.chainEntryFieldList);
						global.chainEntryFieldList = chainEntryFieldList;
					}
					
					
					// get chainFieldList, if supplied
					var chainFieldList = ds_map_find_value(map, "chainFieldList");
					if (!is_undefined(chainFieldList)) {
						ds_list_destroy(global.chainFieldList);
						global.chainFieldList = chainFieldList;
					}

					

					
					
	
					
					// get displayTokenField & speakerField
					var getDisplayTokenField = ds_map_find_value(map, "displayTokenField");
					var getSpeakerField = ds_map_find_value(map, "speakerField");
					if (is_string(getDisplayTokenField)) global.displayTokenField = getDisplayTokenField;
					if (is_string(getSpeakerField)) global.speakerField = getSpeakerField;
					
					// get discourse node
					global.discourseNode = map[? "discourseNode"];
					if (!ds_map_exists(global.nodeMap, global.discourseNode)) {
					}
					
					
					if (ds_map_exists(map, "sessionLength")) {
						var sessionLength = map[? "sessionLength"];
						if (is_numeric(sessionLength)) obj_control.loadSessionLength = sessionLength;
					}
				}
			}		
		}
	}

	ds_list_destroy(newInstList);


	scr_verifyRez(rezFileVerison);
	
	
	// set focused unit in panelPane
	with (obj_panelPane) {
		alarm[9] = 2;
	}
	


}
