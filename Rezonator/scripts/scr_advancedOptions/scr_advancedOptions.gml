function scr_advancedOptions(optionSelected) {

	switch (optionSelected)
	{
	

		case "menu_developer":
			obj_control.showDevVars = !obj_control.showDevVars;
			obj_control.showFPS = !obj_control.showFPS;
			instance_destroy(obj_dropDown);
		break;
		

		

		case "help_label_restore-sequence":
		
				ds_grid_copy(obj_control.lineGrid, obj_control.lineGridBackup);

		
				instance_destroy(obj_dropDown);
		break;
	

		case "Media"://needs filling out
			var dropDownOptionList = ds_list_create();
			ds_list_add(dropDownOptionList, "help_label_play", "help_label_mute");
						
			if (ds_list_size(dropDownOptionList) > 0) {
				scr_createDropDown(obj_dropDown.x + obj_dropDown.windowWidth, obj_dropDown.y + obj_dropDown.optionSpacing, dropDownOptionList, global.optionListTypeClear);
			}
		break;
	
		default:
			break;
	}


}
