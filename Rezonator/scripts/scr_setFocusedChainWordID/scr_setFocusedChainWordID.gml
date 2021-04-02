// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_setFocusedChainWordID(){

	if (ds_map_exists(global.nodeMap, currentFocusedChainID)) {
		var chainMap = global.nodeMap[? currentFocusedChainID];
		var focusedChainType = chainMap[? "type"];
		var focusedChainFocused = chainMap[? "focused"];
		var focusedEntrySubMap = global.nodeMap[? focusedChainFocused];

		if (is_numeric(focusedEntrySubMap)) {			
			if (ds_exists(focusedEntrySubMap, ds_type_map)) {
				var focusedEntryKey = (focusedChainType == "stackChain") ? "unit" : "word";
				focusedChainWordID = focusedEntrySubMap[? focusedEntryKey];
			}
		}
	}

}