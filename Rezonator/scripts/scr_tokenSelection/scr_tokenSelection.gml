function scr_tokenSelection(optionSelected) {
	
	// check whether or not to update display token
	var updateDisplayToken = (ds_list_find_index(obj_control.navTokenFieldList, global.displayTokenField) == obj_panelPane.chosenCol);
	
	// change the field list
	var colListIndex = obj_panelPane.chosenCol; 
	ds_list_set(obj_control.navTokenFieldList, colListIndex, optionSelected);
	
	// update display token if need be
	if (updateDisplayToken) {
		global.displayTokenField = optionSelected
	}

}
