function scr_searchOptions(optionSelected) {

	switch (optionSelected)
	{
		case "menu_keyword": // search for words
		
			obj_control.preSwitchDisplayRow = obj_control.scrollPlusYDest;
			if (!obj_control.dialogueBoxActive) {
				keyboard_string = "";
				obj_control.fPressed = true;
			}


			obj_control.dialogueBoxActive = true;

			if (!instance_exists(obj_dialogueBox)) {
				instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
			}
			obj_dialogueBox.inputWindowActive = true;

			break;

		case "menu_clear":// clear search
			
			// Commented out so that Clear search only removes highlights
			/*ds_grid_copy(obj_control.searchGrid, obj_control.emptySearchGrid);
			ds_grid_copy( obj_control.hitGrid,obj_control.emptyHitGrid);
			
			
			obj_control.searchGridActive = false;
			obj_control.filterGridActive = false;
			obj_control.currentActiveLineGrid = obj_control.lineGrid;
			obj_toolPane.currentMode = obj_toolPane.setModeMain;
			obj_control.scrollPlusYDest = obj_control.preSwitchDisplayRow;
			with (obj_alarm) {
				alarm[0] = 5;
			}*/
		
			obj_control.clearSearch = true;

			break;

		default:
			break;
	}


}
