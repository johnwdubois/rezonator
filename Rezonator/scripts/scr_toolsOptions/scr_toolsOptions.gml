function scr_toolsOptions(optionSelected) {
	//toolsOptions

	switch (optionSelected)
	{
		case "menu_search":
			scr_destroyAllDropDownsOtherThanSelf();
			var dropDownOptionList = ds_list_create();
			ds_list_add(dropDownOptionList, "Keyword", "Clear");
						
			if (ds_list_size(dropDownOptionList) > 0) {
				scr_createDropDown(obj_dropDown.x + obj_dropDown.windowWidth, obj_dropDown.y, dropDownOptionList, global.optionListTypeSearch);
			}
			break;
		case "menu_rez":
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
		case "menu_stack":
			scr_destroyAllDropDownsOtherThanSelf();
			var dropDownOptionList = ds_list_create();
			ds_list_add(dropDownOptionList, "Stack tab", "StackShow", "Stacker");
						
			if (ds_list_size(dropDownOptionList) > 0) {
				scr_createDropDown(obj_dropDown.x + obj_dropDown.windowWidth, obj_dropDown.y + (obj_dropDown.optionSpacing * 3), dropDownOptionList, global.optionListTypeStack);
			}
			break;
			
		case "Play and Learn":
			scr_destroyAllDropDownsOtherThanSelf();
			var dropDownOptionList = ds_list_create();
			ds_list_add(dropDownOptionList, "Where's Elmo");
						
			if (ds_list_size(dropDownOptionList) > 0) {
				scr_createDropDown(obj_dropDown.x + obj_dropDown.windowWidth, obj_dropDown.y + (obj_dropDown.optionSpacing * 4), dropDownOptionList, global.optionListTypePlayAndLearn);
			}
		break;
		default:
			break;
	}


}
