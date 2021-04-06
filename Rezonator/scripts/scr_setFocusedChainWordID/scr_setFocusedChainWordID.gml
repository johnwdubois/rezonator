// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_setFocusedChainWordID(){
	
	if (ds_map_exists(global.nodeMap, currentFocusedChainID) && currentFocusedChainID != "") {
		var chainMap = global.nodeMap[? currentFocusedChainID];
		if (scr_isNumericAndExists(chainMap, ds_type_map)) {
			
			// check to see if the tool corresponds to the focused chain
			var focusedChainType = chainMap[? "type"];
			focusedChainWrongTool = (focusedChainType == "rezChain" && obj_toolPane.currentMode != obj_toolPane.modeRez)
									or (focusedChainType == "trackChain" && obj_toolPane.currentMode != obj_toolPane.modeTrack);

			
			// set the focused chain's focused entry
			var focusedChainFocused = chainMap[? "focused"];
			var focusedEntrySubMap = global.nodeMap[? focusedChainFocused];
			if (scr_isNumericAndExists(focusedEntrySubMap, ds_type_map)) {			
				var focusedEntryKey = (focusedChainType == "stackChain") ? "unit" : "word";
				focusedChainWordID = focusedEntrySubMap[? focusedEntryKey];
			}
		}
	}
	else {
		focusedChainWrongTool = false;
	}

}