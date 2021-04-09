function scr_tokenSelection() {
	
	var optionSelected = argument[0];
	var colValToSet = ds_list_find_index(global.tokenImportColNameList, optionSelected);
	var colListIndex = obj_panelPane.chosenCol - 2; 

	
	show_debug_message("obj_panelPane.chosenCol: " + string(obj_panelPane.chosenCol) + ", colListIndex: " + string(colListIndex));

	ds_list_set(obj_control.currentDisplayTokenColsList, colListIndex, colValToSet);


	if (obj_control.wordView == obj_panelPane.chosenCol) {
		scr_toggleTranscriptionMulti(global.tokenImportGrid, colValToSet);
	}


}
