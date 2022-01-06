function scr_tagSchemaOptions(optionSelected) {
	
	/*
	if (optionSelected =="Custom tag schema") {
		var fileName = get_open_filename_ext("Tag file|*.json", "", global.rezonatorSchemaDirString, "Open Tag JSON");
		scr_addToListOnce(global.selectedTagSchemaFileList, fileName);
	}
	else{
		scr_addToListOnce(global.selectedTagSchemaFileList, optionSelected);
	}
	*/

	instance_destroy(obj_dropDown);
}
