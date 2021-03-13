function scr_stackOptions(optionSelected) {

	switch (optionSelected)
	{
		case "menu_stacktab":
			with (obj_panelPane) {
				if (currentFunction == functionChainList) {
					functionChainList_currentTab = functionChainList_tabStackBrush;
				}
			}
			with (obj_toolPane) {
				if (currentMode == modeRead) {
					currentMode = modeTrack;
					if(obj_control.searchGridActive) {
						obj_toolPane.setModeSearch = obj_toolPane.modeTrack;
					}
					else {
						obj_toolPane.setModeMain = obj_toolPane.modeTrack;
					}
				}
			}
			instance_destroy();
			break;
		case "menu_stacker":
			var dropDownOptionList = ds_list_create();
			ds_list_add(dropDownOptionList,  "menu_turn", "menu_sentence", "menu_random");
			if (ds_list_size(dropDownOptionList) > 0) {
				scr_createDropDown(x + windowWidth, y + (optionSpacing ), dropDownOptionList, global.optionListTypeCreateStack);
			}
			break;
		case "menu_stackshow":
		/*
			var dropDownOptionList = ds_list_create();
			ds_list_add(dropDownOptionList, "Create", "Run");
						
			if (ds_list_size(dropDownOptionList) > 0) {
				var dropDownInst = instance_create_depth(obj_dropDown.x + obj_dropDown.windowWidth , obj_dropDown.y + obj_dropDown.optionSpacing  , -999, obj_dropDown);
				dropDownInst.optionList = dropDownOptionList;
				dropDownInst.optionListType = 25;
					
				obj_control.ableToCreateDropDown = false;
				obj_control.alarm[0] = 2;
			}
		*/
	
				if(obj_control.currentStackShowListPosition == -1) {
					obj_control.prevCenterYDest = obj_control.scrollPlusYDest;
					// Instantiate the screen for users to select which stacks go in the stackShow

					if (!instance_exists(obj_stackShow)) {
						instance_create_layer(x, y, "InstancesAudio", obj_stackShow);
					}
						obj_control.stackShowWindowActive = true;
				}
				instance_destroy(obj_dropDown);
			break;
		default:
			break;
	}


}
