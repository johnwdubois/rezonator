function scr_toolsOptions(optionSelected) {
	//toolsOptions
	var optionIndex = ds_list_find_index(optionList, optionSelected);
	show_debug_message("scr_toolsOptions, optionSelected: " + string(optionSelected));

	switch (optionSelected)
	{
		case "menu_search":
			scr_searchOptions("menu_keyword");
			with (obj_dropDown) instance_destroy();
			break;
		case "menu_resonance":
			with (obj_panelPane) {
				if (currentFunction == functionChainList) {
					functionChainList_currentTab = NAVTAB_RESONANCE;
				}
			}
			with (obj_toolPane) {
				currentMode = modeRez;
				if (obj_control.currentView == obj_control.searchView) {
					obj_toolPane.setModeSearch = obj_toolPane.modeRez;
				}
				else {
					obj_toolPane.setModeMain = obj_toolPane.modeRez;
				}
			}
			obj_wordTip.wordTipDisplay = false;
			with (obj_dropDown) {
				instance_destroy();
			}
			break;
		case "menu_track":
			with (obj_panelPane) {
				if (currentFunction == functionChainList) {
					functionChainList_currentTab = NAVTAB_TRACK;
				}
			}
			with (obj_toolPane) {
				currentMode = modeTrack;
				if (obj_control.currentView == obj_control.searchView) {
					obj_toolPane.setModeSearch = obj_toolPane.modeTrack;
				}
				else {
					obj_toolPane.setModeMain = obj_toolPane.modeTrack;
				}
			}
			obj_wordTip.wordTipDisplay = false;
			with (obj_dropDown) {
				instance_destroy();
			}
			break;
		case "help_label_tag":
			with (obj_panelPane) {
				if (currentFunction = functionChainList) {
					functionChainList_currentTab = NAVTAB_TAG;
				}
			}
			with (obj_toolPane) {
				currentMode = modeRead;
			}
			with (obj_dropDown) {
				instance_destroy();	
			}
			obj_wordTip.wordTipDisplay = true;
			break;
		case "menu_stacker":
			scr_destroyAllDropDownsOtherThanSelf();
			var dropDownOptionList = ds_list_create();
			//, "Unit Label"
			ds_list_add(dropDownOptionList,  "menu_turn", "menu_utterance", "menu_clique", "menu_random");
			if (ds_list_size(dropDownOptionList) > 0) {
				scr_createDropDown(x + windowWidth, y + (optionSpacing * optionIndex), dropDownOptionList, global.optionListTypeCreateStack);
			}
			break;

		default:
			break;
	}


}
