function scr_setChainNameGetString(){
	
	var stringToSet = "";
	if (obj_control.rightClickID != "" && is_string(obj_control.rightClickID)) {
		var rightClickSubMap = global.nodeMap[? obj_control.rightClickID];
		if (scr_isNumericAndExists(rightClickSubMap, ds_type_map)) {
			
			var type = rightClickSubMap[? "type"];
			if (type == "token") {
				var tokenTagMap = rightClickSubMap[? "tagMap"];
				stringToSet = tokenTagMap[? global.displayTokenField];
			}
			else if (type == "unit") {
				stringToSet = scr_getUnitText(rightClickSubMap);
			}
			else if (type == "chunk") {
				stringToSet = scr_getChunkText(obj_control.rightClickID);
			}
		}
	}
	show_debug_message("scr_setChainNameGetString, stringToSet: " + string(stringToSet));
	return stringToSet;

}