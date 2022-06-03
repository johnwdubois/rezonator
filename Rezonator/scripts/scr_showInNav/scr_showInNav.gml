function scr_showInNav(nodeID){
	obj_control.showInNavID = nodeID;
	var nodeSubMap = global.nodeMap[?nodeID];
	var nodeType = nodeSubMap[? "type"];
	
	if(nodeType == "chunk"){
		obj_control.switchToTab = obj_panelPane.functionChainList_tabChunk;
		//scroll to position after switching
		with(obj_alarm2){ alarm[0] = 3;}
		with(obj_panelPane){
			functionChainList_chunkSelected = nodeID;
		}
	}
	else if(nodeType == "token"){
		
		var unitID = nodeSubMap[? "unit"];
		obj_control.switchToTab = obj_panelPane.functionChainList_tabLine;
		//scroll to position after switching
		with(obj_alarm2){ alarm[0] = 3;}
		with(obj_panelPane){
			functionChainList_focusedUnit = unitID;
		}
	}
	else if(nodeType == "unit"){
		
		var docSubMap = global.nodeMap[? global.discourseNode];
		var unitList = docSubMap[? "unitList"];
		var unitIndex = ds_list_find_index(unitList, nodeID);
		
		obj_control.switchToTab = obj_panelPane.functionChainList_tabLine;
		//scroll to position after switching
		with(obj_alarm2){ alarm[0] = 3;}
		with(obj_panelPane){
			if (is_numeric(functionChainList_focusedUnitIndex)) functionChainList_focusedUnitIndex = unitIndex;
			functionChainList_focusedUnit = nodeID;
		}
		show_debug_message("functionChainList_focusedUnitIndex: " + string(obj_panelPane.functionChainList_focusedUnitIndex));
	}

}