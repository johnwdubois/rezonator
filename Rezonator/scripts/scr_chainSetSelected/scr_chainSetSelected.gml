

function scr_chainSetSelected(chainID, selected){

	// get chain, make sure it exists
	var chainSubMap = global.nodeMap[? chainID];
	if (!scr_isNumericAndExists(chainSubMap, ds_type_map)) exit;
	
	// get selected list
	var selectedList = -1;
	var chainType = chainSubMap[? "type"];
	if (chainType == "resonance") selectedList = obj_control.selectedRezChainList;
	else if (chainType == "trail") selectedList = obj_control.selectedTrackChainList;
	else if (chainType == "stack") selectedList = obj_control.selectedStackChainList;
	if (!scr_isNumericAndExists(selectedList, ds_type_list)) exit;
	
	show_debug_message("scr_chainSetSelected, chainID: " + string(chainID) + ", selected: " + string(selected));
	chainSubMap[? "selected"] = selected;
	if (selected && ds_list_find_index(selectedList, chainID) == -1) {
		scr_addToListOnce(selectedList, chainID);
	}
	else if (!selected) {
		scr_deleteFromList(selectedList, chainID);
	}
	
}