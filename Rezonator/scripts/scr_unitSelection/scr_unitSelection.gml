function scr_unitSelection(optionSelected) {
	
	// check whether or not to update display token
	var updateDisplayUnit = (ds_list_find_index(obj_control.navUnitFieldList, global.speakerField) == obj_panelPane.chosenCol);
	
	// change the field list
	var colListIndex = obj_panelPane.chosenCol; 
	ds_list_set(obj_control.navUnitFieldList, colListIndex, optionSelected);
	
	// update display token if need be
	if (updateDisplayUnit) {
		global.speakerField = optionSelected
	}

}
