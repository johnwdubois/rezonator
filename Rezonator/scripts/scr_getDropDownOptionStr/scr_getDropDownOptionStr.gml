function scr_getDropDownOptionStr(optionStr){
	
	var fullOptionStr = optionStr;
	
	
	// special cases
	if(optionListType == global.optionListTypeSearchChain){
		//get name of chain instead
		if(optionStr != "Create New Chain"){
			var chainSubMap = global.nodeMap[?optionStr];
			var chainName = chainSubMap[?"name"];
			fullOptionStr = chainName;
		}
	}
	else if(optionListType == global.optionListTypeTagSchema){
		//get name of file instead
		if(optionStr != "Custom tag schema"){
			fullOptionStr = filename_name(optionStr);
		}
	}
	
	
	// attempt to translate
	fullOptionStr = scr_get_translation(fullOptionStr);
	
	return fullOptionStr;

}