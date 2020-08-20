/*
	scr_saveSch(autosave);
	
	Last Updated: 2020-08-19
	
	Called from: obj_fileLoader
	
	Purpose: Save all user defined feilds durring import for easy reuse
	
	Mechanism: Organize the data into maps, then transfer those maps as JSON strings into the user specified file location
	
	Author: Brady Moore
*/


var fileName = get_save_filename_ext("Schema file|*.rzs", string_lettersdigits("Schema"), global.rezonatorSchemaDirString, "Choose a Location for the Schema file");
// Check if the name is valid, or if the user exited the window
if (fileName == "" or fileName == "undefined") {
	show_message("Error in saving");
	exit;
}





//show_message(program_directory);
var rootList = ds_list_create();

var map = ds_map_create();
ds_list_add(rootList, map);
ds_list_mark_as_map(rootList, ds_list_size(rootList) - 1);
	

var tempList = ds_list_create();
if (global.previousLevelEstimates != undefined) {
	ds_list_copy(tempList, global.previousLevelEstimates);
}
ds_map_add_list(map, "previousLevelEstimates", tempList);
		


var tempList2 = ds_list_create();
if (global.previousSpecialFields  != undefined) {
	ds_list_copy(tempList2, global.previousSpecialFields);
}
ds_map_add_list(map, "previousSpecialFields", tempList2);
		

var wrapper = ds_map_create();
ds_map_add_list(wrapper, "ROOT", rootList);

var jsonString = json_encode(wrapper);
jsonString = scr_jsonBeautify(jsonString);





scr_saveFileBuffer(working_directory + filename_name(fileName), fileName, jsonString);


ds_map_destroy(wrapper);
