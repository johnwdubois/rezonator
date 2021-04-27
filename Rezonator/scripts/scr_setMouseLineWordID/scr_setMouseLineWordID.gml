// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_setMouseLineWordID(){
	
	// set which word the mouse line (pickwhip) should be coming out of
	// we do this by checking the focused chain's focused entry
	mouseLineWordID = "";
	if (ds_map_exists(global.nodeMap, currentFocusedChainID)) {
		var chainSubMap = global.nodeMap[? currentFocusedChainID];
		if (ds_exists(chainSubMap, ds_type_map)) {
			var chainType = chainSubMap[? "type"];
			if (chainType == "rezChain" || chainType == "trackChain") {
				var focusedEntry = chainSubMap[? "focused"];
				var focusedEntrySubMap = global.nodeMap[? focusedEntry];
				if (scr_isNumericAndExists(focusedEntrySubMap, ds_type_map)) {
					var focusedEntryTokenID = focusedEntrySubMap[? "token"];
					if(scr_isChunk(focusedEntryTokenID)){
						focusedEntryTokenID = scr_getFirstWordOfChunk(focusedEntryTokenID);
					}
					mouseLineWordID = focusedEntryTokenID;
					var tokenSubMap = global.nodeMap[? focusedEntryTokenID];
					if (scr_isNumericAndExists(tokenSubMap, ds_type_map)) {
						tokenSubMap[?"border"] = (chainType == "rezChain")? "rez":"track";
					}
				}
			}
		}
	}

}