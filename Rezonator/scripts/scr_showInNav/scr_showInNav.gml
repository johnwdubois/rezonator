function scr_showInNav(nodeID) {
	
	obj_panelPane.showNav = true;
	obj_panelPane.showNavLeft = true;
	obj_panelPane.showNavRight = true;
	
	obj_control.showInNavID = nodeID;
	var nodeSubMap = global.nodeMap[?nodeID];
	var nodeType = nodeSubMap[? "type"];
	show_debug_message("scr_showInNav, nodeID: " + string(nodeID) + ", nodeType: " + string(nodeType));
	
	if (nodeType == "chunk") {
		obj_control.switchToTab = NAVTAB_CHUNK;
		//scroll to position after switching
		with (obj_alarm2) { alarm[0] = 3;}
		with (obj_panelPane) {
			functionChainList_chunkSelected = nodeID;
		}
	}
	else if (nodeType == "token") {
		
		var unitID = nodeSubMap[? "unit"];
		var docSubMap = global.nodeMap[? global.discourseNode];
		var unitList = docSubMap[? "unitList"];
		var unitIndex = ds_list_find_index(unitList, unitID);
		
		obj_control.switchToTab = NAVTAB_UNIT;
		obj_control.showInNavID = unitID;
		//scroll to position after switching
		with (obj_alarm2) { alarm[0] = 3;}
		with (obj_panelPane) {
		if (is_numeric(functionChainList_focusedUnitIndex)) functionChainList_focusedUnitIndex = unitIndex;
			functionChainList_focusedUnit = unitID;
		}
	}
	else if (nodeType == "unit") {
		
		var docSubMap = global.nodeMap[? global.discourseNode];
		var unitList = docSubMap[? "unitList"];
		var unitIndex = ds_list_find_index(unitList, nodeID);
		
		obj_control.switchToTab = NAVTAB_UNIT;
		//scroll to position after switching
		with (obj_alarm2) { alarm[0] = 3;}
		with (obj_panelPane) {
			if (is_numeric(functionChainList_focusedUnitIndex)) functionChainList_focusedUnitIndex = unitIndex;
			functionChainList_focusedUnit = nodeID;
		}
		show_debug_message("functionChainList_focusedUnitIndex: " + string(obj_panelPane.functionChainList_focusedUnitIndex));
	}

}