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
			//, "menu_sentence"
			ds_list_add(dropDownOptionList,  "menu_turn", "menu_random");
			if (ds_list_size(dropDownOptionList) > 0) {
				scr_createDropDown(x + windowWidth, y + (optionSpacing ), dropDownOptionList, global.optionListTypeCreateStack);
			}
			break;
		default:
			break;
	}


}
