function scr_getDropDownOptionStr(optionStr) {
	
	var fullOptionStr = optionStr;	
	
	// special cases
	if (optionListType == global.optionListTypeSearchChain) {
		//get name of chain instead
		if (optionStr != "Create New Chain") {
			var chainSubMap = global.nodeMap[?optionStr];
			var chainName = chainSubMap[? "name"];
			fullOptionStr = chainName;
		}
	}
	else if (optionListType == global.optionListTypeAddToShow) {
		//get name of chain instead
		var chainSubMap = global.nodeMap[?optionStr];
		var chainName = chainSubMap[? "name"];
		fullOptionStr = chainName;
	}
	else if (optionListType == global.optionListTypeTagSchema) {
		//get name of file instead
		if (optionStr != "Custom tag schema") {
			fullOptionStr = filename_name(optionStr);
		}
	}
	else if (optionListType == global.optionListTypeStacking) {
		// get name of stacking instead
		if (optionStr != "New stacking") {
			var stackingSubMap = global.stackingMap[? optionStr];
			if (scr_isNumericAndExists(stackingSubMap, ds_type_map)) {
				fullOptionStr = stackingSubMap[? "name"];
			}
		}
	}
	else if (optionListType == global.optionListTypeSelectShow) {
		// get name of stacking instead
		if (optionStr != "option_create-show") {
			var showSubMap = global.nodeMap[? optionStr];
			if (scr_isNumericAndExists(showSubMap, ds_type_map)) {
				fullOptionStr = showSubMap[? "name"];
			}
		}
	}
	
	
	// attempt to translate
	fullOptionStr = scr_get_translation(fullOptionStr);
	
	return fullOptionStr;

}