function scr_hideOptions(optionSelected) {
	
	var chainType = "";
	if (optionSelected == "menu_track") chainType = "trail";
	if (optionSelected == "menu_resonance") chainType = "resonance";
	if (optionSelected == "menu_stack") chainType = "stack";
	
	var listOfChains = -1;
	var listOfHiddenChains = -1;
	if (chainType == "resonance") {
		listOfChains = global.nodeMap[? "resonanceList"];
		listOfHiddenChains = obj_control.hiddenRezChainList;
	}
	else if (chainType == "trail") {
		listOfChains = global.nodeMap[? "trailList"];
		listOfHiddenChains = obj_control.hiddenTrackChainList;
	}
	else if (chainType == "stack") {
		listOfChains = global.nodeMap[? "stackList"];
		listOfHiddenChains = obj_control.hiddenStackChainList;
	}
	
	
	if (scr_isNumericAndExists(listOfChains, ds_type_list) && scr_isNumericAndExists(listOfHiddenChains, ds_type_list)) {
		var allChainsHidden = (ds_list_size(listOfChains) == ds_list_size(listOfHiddenChains) && ds_list_size(listOfChains) > 0);
		scr_setValueForAllChains(chainType, false, "visible", allChainsHidden);
	}
	



}
