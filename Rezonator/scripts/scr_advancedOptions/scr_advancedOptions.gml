function scr_advancedOptions(argument0) {
	var optionSelected = argument0;

	switch (optionSelected)
	{
	
		/*case "Add Tag Category":
		

			if (!instance_exists(obj_dialogueBox)) {
				instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
				obj_dialogueBox.clearAllLinks = true;
				obj_dialogueBox.questionWindowActive = true;
			}
		
			
			//show_message("Coming Soon");
			break;*/
		case "Developer":
			obj_control.showDevVars = !obj_control.showDevVars;
			obj_control.showFPS = !obj_control.showFPS;
			instance_destroy(obj_dropDown);
		break;
		case "Shuffle":
			obj_control.lineGridShuffle = !obj_control.lineGridShuffle;
			if (obj_control.lineGridShuffle) {
				scr_shuffleDisplayRows();
				scr_refreshLineGridDisplayRow(obj_control.lineGrid);
			}
			else {
				ds_grid_copy(obj_control.lineGrid, obj_control.lineGridBackup);
				scr_refreshLineGridPixelY();
				scr_refreshLineGridDisplayRow(obj_control.lineGrid);
			}
		
			instance_destroy(obj_dropDown);
		break;
	

		case "Media"://needs filling out
			var dropDownOptionList = ds_list_create();
			ds_list_add(dropDownOptionList, "Play", "Mute");
						
			if (ds_list_size(dropDownOptionList) > 0) {
				var dropDownInst = instance_create_depth(obj_dropDown.x + obj_dropDown.windowWidth , obj_dropDown.y + (obj_dropDown.optionSpacing), -999, obj_dropDown);
				dropDownInst.optionList = dropDownOptionList;
				dropDownInst.optionListType = 20;
					
				obj_control.ableToCreateDropDown = false;
				obj_control.alarm[0] = 2;
			}
		break;
	
		default:
			break;
	}


}
