/*
	scr_saveRez(autosave);
	
	Last Updated: 2020-01-01
	
	Called from: obj_fileLoader
	
	Purpose: Save all user created data into a special type of JSON file, a Rez file
	
	Mechanism: Organize the data into maps, then transfer those maps as JSON strings into the user specified file location
	
	Author: Terry DuBois
*/


var autosave = argument0;

/*if (global.games) {
	autosave = false;
}*/



if (not autosave) {
	if (global.fileSaveName == "undefined" or (not file_exists(global.fileSaveName) and not obj_stacker.splitSave)) {
		global.fileSaveName = get_save_filename_ext("REZ file|*.rez", "", program_directory, "Save REZ");

		if (global.fileSaveName == "" or global.fileSaveName == "undefined") {
			global.fileSaveName = "undefined";
			show_message("Error in saving");
			exit;
		}
	
		if (string_count(program_directory, global.fileSaveName) > 0) {
			show_message("Error in saving. Please save outside of Rezonator program directory.");
			scr_saveREZ(false);
			exit;
		}
	}
}

// Prevent users from overwriting default discourse files
if(os_type == os_macosx){
	if(filename_path(global.fileSaveName) == global.rezonatorDefaultDiscourseDirString + "/" and not autosave) {
		show_message("Error in saving. Please save file outside of Default Discourse folder");
		global.fileSaveName = "";
		scr_saveREZ(false);
		exit;
		//autosave = false;
	}
}
else {
	if(filename_path(global.fileSaveName) == global.rezonatorDefaultDiscourseDirString + "\\" and not autosave) {
		show_message("Error in saving. Please save file outside of Default Discourse folder");
		global.fileSaveName = "";
		scr_saveREZ(false);
		exit;
		//autosave = false;
	}
}

//show_message(program_directory);
var rootList = ds_list_create();

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
		var mapunitImport = scr_gridToJSONLists(global.unitImportGrid);
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
		ds_map_add_list(map, "unitImport", mapunitImport);
		ds_map_add_list(map, "CustomLabelGrid", mapCustomLabelGrid);
		var tempList2 = ds_list_create();
		if (global.tokenImportColNameList  != undefined) {
			ds_list_copy(tempList2, global.tokenImportColNameList);
		}
		ds_map_add_list(map, "tokenImportColNameList", tempList2);
		
		//save special feild colnames
		ds_map_add(map, "unitImportUnitDelimColName", global.unitImportUnitDelimColName);
		ds_map_add(map, "unitImportTurnDelimColName", global.unitImportTurnDelimColName);
		
		
		
	
		
		
		if (global.stackGrabSave) {
			ds_map_add(map, "subLineGridBeginning", obj_fileLoader.subLineGridBeginning);
			ds_map_add(map, "subLineGridEnd", obj_fileLoader.subLineGridEnd);
		}
		else {
			ds_map_add(map, "subLineGridBeginning", -1);
			ds_map_add(map, "subLineGridEnd", -1);
		}
		
	}
	else if (object_index == obj_chain) {
		var mapLinkGrid = scr_gridToJSONLists(linkGrid);
		var mapRezChainGrid = scr_gridToJSONLists(rezChainGrid);
		var mapTrackChainGrid = scr_gridToJSONLists(trackChainGrid);
		var mapStackChainGrid = scr_gridToJSONLists(stackChainGrid);
		var mapChunkChainGrid = scr_gridToJSONLists(chunkGrid);
		var mapUnitInStackGrid = scr_gridToJSONLists(unitInStackGrid);
		var mapCliqueGrid = scr_gridToJSONLists(cliqueGrid);
		var mapGoldStandardGrid = scr_gridToJSONLists(goldStandardGrid);
		

		ds_map_add_list(map, "linkGrid", mapLinkGrid);
		ds_map_add_list(map, "rezChainGrid", mapRezChainGrid);
		ds_map_add_list(map, "trackChainGrid", mapTrackChainGrid);
		ds_map_add_list(map, "stackChainGrid", mapStackChainGrid);
		ds_map_add_list(map, "chunkChainGrid", mapChunkChainGrid);
		ds_map_add_list(map, "unitInStackGrid", mapUnitInStackGrid);
		ds_map_add_list(map, "cliqueGrid", mapCliqueGrid);
		ds_map_add_list(map, "goldStandardGrid", mapGoldStandardGrid);
		
		
		ds_map_add(map, "chainColorID1", chainColorID[1]);
		ds_map_add(map, "chainColorID2", chainColorID[2]);
		ds_map_add(map, "chainColorID3", chainColorID[3]);
	}
	var tempMap = ds_map_create();
	ds_map_copy(tempMap, global.tokenImportTagMap);
	ds_map_add_map(map, "tokenImportTagMap", tempMap);
}

var wrapper = ds_map_create();
ds_map_add_list(wrapper, "ROOT", rootList);

var jsonString = json_encode(wrapper);
jsonString = scr_jsonBeautify(jsonString);

if (autosave) {
	if(global.games) {
		var gameSaveDirString = (global.rezzles ? global.rezonatorRezzlesSaveDirString : global.rezonatorElmoSaveDirString) ;
		
		if (directory_exists(gameSaveDirString)) {
			//show_message(date_time_string(date_current_datetime()));
			var userString = (global.userName == "") ? ("player " + string_replace_all(date_time_string(date_current_datetime()), ":" , ".")) : global.userName;
			//show_message(userString);
			var fileName = filename_change_ext(filename_name(global.fileSaveName), "") + " - " + userString + ".rez";
			//show_message(fileName);

			scr_saveFileBuffer(0, gameSaveDirString + "\\" + fileName, jsonString);
		}
		else {
			//scr_saveFileBuffer(working_directory + "autosave.rez", working_directory + "autosave.rez", jsonString);
			show_message(string(gameSaveDirString) + " does not exist");
		}
	}
	else {
		if(os_type == os_macosx){
			if (directory_exists(global.rezonatorDirString + "/Autosave")) {
		
				scr_saveFileBuffer(working_directory + "autosave.rez", global.rezonatorDirString + "/Autosave/autosave.rez", jsonString);
			}
			else {
				scr_saveFileBuffer(working_directory + "autosave.rez", working_directory + "autosave.rez", jsonString);
			}
		}
		else{
			if (directory_exists(global.rezonatorDirString + "\\Autosave")) {
		
				scr_saveFileBuffer(working_directory + "autosave.rez", global.rezonatorDirString + "\\Autosave\\autosave.rez", jsonString);
			}
			else {
				scr_saveFileBuffer(working_directory + "autosave.rez", working_directory + "autosave.rez", jsonString);
			}
		}
	}
}
else {
	scr_saveFileBuffer(working_directory + filename_name(global.fileSaveName), global.fileSaveName, jsonString);
}

ds_map_destroy(wrapper);

// Export the grids to CSV format
//if(not global.games) {
//	scr_exportGrids();
//}
if (not autosave) {
	obj_control.allSaved = true;
}