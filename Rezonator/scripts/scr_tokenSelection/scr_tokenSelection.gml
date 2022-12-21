function scr_tokenSelection(optionSelected) {
	
	var navFieldList = obj_control.navTokenFieldList;
	
	// check if the Unit tab or Chunk tab is selected
	with (obj_panelPane) {
		if (currentFunction == functionChainList && !obj_panelPane.chainViewOneToMany) {
			if (functionChainList_currentTab == functionChainList_tabChunk) {
				navFieldList = obj_control.navChunkFieldList;
			}
		}
	}
	
	// check whether or not to update display token
	var updateDisplayToken = (ds_list_find_index(navFieldList, global.displayTokenField) == obj_panelPane.chosenCol);
	
	// change the field list
	var colListIndex = obj_panelPane.chosenCol;
	var optionSelectedPrevIndex = ds_list_find_index(navFieldList, optionSelected);
	if(optionSelectedPrevIndex >= 0 && colListIndex != optionSelectedPrevIndex){
		scr_listSwap(navFieldList, colListIndex, optionSelectedPrevIndex);
	}
	else if (optionSelectedPrevIndex == -1) {
		ds_list_set(navFieldList, colListIndex, optionSelected);
	}
	
	// update display token if need be
	if (updateDisplayToken && navFieldList == obj_control.navTokenFieldList) {
		global.displayTokenField = optionSelected;
		scr_updateDisplayTokenList(global.displayTokenField);
	}

}
