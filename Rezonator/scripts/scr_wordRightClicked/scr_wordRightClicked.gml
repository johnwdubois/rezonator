// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_wordRightClicked(){
	
	if (instance_exists(obj_control) and !instance_exists(obj_dialogueBox) and !instance_exists(obj_stackShow)) {
	
		var currentRightClickWordState = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colWordState, obj_control.rightClickWordID - 1);
		obj_control.rightClickonWord = true;
		obj_control.wideDropDown = true;
		var dropDownOptionList = ds_list_create();
			
		// check if this is the first word in its line
		var lineGridRow = obj_control.rightClickDisplayRow;
		var lineGridWordIDList = ds_grid_get(obj_control.lineGrid, obj_control.lineGrid_colWordIDList, lineGridRow);
		var WordsInChainsList = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colInChainList, obj_control.rightClickWordID -1);
		var firstWordInLine = true;
		if (is_numeric(lineGridWordIDList)) {
			firstWordInLine = (obj_control.rightClickWordID == ds_list_find_value(lineGridWordIDList, 0));
		}
				
		// No dropdown if in Read Mode
		if (obj_toolPane.currentMode == obj_toolPane.modeRead) {
			obj_control.ableToCreateDropDown = false;
		}
		// Options for a word in a Chain
		else if(ds_list_size(WordsInChainsList) > 0){
			if(obj_control.searchGridActive){
				ds_list_add(dropDownOptionList, "Delete Link");
			}
			else{
				ds_list_add(dropDownOptionList, "Split Word", "New Word", "Delete Link");
				if (!firstWordInLine && obj_control.showDevVars) {
					ds_list_add(dropDownOptionList, "Split Line");
				}
			}
			if(currentRightClickWordState == obj_control.wordStateNew) {
				ds_list_add(dropDownOptionList, "Delete New Word");
			}
			else{
				ds_list_add(dropDownOptionList, "Replace Word", "Restore Word");
			}
					
		}
		// Options for a chainless word
		else{
			if(obj_control.searchGridActive){
				obj_control.ableToCreateDropDown = false;
			}
			else{
				ds_list_add(dropDownOptionList, "Split Word", "New Word");
				if (!firstWordInLine && obj_control.showDevVars) {
					ds_list_add(dropDownOptionList, "Split Line");
				}
			}
			if(currentRightClickWordState == obj_control.wordStateNew) {
				ds_list_add(dropDownOptionList, "Delete New Word");
			}
			else{
				ds_list_add(dropDownOptionList, "Replace Word", "Restore Word");
			}
		}
				
		// Create the dropdown
		if (ds_list_size(dropDownOptionList) > 0 and obj_control.ableToCreateDropDown) {
			scr_createDropDown(mouse_x, mouse_y, dropDownOptionList, global.optionListTypeRightClickWord);
		}
	}
}