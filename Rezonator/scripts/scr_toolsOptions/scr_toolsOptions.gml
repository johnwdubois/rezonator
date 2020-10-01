function scr_toolsOptions(argument0) {
	//toolsOptions
	var optionSelected = argument0;

	switch (optionSelected)
	{
		case "Search":
			scr_destroyAllDropDownsOtherThanSelf();
			var dropDownOptionList = ds_list_create();
			ds_list_add(dropDownOptionList, "Keyword", "Clear");
						
			if (ds_list_size(dropDownOptionList) > 0) {
				var dropDownInst = instance_create_depth(obj_dropDown.x + obj_dropDown.windowWidth , obj_dropDown.y , -999, obj_dropDown);
				dropDownInst.optionList = dropDownOptionList;
				dropDownInst.optionListType = 7;
					
				obj_control.ableToCreateDropDown = false;
				obj_control.alarm[0] = 2;
			}
			break;
		case "Rez":
			with (obj_panelPane) {
				if (currentFunction == functionChainList) {
					functionChainList_currentTab = functionChainList_tabRezBrush;
				}
			}
			with (obj_toolPane) {
				currentMode = modeRez;
			}
			instance_destroy();
			break;
		case "Track":
			with (obj_panelPane) {
				if (currentFunction == functionChainList) {
					functionChainList_currentTab = functionChainList_tabTrackBrush;
				}
			}
			with (obj_toolPane) {
				currentMode = modeTrack;
			}
			instance_destroy();
			break;
		case "Stack":
			scr_destroyAllDropDownsOtherThanSelf();
			var dropDownOptionList = ds_list_create();
			ds_list_add(dropDownOptionList, "Stack tab", "StackShow", "Stacker");
						
			if (ds_list_size(dropDownOptionList) > 0) {
				var dropDownInst = instance_create_depth(obj_dropDown.x + obj_dropDown.windowWidth , obj_dropDown.y + (obj_dropDown.optionSpacing * 3), -999, obj_dropDown);
				dropDownInst.optionList = dropDownOptionList;
				dropDownInst.optionListType = 28;
					
				obj_control.ableToCreateDropDown = false;
				obj_control.alarm[0] = 2;
			}
			break;
		default:
			break;
	}


}
