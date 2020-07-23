var optionSelected = argument[0];
var colValToSet = ds_list_find_index(global.unitImportColNameList, optionSelected);
var colListIndex = obj_panelPane.chosenCol-1; 

ds_list_set(obj_control.currentDisplayUnitColsList, colListIndex, colValToSet);

if (obj_control.unitView == obj_panelPane.chosenCol) {
	scr_toggleUnitMulti(global.unitImportGrid, colValToSet);
}