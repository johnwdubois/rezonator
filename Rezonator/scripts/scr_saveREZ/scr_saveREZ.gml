var autosave = argument0;

/*if (global.games) {
	autosave = false;
}*/



if (not autosave) {
	if (global.fileSaveName == "undefined" or not file_exists(global.fileSaveName)) {
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

if (filename_path(global.fileSaveName) == global.rezonatorDefaultDiscourseDirString + "\\") {
	show_message("Save file outside of Default Discourse folder");
	global.fileSaveName = "";
	scr_saveREZ(false);
	exit;
	//autosave = false;
}


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
		
		ds_map_add_list(map, "fileLineRipGrid", mapFileLineRipGrid);
		ds_map_add_list(map, "wordGrid", mapWordGrid);
		ds_map_add_list(map, "wordGridColList", mapWordGridColList);
		ds_map_add_list(map, "dynaWordGrid", mapDynaWordGrid);
		ds_map_add_list(map, "wordDrawGrid", mapWordDrawGrid);
		ds_map_add_list(map, "unitGrid", mapUnitGrid);
		ds_map_add_list(map, "lineGrid", mapLineGrid);
		
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
	
}

var wrapper = ds_map_create();
ds_map_add_list(wrapper, "ROOT", rootList);

var jsonString = json_encode(wrapper);

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