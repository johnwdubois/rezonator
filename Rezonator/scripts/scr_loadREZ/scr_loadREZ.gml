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




	var filename = "";

	if(global.selectedFile != ""){
		var fileName = global.selectedFile;
		
	}
	else{
		if (directory_exists(global.rezonatorDirString)) {
			var fileName = get_open_filename_ext("REZ file|*.rez", "", RezDirString, "Open REZ");
		}
		else {
			var fileName = get_open_filename_ext("REZ file|*.rez", "", program_directory, "Open REZ");
		}
	}

	if (fileName == "" or not file_exists(fileName)) {
		show_debug_message("Going to openingScreen, scr_loadREZ");
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
		scr_addToRecentFiles(string(fileName));
		var wrapper = scr_loadJSONBuffer(fileName);
	
		if (not ds_exists(wrapper, ds_type_map)) {
			show_debug_message("Going to openingScreen, scr_loadREZ");
			show_message("Error loading " + fileName);
			room_goto(rm_openingScreen);
			exit;
		}
	
		var list = ds_map_find_value(wrapper, "ROOT");
	
		if (is_undefined(list)) {
			show_debug_message("Going to openingScreen, scr_loadREZ");
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
			
					global.importGridWidth = ds_map_find_value(map, "importGridWidth");
					global.importCSVGridWidth = ds_map_find_value(map, "importCSVGridWidth");
					rezFileVerison = ds_map_find_value(map, "version");
				
					global.unitDelimField = ds_map_find_value(map, "unitDelimField");
					global.unitImportTurnDelimColName = ds_map_find_value(map, "unitImportTurnDelimColName");
					global.psentDelimField = ds_map_find_value(map, "psentDelimField");
					global.wordDelimField = ds_map_find_value(map, "wordImportWordDelimColName");
					global.currentTranslation = ds_map_find_value(map, "currentTranslation");
					global.unitImportSpeakerColName = ds_map_find_value(map, "unitImportSpeakerColName");
					global.unitImportUnitEndColName = ds_map_find_value(map, "unitImportUnitEndColName");
					global.unitImportUnitStartColName = ds_map_find_value(map, "unitImportUnitStartColName");
					global.tokenImportTranscriptColName = ds_map_find_value(map, "tokenImportTranscriptColName");
					global.tokenImportDisplayTokenColName = ds_map_find_value(map, "tokenImportDisplayTokenColName");
					with(obj_panelPane){
						functionChainList_focusedUnit = ds_map_find_value(map, "functionChainList_focusedUnit");
						functionChainList_focusedUnitIndex = ds_map_find_value(map, "functionChainList_focusedUnitSeq");
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
				
					if (ds_map_find_value(map, "showParticipantName") != undefined) {
						obj_control.showSpeakerName = ds_map_find_value(map, "showParticipantName");
						show_debug_message("scr_loadREZ, showParticipantName: " + string(obj_control.showSpeakerName));
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
					obj_chain.chainShowMap = global.nodeMap[? "chainShowMap"];
				
				
					if (is_undefined(global.importGridColNameList)) {
						var tempList3 = ds_list_create();
						global.importGridColNameList = tempList3;
					}

					obj_control.navTokenFieldList = scr_loadListFromMap(map, "navTokenFieldList", obj_control.navTokenFieldList);
					obj_control.tokenFieldList = scr_loadListFromMap(map, "tokenFieldList", obj_control.tokenFieldList);
					obj_control.navUnitFieldList = scr_loadListFromMap(map, "navUnitFieldList", obj_control.navUnitFieldList);
					obj_control.navChunkFieldList = scr_loadListFromMap(map, "navChunkFieldList", obj_control.navChunkFieldList);
					obj_control.chunkFieldList = scr_loadListFromMap(map, "chunkFieldList", obj_control.chunkFieldList);
					obj_control.unitFieldList = scr_loadListFromMap(map, "unitFieldList", obj_control.unitFieldList);
					global.chainEntryFieldList = scr_loadListFromMap(map, "chainEntryFieldList", global.chainEntryFieldList);
					global.chainFieldList = scr_loadListFromMap(map, "chainFieldList", global.chainFieldList);
					obj_chain.cliqueList = scr_loadListFromMap(map, "cliqueList", obj_chain.cliqueList);
	
		
					// get displayTokenField & participantField
					var getDisplayTokenField = ds_map_find_value(map, "displayTokenField");
					var getParticipantField = ds_map_find_value(map, "participantField");
					if (is_string(getDisplayTokenField)) global.displayTokenField = getDisplayTokenField;
					if (is_string(getParticipantField)) global.participantField = getParticipantField;
					
					// get discourse node
					global.discourseNode = map[? "docNode"];
					if (is_undefined(global.discourseNode)) {
						global.discourseNode = map[? "discourseNode"];
					}


					// get session length
					if (ds_map_exists(map, "sessionLength")) {
						var sessionLength = map[? "sessionLength"];
						if (is_numeric(sessionLength)) obj_control.loadSessionLength = sessionLength;
					}
					
					// get resonance counter
					if (ds_map_exists(map, "resonanceCounter")) {
						var resonanceCounter = map[? "resonanceCounter"];
						if (is_numeric(resonanceCounter)) obj_chain.rezChainNameCounter = resonanceCounter;
					}
					// get trail counter
					if (ds_map_exists(map, "trailCounter")) {
						var trailCounter = map[? "trailCounter"];
						if (is_numeric(trailCounter)) obj_chain.trackChainNameCounter = trailCounter;
					}
					// get stack counter
					if (ds_map_exists(map, "stackCounter")) {
						var stackCounter = map[? "stackCounter"];
						if (is_numeric(stackCounter)) obj_chain.stackChainNameCounter = stackCounter;
					}
					// get audioFile
					if (ds_map_exists(map, "audioFile")) {
						var audioFile = map[? "audioFile"];
						show_debug_message("audioFile: " + string(audioFile))
						if (file_exists(audioFile)){
							obj_fileLoader.importedAudioFile = audioFile;
							show_debug_message("obj_fileLoader.importedAudioFile:  "+string(obj_fileLoader.importedAudioFile));
						}
					}
				}
			}		
		}
	}
	
	scr_openFileRefreshCliques();

	ds_list_destroy(newInstList);
	
	var exitToOpeningScreen = scr_verifyRez(rezFileVerison);
	if (exitToOpeningScreen) {
		show_debug_message("scr_loadREZ ... verifyREZ has failed, exiting to opening screen");
		room_goto(rm_openingScreen);
		exit;
	}
	else {
		scr_refreshPrevToken();
	}
	
	
	
	

	


}
