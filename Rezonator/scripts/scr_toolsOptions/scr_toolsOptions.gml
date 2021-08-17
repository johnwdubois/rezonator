function scr_toolsOptions(optionSelected) {
	//toolsOptions

	switch (optionSelected)
	{
		case "menu_search":
			scr_destroyAllDropDownsOtherThanSelf();
			var dropDownOptionList = ds_list_create();
			ds_list_add(dropDownOptionList, "menu_keyword", "menu_clear");
						
			if (ds_list_size(dropDownOptionList) > 0) {
				scr_createDropDown(obj_dropDown.x + obj_dropDown.windowWidth, obj_dropDown.y, dropDownOptionList, global.optionListTypeSearch);
			}
			break;
		case "menu_resonance":
			with (obj_panelPane) {
				if (currentFunction == functionChainList) {
					functionChainList_currentTab = functionChainList_tabRezBrush;
				}
			}
			with (obj_toolPane) {
				currentMode = modeRez;
				if(obj_control.searchGridActive) {
					obj_toolPane.setModeSearch = obj_toolPane.modeRez;
				}
				else {
					obj_toolPane.setModeMain = obj_toolPane.modeRez;
				}
			}
			with (obj_dropDown) {
				instance_destroy();
			}
			break;
		case "menu_track":
			with (obj_panelPane) {
				if (currentFunction == functionChainList) {
					functionChainList_currentTab = functionChainList_tabTrackBrush;
				}
			}
			with (obj_toolPane) {
				currentMode = modeTrack;
				if(obj_control.searchGridActive) {
					obj_toolPane.setModeSearch = obj_toolPane.modeTrack;
				}
				else {
					obj_toolPane.setModeMain = obj_toolPane.modeTrack;
				}
			}
			with (obj_dropDown) {
				instance_destroy();
			}
			break;
		case "help_label_tag":
			with(obj_panelPane){
				if(currentFunction = functionChainList){
					functionChainList_currentTab = functionChainList_tabField;
				}
			}
			with (obj_toolPane){
				currentMode = modeRead;
			}
			with(obj_dropDown){
				instance_destroy();	
			}
			break;
		case "menu_stack":
			scr_destroyAllDropDownsOtherThanSelf();
			var dropDownOptionList = ds_list_create();
			ds_list_add(dropDownOptionList, "menu_stacker", "menu_clip-all", "menu_tree-all");
						
			if (ds_list_size(dropDownOptionList) > 0) {
				scr_createDropDown(obj_dropDown.x + obj_dropDown.windowWidth, obj_dropDown.y + (obj_dropDown.optionSpacing * 4), dropDownOptionList, global.optionListTypeStack);
			}
			break;
		default:
			break;
	}


}
