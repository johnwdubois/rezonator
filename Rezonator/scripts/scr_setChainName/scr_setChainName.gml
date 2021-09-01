// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_setChainName(){
	if (obj_control.rightClickID != "") {
		var rightClickSubMap = global.nodeMap[? obj_control.rightClickID];
		if(scr_isNumericAndExists(rightClickSubMap, ds_type_map)){
			
			var type = rightClickSubMap[? "type"];
			show_debug_message(string(type));
			var stringToSet = "";
			if(type == "token"){
				var tokenTagMap = rightClickSubMap[? "tagMap"];
				stringToSet = tokenTagMap[? global.displayTokenField];
			}
			else if(type == "unit"){
				stringToSet = scr_getUnitText(rightClickSubMap);
			}
			else if(type == "chunk"){
				stringToSet = scr_getChunkText(obj_control.rightClickID);
			}
			show_debug_message(string(stringToSet));
			//set name of chain clicked on
			
			var inChainsList = rightClickSubMap[? "inChainsList"];
			var inChainsListSize = ds_list_size(inChainsList);
					
					
			for(var i = 0; i < inChainsListSize; i++){
				var currentChainID = inChainsList[| i];
				var chainSubMap = global.nodeMap[? currentChainID];						
				if(scr_isNumericAndExists(chainSubMap, ds_type_map)){
					var chainType = chainSubMap[? "type"];							
					if((chainType == "trail" && obj_toolPane.currentMode == obj_toolPane.modeTrack or obj_toolPane.currentMode == obj_toolPane.modeRead)
					or (chainType == "resonance" && obj_toolPane.currentMode == obj_toolPane.modeRez or obj_toolPane.currentMode == obj_toolPane.modeRead)
					or (chainType == "stack")){
						
						chainSubMap[? "name"] = stringToSet;
						
									
					}
				}						
			}
			
		}
	}
}