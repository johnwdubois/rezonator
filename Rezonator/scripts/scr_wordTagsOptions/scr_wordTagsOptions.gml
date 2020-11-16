function scr_wordTagsOptions(optionSelected) {

	switch (optionSelected)
	{
		//"Happy", "Sad", "Playful", "Serious",
		case "Happy":
			ds_grid_set(obj_control.unitGrid, obj_control.unitGrid_colTag, obj_control.swapLinePos1-1, "Happy");
			break;
		case "Sad":
			ds_grid_set(obj_control.unitGrid, obj_control.unitGrid_colTag, obj_control.swapLinePos1-1, "Sad");
			break;
		case "Playful":
			ds_grid_set(obj_control.unitGrid, obj_control.unitGrid_colTag, obj_control.swapLinePos1-1, "Playful");
			break;
		case "Serious":
			ds_grid_set(obj_control.unitGrid, obj_control.unitGrid_colTag, obj_control.swapLinePos1-1, "Serious");
			break;
		case "Delete tag":
			ds_grid_set(obj_control.unitGrid, obj_control.unitGrid_colTag, obj_control.swapLinePos1-1, 0);
			break;
		default:
			break;
	}
	with(obj_dropDown){
		instance_destroy();
	}
	obj_control.rightClickonWord = false;


}
