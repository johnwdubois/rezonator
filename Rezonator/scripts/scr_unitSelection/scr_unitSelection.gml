function scr_unitSelection(optionSelected) {
	
	// check whether or not to update display token
	var updateDisplayUnit = (ds_list_find_index(obj_control.navUnitFieldList, global.participantField) == obj_panelPane.chosenCol);
	
	// change the field list
	var colListIndex = obj_panelPane.chosenCol;
	var optionSelectedPrevIndex = ds_list_find_index(obj_control.navUnitFieldList, optionSelected);
	if(optionSelectedPrevIndex >= 0 && colListIndex != optionSelectedPrevIndex){
		scr_listSwap(obj_control.navUnitFieldList, colListIndex, optionSelectedPrevIndex);
	}
	
	// update display token if need be
	if (updateDisplayUnit) {
		global.participantField = optionSelected
	}

}
