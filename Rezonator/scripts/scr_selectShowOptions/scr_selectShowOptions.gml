// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_selectShowOptions(optionSelected){
	
	// if the user chose to create a new show
	var newShow = "";
	if (optionSelected == "option_create-show") {
		scr_createShow();
		var showList = global.nodeMap[? "showList"];
		newShow = showList[| ds_list_size(showList) - 1];	
	}

	// get show's set list, make sure it exists
	var showID = "";
	if (newShow != "") showID = newShow;
	else showID = optionSelected;
	show_debug_message("scr_selectShowOptions, showID: " + string(showID));
	
	var showSubMap = global.nodeMap[? showID];
	if (!scr_isNumericAndExists(showSubMap, ds_type_map)) {
		show_debug_message("scr_selectShowOptions, show does not exist");
		exit;
	}
	var setIDList = showSubMap[? "setIDList"];
	if (!scr_isNumericAndExists(setIDList, ds_type_list)) {
		show_debug_message("scr_selectShowOptions, setIDList does not exist");
		exit;
	}
	
	// add selected stack(s) to show
	var selectedStackList = obj_control.selectedStackChainList;
	var selectedStackListSize = ds_list_size(selectedStackList);
	if (selectedStackListSize > 1) {
		// if multiple stacks are selected with checkboxes, we'll add all of those to the show
		for (var i = selectedStackListSize - 1; i >= 0; i--) {
			var currentStack = selectedStackList[| i];
			scr_insertToListOnce(setIDList, 0, currentStack);
		}
	}
	else {
		// if we are only adding 1 stack to the show, let's make sure it's a real stack first
		var currentFocusedChainSubMap = global.nodeMap[? obj_chain.currentFocusedChainID];
		if (scr_isNumericAndExists(currentFocusedChainSubMap, ds_type_map)) {
			if (currentFocusedChainSubMap[? "type"] == "stack") {
				scr_addToListOnce(setIDList, obj_chain.currentFocusedChainID);
			}
		}
	}

}