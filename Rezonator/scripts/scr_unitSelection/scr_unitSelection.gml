function scr_unitSelection(optionSelected) {
	
	var navFieldList = obj_control.navUnitFieldList;
	
	// check whether or not to update display token
	var updateDisplayUnit = (ds_list_find_index(obj_control.navUnitFieldList, global.participantField) == obj_panelPane.chosenCol);
	
	// change the field list
	var colListIndex = obj_panelPane.chosenCol;
	var optionSelectedPrevIndex = ds_list_find_index(obj_control.navUnitFieldList, optionSelected);
	if(optionSelectedPrevIndex >= 0 && colListIndex != optionSelectedPrevIndex){
		scr_listSwap(navFieldList, colListIndex, optionSelectedPrevIndex);
	}
	else if (optionSelectedPrevIndex == -1) {
		ds_list_set(navFieldList, colListIndex, optionSelected);
	}
	
	// update display token if need be
	if (updateDisplayUnit) {
		global.participantField = optionSelected
	}

}
