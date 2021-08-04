// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_saveTagJson(){
	
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


	// save json
	var wrapper = ds_map_create();
	ds_map_add_list(wrapper, "ROOT", rootList);

	var jsonString = json_encode(wrapper);
	jsonString = scr_jsonBeautify(jsonString);

	scr_saveFileBuffer(working_directory + filename_name(fileName), fileName, jsonString);

	ds_map_destroy(wrapper);
	

}