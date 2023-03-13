function scr_cliqueStackerLoop() {
	
	// get clique list & map
	var cliqueMap = global.nodeMap[? "cliqueMap"];
	var cliqueList = obj_chain.cliqueList;
	if (!scr_isNumericAndExists(cliqueMap, ds_type_map)
	|| !scr_isNumericAndExists(cliqueList, ds_type_list)) {
		show_debug_message("scr_cliqueStackerLoop map or list does not exist");
		exit;
	}
	
	// set active stackType
	scr_changeActiveStackType("Clique");
	
	var cliqueListSize = ds_list_size(cliqueList);
	for (var i = 0; i < cliqueListSize; i++) {
		
		// deselect the stack
		obj_chain.currentFocusedChainID = "";
		
		// get current clique
		var currentClique = cliqueList[| i];
		var currentCliqueSubMap = global.cliqueMap[? currentClique];
		if (!scr_isNumericAndExists(currentCliqueSubMap, ds_type_map)) {
			continue;
		}
		
		// get clique's unit list
		var currentCliqueUnitList = currentCliqueSubMap[? "unitList"];
		if (!scr_isNumericAndExists(currentCliqueUnitList, ds_type_list)) continue;
		var currentCliqueUnitListSize = ds_list_size(currentCliqueUnitList);
		scr_chainDeselect();
		
		obj_toolPane.currentTool = obj_toolPane.toolStackBrush;
		
		// click on all the units in this clique to add them to the stack
		for (var j = 0; j < currentCliqueUnitListSize; j++) {
			var currentCliqeUnit = currentCliqueUnitList[| j];
			scr_unitClicked(currentCliqeUnit);
		}
	}
	
	if (global.steamAPI) {
		if (!steam_get_achievement("SA_clique")) {
			steam_set_achievement("SA_clique");
		}
	}

}