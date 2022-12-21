function scr_setChainName(str){
	
	show_debug_message("scr_setChainName, rightClickID: " + string(obj_control.rightClickID) + ", str: " + string(str));
	
	if (obj_control.rightClickID != "") {
		var rightClickSubMap = global.nodeMap[? obj_control.rightClickID];
		if(scr_isNumericAndExists(rightClickSubMap, ds_type_map)){

			var inChainsList = rightClickSubMap[? "inChainsList"];
			var inChainsListSize = ds_list_size(inChainsList);	
			for(var i = 0; i < inChainsListSize; i++){
				var currentChainID = inChainsList[| i];
				var chainSubMap = global.nodeMap[? currentChainID];						
				if(scr_isNumericAndExists(chainSubMap, ds_type_map)){
					var chainType = chainSubMap[? "type"];							
					if ((chainType == "trail" && obj_toolPane.currentMode == obj_toolPane.modeTrack or obj_toolPane.currentMode == obj_toolPane.modeRead)
					or (chainType == "resonance" && obj_toolPane.currentMode == obj_toolPane.modeRez or obj_toolPane.currentMode == obj_toolPane.modeRead)
					or ((chainType == "trail" || chainType == "resonance") && inChainsListSize == 1)
					or (chainType == "stack")) {
						chainSubMap[? "name"] = str;
					}
				}						
			}
		}
	}
}