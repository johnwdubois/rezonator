/// @description load tags from selected jsons
show_debug_message("obj_alarm Alarm 0");

var tagListSize = ds_list_size(global.selectedTagSchemaFileList);
if (tagListSize > 0) {
	
	
	for (var i = 0; i < tagListSize; i++) {
		
		var currentTagSchemaFile = global.selectedTagSchemaFileList[|i];
		show_debug_message("currentTagSchemaFile: " + string(currentTagSchemaFile) + ", exists: " + string(file_exists(currentTagSchemaFile)));
		
		scr_loadTagJson(currentTagSchemaFile);
	}
	
}
else{
	scr_loadTagJson(global.includedTagSchemaFileList[|0]);
}
scr_saveINI();