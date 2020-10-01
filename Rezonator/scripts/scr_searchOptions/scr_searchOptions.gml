function scr_searchOptions(argument0) {
	var optionSelected = argument0;

	switch (optionSelected)
	{
		case "Keyword": // search for words
		
			obj_control.preSwitchDisplayRow = obj_control.scrollPlusYDest;
			if (!obj_control.dialogueBoxActive) {
				keyboard_string = "";
				obj_control.fPressed = true;
			}


			obj_control.dialogueBoxActive = true;

			if (!instance_exists(obj_dialogueBox)) {
				instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
			}

			break;

		case "Clear":// clear search
		
			ds_grid_copy(obj_control.searchGrid, obj_control.emptySearchGrid);
			ds_grid_copy( obj_control.hitGrid,obj_control.emptyHitGrid);
			
			
			obj_control.searchGridActive = false;
			obj_control.filterGridActive = false;
			obj_control.currentActiveLineGrid = obj_control.lineGrid;
			//obj_control.preSwitchSearchDisplayRow = obj_control.scrollPlusYDest;
			obj_control.scrollPlusYDest = obj_control.preSwitchDisplayRow;
			with (obj_alarm) {
				alarm[0] = 5;
			}
		
			obj_control.clearSearch = true;

			break;

		default:
			break;
	}


}
