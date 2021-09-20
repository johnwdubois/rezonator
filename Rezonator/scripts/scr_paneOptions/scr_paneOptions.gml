function scr_paneOptions(optionSelected) {
	//paneOptions

	switch (optionSelected)
	{
		case "menu_main":
	
		break;
		case "menu_search":

		break;
		case "menu_nav": // Show/hide Nav Window
		
			var dropDownOptionList = ds_list_create();
			ds_list_add(dropDownOptionList, "menu_left", "menu_right", "menu_nav", "menu_tools", "menu_all");
						
			if (ds_list_size(dropDownOptionList) > 0) {
				scr_createDropDown(x + windowWidth, y, dropDownOptionList, global.optionListTypeNav);
			}

			break;
		
		break;
		case "menu_grid": // show grid view
			obj_control.gridView = !obj_control.gridView;
			instance_destroy();
		break;
		case "Dev": // show grid view
			obj_control.showDevVars = !obj_control.showDevVars;
			obj_control.showFPS = !obj_control.showFPS;
			instance_destroy();
		break;
	}


}
