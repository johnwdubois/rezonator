function scr_focusRelevantChainOnToken(tokenID, chainType){
	
	show_debug_message("scr_focusRelevantChainOnToken, tokenID: " + string(tokenID) + ", chainType: " + string(chainType));
	// find the correct chain and focus it
	var tokenSubMap = global.nodeMap[? obj_control.rightClickID];
	var tokenInChainsList = tokenSubMap[? "inChainsList"];
	var tokenInChainsListSize = ds_list_size(tokenInChainsList);
	for(var i = 0; i < ds_list_size(tokenInChainsList); i++){
		var currentChainID = tokenInChainsList[| i];
		var currentChainSubMap = global.nodeMap[? currentChainID];
		if (scr_isNumericAndExists(currentChainSubMap, ds_type_map)) {
			var currentChainType = currentChainSubMap[? "type"];
			// check if this if the chaintype we are looking for, and if it is, then focus this chain
			if (currentChainType == chainType) {
				if (currentChainType == "trail") {
					obj_chain.currentFocusedChainID = currentChainID;
					with (obj_toolPane) {
						currentTool = toolTrackBrush;
						currentMode = modeTrack;
					}
				}
				else if (currentChainType == "resonance") {
					obj_chain.currentFocusedChainID = currentChainID;
					with (obj_toolPane) {
						currentTool = toolRezBrush;
						currentMode = modeRez;
					}
				}
			}
		}
	}

}