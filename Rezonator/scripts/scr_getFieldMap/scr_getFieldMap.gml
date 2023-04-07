function scr_getFieldMap() {
	
	var map = global.nodeMap[? "tokenTagMap"];

	with (obj_panelPane) {
		if (currentFunction == functionChainList) {
			if (functionChainList_currentTab == NAVTAB_UNIT) {
				if (!chainViewOneToMany) {
					map = global.nodeMap[? "unitTagMap"];
				}
			}
			if (functionChainList_currentTab == NAVTAB_RESONANCE ||
			functionChainList_currentTab == NAVTAB_STACK ||
			functionChainList_currentTab == NAVTAB_TRACK) {
				if (chainViewOneToMany) {
					map = global.nodeMap[? "entryTagMap"];
				}
				else {
					map = global.nodeMap[? "chainTagMap"];
				}
			}
		}
	}

	
	return map;
}