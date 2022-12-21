

function scr_getFirstUnitOfChain(chainID){
	
	var chainSubMap = global.nodeMap[? chainID];
	if (scr_isNumericAndExists(chainSubMap, ds_type_map)) {

		
		
		var focusedEntry = chainSubMap[? "focused"];
		var focusedEntrySubMap = global.nodeMap[? focusedEntry];
		if (scr_isNumericAndExists(focusedEntrySubMap, ds_type_map)) {
			var focusedEntryType = focusedEntrySubMap[? "type"]
			
			if (focusedEntryType == "card") {
				return focusedEntrySubMap[? "unit"]
			}
			else if (focusedEntryType == "rez" || focusedEntryType == "track") {
				var focusedEntryToken = focusedEntrySubMap[? "token"];
				var focusedEntryTokenSubMap = global.nodeMap[? focusedEntryToken];
				if (scr_isNumericAndExists(focusedEntryTokenSubMap, ds_type_map)) {
					return focusedEntryTokenSubMap[? "unit"];
				}
			}
			
		}
	}
	
	return "";
	
}