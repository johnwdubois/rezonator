var optionSelected = argument[0];
var colValToSet = ds_list_find_index(global.tokenImportColNameList, optionSelected);
if (obj_panelPane.chosenCol == 2){
	var colListIndex = obj_panelPane.chosenCol - 2; 
}
else{
	var colListIndex = obj_panelPane.chosenCol - 3; 
}

ds_list_set(obj_control.currentDisplayTokenColsList, colListIndex, colValToSet);




if (obj_control.wordView == obj_panelPane.chosenCol) {
	scr_toggleTranscriptionMulti(global.tokenImportGrid, colValToSet);
}