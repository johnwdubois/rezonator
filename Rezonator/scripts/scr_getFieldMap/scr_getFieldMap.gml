function scr_getFieldMap() {
	
	var map = global.nodeMap[? "tokenTagMap"];

	with (obj_panelPane) {
		if (currentFunction == functionChainList) {
			if (functionChainList_currentTab == functionChainList_tabLine) {
				if (!chainViewOneToMany) {
					map = global.nodeMap[? "unitTagMap"];
				}
			}
			if (functionChainList_currentTab == functionChainList_tabRezBrush ||
			functionChainList_currentTab == functionChainList_tabStackBrush ||
			functionChainList_currentTab == functionChainList_tabTrackBrush) {
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