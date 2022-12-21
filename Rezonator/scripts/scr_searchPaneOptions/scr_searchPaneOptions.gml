function scr_searchPaneOptions(optionSelected){
	
	var optionIndex = ds_list_find_index(optionList, optionSelected);
//"Add to Trail", "Add to Resonance", "Add to Stack", "Remove from Search"
// localize
	if(optionSelected == "Add to Trail"){
		scr_destroyAllDropDownsOtherThanSelf();
		var dropDownOptionList = ds_list_create();
		// localize
		ds_list_add(dropDownOptionList, "Create New Chain");
		var currentTrackList = global.nodeMap[?"trailList"];
		obj_control.searchChainType = "trail";
		var currentTrackListSize = ds_list_size(currentTrackList);
		var i = 0;
		repeat(currentTrackListSize){
			ds_list_add(dropDownOptionList, currentTrackList[|i]);
			i++;
		}
		scr_createDropDown(x + obj_dropDown.windowWidth, y + (obj_dropDown.optionSpacing * optionIndex), dropDownOptionList, global.optionListTypeSearchChain);

	}
	else if(optionSelected == "Add to Resonance"){
		scr_destroyAllDropDownsOtherThanSelf();
		var dropDownOptionList = ds_list_create();
		ds_list_add(dropDownOptionList, "Create New Chain");
		var currentRezList = global.nodeMap[?"resonanceList"];
		obj_control.searchChainType = "resonance";
		var currentTrackListSize = ds_list_size(currentRezList);
		var i = 0;
		repeat(currentTrackListSize){
			ds_list_add(dropDownOptionList, currentRezList[|i]);
			i++;
		}
		scr_createDropDown(x + obj_dropDown.windowWidth, y + (obj_dropDown.optionSpacing * optionIndex), dropDownOptionList, global.optionListTypeSearchChain);

	}
	else if(optionSelected == "Add to Stack"){
		show_debug_message("coming SOON");
		with(obj_dropDown){
			instance_destroy();
		}
	}
	else if(optionSelected == "Remove from Search"){
		
		var searchSubMap = global.searchMap[? obj_panelPane.functionSearchList_searchSelected];
		if (scr_isNumericAndExists(searchSubMap, ds_type_map)) {
			var selectedTokenList = searchSubMap[? "selectedTokenList"];
			var displayTokenList = searchSubMap[? "displayTokenList"];
			var displayUnitList = searchSubMap[? "displayUnitList"];
		}
		else{
			instance_destroy(obj_dropDown);
			exit;
		}
		
		
		var selectedTokenListSize = ds_list_size(selectedTokenList);
		
		repeat(selectedTokenListSize){
			var currentToken = selectedTokenList[|0];
			scr_deleteFromList(displayTokenList ,currentToken);
			scr_deleteFromList(selectedTokenList ,currentToken);
		}
		
		ds_list_clear(displayUnitList);
		
		var displayTokenListSize = ds_list_size(displayTokenList);
		var counter = 0;
		repeat(displayTokenListSize){
			var currentToken = displayTokenList[|counter];
			var tokenSubMap = global.nodeMap[?currentToken];
			var currentUnit = tokenSubMap[?"unit"];
			scr_addToListOnce(displayUnitList,currentUnit);
			counter ++;
		}
		
		//are there still units to show
		var displayUnitListSize = ds_list_size(displayUnitList);
		if(displayUnitListSize > 0){
			show_debug_message("displayUnitListSize:  "+ string(displayUnitListSize));
			scr_renderFilter2();
		}
		else{
			with(obj_dropDown){
				scr_removeSearch(obj_panelPane.functionSearchList_searchSelected)
				scr_disableFilter();
				instance_destroy();
			}
		}
	}
	else if(optionSelected == "Tag Token"){

		scr_destroyAllDropDownsOtherThanSelf();
		obj_control.multiWordTag = true;
		var dropDownOptionList = ds_list_create();
		ds_list_copy(dropDownOptionList, obj_control.tokenFieldList);
		ds_list_add(dropDownOptionList, "option_create-new-field");
		scr_createDropDown(x + windowWidth, y + (obj_dropDown.optionSpacing * optionIndex), dropDownOptionList, global.optionListTypeTokenFields);
	

	}
	

}