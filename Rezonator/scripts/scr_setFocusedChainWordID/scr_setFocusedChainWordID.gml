function scr_setFocusedChainWordID() {
	
	if (ds_map_exists(global.nodeMap, currentFocusedChainID) && currentFocusedChainID != "") {
		var chainMap = global.nodeMap[? currentFocusedChainID];
		if (scr_isNumericAndExists(chainMap, ds_type_map)) {
			
			// check to see if the tool corresponds to the focused chain
			var focusedChainType = chainMap[? "type"];
			focusedChainWrongTool = ((focusedChainType == "resonance" && obj_toolPane.currentMode != obj_toolPane.modeRez)
									or (focusedChainType == "trail" && obj_toolPane.currentMode != obj_toolPane.modeTrack)) 
									and obj_toolPane.currentMode != obj_toolPane.modeRead;

			
			// set the focused chain's focused entry
			var focusedChainFocused = chainMap[? "focused"];
			var focusedEntrySubMap = global.nodeMap[? focusedChainFocused];
			if (scr_isNumericAndExists(focusedEntrySubMap, ds_type_map)) {			
				var focusedEntryKey = (focusedChainType == "stack") ? "unit" : "token";
				focusedChainWordID = focusedEntrySubMap[? focusedEntryKey];
			}
			
			// set the most recently focused rez/trail/stack
			var chainType = chainMap[? "type"];
			if (chainType == "resonance") resonancePrevFocused = currentFocusedChainID;
			else if (chainType == "trail") trailPrevFocused = currentFocusedChainID;
			else if (chainType == "stack") stackPrevFocused = currentFocusedChainID;
		}
	}
	else {
		focusedChainWrongTool = false;
	}

}