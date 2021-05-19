function scr_mappingTagOptions(optionSelected) {

	var levelToSet = global.levelToken;
	switch (optionSelected)
	{
		case "Token":
			levelToSet = global.levelToken;
			break;
		case "Word":
			levelToSet = global.levelWord;
			break;
		case "Unit":
			levelToSet = global.levelUnit;
			break;
		case "Discourse":	
			levelToSet = global.levelDiscourse;
			break;
		case "EXCEPTION":
			levelToSet = global.levelUnknown;
			break;
		default:
			break;
	}
	
	// set level
	ds_grid_set(global.tagInfoGrid, obj_importMapping.colToChange, obj_importMapping.rowToChange, levelToSet);
	ds_grid_set(global.tagInfoGrid, global.tagInfoGrid_colLevel, obj_importMapping.rowToChange, levelToSet);
	
	// clear special fields & key for this row
	ds_grid_set(global.tagInfoGrid, global.tagInfoGrid_colSpecialFields, obj_importMapping.rowToChange , "");
	ds_grid_set(global.tagInfoGrid, global.tagInfoGrid_colKey, obj_importMapping.rowToChange , "");
	
	// update error column
	obj_importMapping.updatedErrorCol = false;

	with(obj_dropDown){
		instance_destroy();
	}


}
