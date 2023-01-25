function scr_saveTagJson() {
	
	if (global.html5) {
		show_message("Saving Tag JSON is currently not available for browser use.");
		exit;
	}
	
	var fileName = get_save_filename_ext("Tag file|*.json", "tag", global.rezonatorSchemaDirString, "Save Tag JSON");
	
	// Check if the name is valid, or if the user exited the window
	if (fileName == "" or fileName == "undefined") {
		show_message(scr_get_translation("save_error"));
		exit;
	}
	
	
	// set up file saving
	var rootList = ds_list_create();
	var map = ds_map_create();
	ds_list_add(rootList, map);
	ds_list_mark_as_map(rootList, ds_list_size(rootList) - 1);
	
	
	// copy token & unit tag maps into tag json
	var tokenTagMap = global.nodeMap[? "tokenTagMap"];
	var unitTagMap = global.nodeMap[? "unitTagMap"];
	ds_map_add_map(map, "tokenTagMap", json_decode(json_encode(tokenTagMap)));
	ds_map_add_map(map, "unitTagMap", json_decode(json_encode(unitTagMap)));
	
	// copy chain & entry tag maps into tag json
	var chainFieldMap = global.nodeMap[? "chainTagMap"];
	var entryFieldMap = global.nodeMap[? "entryTagMap"];
	ds_map_add_map(map, "chainTagMap", json_decode(json_encode(chainFieldMap)));
	ds_map_add_map(map, "entryTagMap", json_decode(json_encode(entryFieldMap)));
	
	// copy Link tag maps into tag json
	var linkFieldMap = global.nodeMap[? "linkTagMap"];
	ds_map_add_map(map, "linkTagMap", json_decode(json_encode(linkFieldMap)));
	
		
	#region save nav window lists to tag json
	var navTokenFieldListCopy = ds_list_create();
	var navUnitFieldListCopy = ds_list_create();
	var navChunkFieldListCopy = ds_list_create();
	var navRez1toManyFieldListCopy = ds_list_create();
	var navTrack1toManyFieldListCopy = ds_list_create();
	var navStack1toManyFieldListCopy = ds_list_create();
	var navRez1to1FieldListCopy = ds_list_create();
	var navTrack1to1FieldListCopy = ds_list_create();
	var navStack1to1FieldListCopy = ds_list_create();
	
	ds_list_copy(navTokenFieldListCopy, obj_control.navTokenFieldList);
	ds_list_copy(navUnitFieldListCopy, obj_control.navUnitFieldList);
	ds_list_copy(navChunkFieldListCopy, obj_control.navChunkFieldList);
	ds_list_copy(navRez1toManyFieldListCopy, obj_control.chain1toManyColFieldListRez);
	ds_list_copy(navTrack1toManyFieldListCopy, obj_control.chain1toManyColFieldListTrack);
	ds_list_copy(navStack1toManyFieldListCopy, obj_control.chain1toManyColFieldListStack);
	ds_list_copy(navRez1to1FieldListCopy, obj_control.chain1to1ColFieldListRez);
	ds_list_copy(navTrack1to1FieldListCopy, obj_control.chain1to1ColFieldListTrack);
	ds_list_copy(navStack1to1FieldListCopy, obj_control.chain1to1ColFieldListStack);
	
	//chain1to1ColFieldListRez
	ds_map_add_list(map, "navTokenFieldList", navTokenFieldListCopy);
	ds_map_add_list(map, "navUnitFieldList", navUnitFieldListCopy);
	ds_map_add_list(map, "navChunkFieldList", navChunkFieldListCopy);
	ds_map_add_list(map, "navRez1toManyFieldList", navRez1toManyFieldListCopy);
	ds_map_add_list(map, "navTrack1toManyFieldList", navTrack1toManyFieldListCopy);
	ds_map_add_list(map, "navStack1toManyFieldList", navStack1toManyFieldListCopy);
	ds_map_add_list(map, "navRez1to1FieldList", navRez1to1FieldListCopy);
	ds_map_add_list(map, "navTrack1to1FieldList", navTrack1to1FieldListCopy);
	ds_map_add_list(map, "navStack1to1FieldList", navStack1to1FieldListCopy);
	#endregion
	

	// save json
	var wrapper = ds_map_create();
	ds_map_add_list(wrapper, "ROOT", rootList);
	var jsonString = json_encode(wrapper);
	jsonString = scr_jsonBeautify(jsonString);
	scr_saveFileBuffer(working_directory + filename_name(fileName), fileName, jsonString);
	ds_map_destroy(wrapper);
	
	#region destroy the temporary copy lists
	ds_list_destroy(navTokenFieldListCopy);
	ds_list_destroy(navUnitFieldListCopy);
	ds_list_destroy(navChunkFieldListCopy);
	ds_list_destroy(navRez1toManyFieldListCopy);
	ds_list_destroy(navTrack1toManyFieldListCopy);
	ds_list_destroy(navStack1toManyFieldListCopy);
	ds_list_destroy(navRez1to1FieldListCopy);
	ds_list_destroy(navTrack1to1FieldListCopy);
	ds_list_destroy(navStack1to1FieldListCopy);
	#endregion

}