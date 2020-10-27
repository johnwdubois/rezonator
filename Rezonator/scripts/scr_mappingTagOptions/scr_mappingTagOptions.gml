function scr_mappingTagOptions(argument0) {
	var optionSelected = argument0;

	switch (optionSelected)
	{
		case "Token":
			ds_grid_set(global.tagInfoGrid, obj_importMapping.colToChange, obj_importMapping.rowToChange , global.levelToken);
			break;
		case "Word":
			ds_grid_set(global.tagInfoGrid, obj_importMapping.colToChange, obj_importMapping.rowToChange , global.levelWord);
			break;
		case "Unit":
			ds_grid_set(global.tagInfoGrid, obj_importMapping.colToChange, obj_importMapping.rowToChange , global.levelUnit);
			break;
		case "Discourse":	
			ds_grid_set(global.tagInfoGrid, obj_importMapping.colToChange, obj_importMapping.rowToChange , global.levelDiscourse);
			break;
		case "Exception":
			ds_grid_set(global.tagInfoGrid, obj_importMapping.colToChange, obj_importMapping.rowToChange , global.levelUnknown);
			break;
		default:
			break;
	}
	
	// clear special fields for this row
	ds_grid_set(global.tagInfoGrid, global.tagInfoGrid_colSpecialFields , obj_importMapping.rowToChange , "");
	
	// update error column
	obj_importMapping.updatedErrorCol = false;

	with(obj_dropDown){
		instance_destroy();
	}


}
