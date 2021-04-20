function scr_chainRecolorOptions(optionSelected) {

	with (obj_panelPane) {
		if (currentFunction == functionChainList) {
			
			obj_control.selectedChainID = obj_chain.currentFocusedChainID;
			var listOfWordID = ds_list_create();
			
			var chainType = "";
			var chainSubMap = ds_map_find_value(global.nodeMap, obj_control.selectedChainID);
			if (is_numeric(chainSubMap)) {
				if (ds_exists(chainSubMap, ds_type_map)) {
					chainType = ds_map_find_value(chainSubMap, "type");
					var setIDList = ds_map_find_value(chainSubMap, "setIDList");
					var setIDListSize = ds_list_size(setIDList);
					for (var i = 0; i < setIDListSize; i++) {
						var currentEntry = ds_list_find_value(setIDList, i);
						var currentEntrySubMap = ds_map_find_value(global.nodeMap, currentEntry);
						var currentWordID = ds_map_find_value(currentEntrySubMap, "token");
						ds_list_add(listOfWordID, currentWordID);
					}
				}
			}
			var listOfWordIDSize = ds_list_size(listOfWordID);
			
			
			
			if (optionSelected == "Red" || optionSelected == "Blue" || optionSelected == "Green" || optionSelected == "Gold") {
				var colorToSet = 0;
				if (optionSelected == "Red") colorToSet = real(string_digits(255));
				else if (optionSelected == "Blue") colorToSet = real(string_digits(16711680));
				else if (optionSelected == "Green") colorToSet = real(string_digits(65280));
				else if (optionSelected == "Gold") colorToSet = real(string_digits(4235000));
				
				if (chainType == "rezChain" || chainType == "trackChain") {
					for (var i = 0; i < listOfWordIDSize; i++) {
						var currentWordID = ds_list_find_value(listOfWordID, i);
						ds_grid_set(obj_control.wordDrawGrid, obj_control.wordDrawGrid_colEffectColor, currentWordID - 1, colorToSet);
					}
				}
				
				ds_map_replace(chainSubMap, "chainColor", colorToSet);

			}
			else if (optionSelected == "Custom") {
				if (!obj_control.dialogueBoxActive) {
					keyboard_string = "";
					obj_control.recolor = true;
				}

				obj_control.dialogueBoxActive = true;

				if (!instance_exists(obj_dialogueBox)) {
					instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
				}
			}
			
			

			ds_list_destroy(listOfWordID);
		}
	}
}
