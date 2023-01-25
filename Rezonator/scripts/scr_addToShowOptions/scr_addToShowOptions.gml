

function scr_addToShowOptions(optionSelected) {
	
	// add the selected chain to the show's setList
	var showID = obj_panelPane.functionChainContents_showID;
	var showSubMap = ds_map_find_value(global.nodeMap, showID);
	
	if (is_numeric(showSubMap)) {
		if (ds_exists(showSubMap, ds_type_map)) {
			
			// get setList from show & make sure it exists
			var setList = ds_map_find_value(showSubMap, "setIDList");
			if (is_numeric(setList)) {
				if (ds_exists(setList, ds_type_list)) {
					if (ds_list_find_index(setList,optionSelected) == -1) {
						ds_list_add(setList, optionSelected);
						with (obj_panelPane) {
							errorText = ""
						}
					}
					else {
						with (obj_panelPane) {
							errorText = "Stack already in Show"
							alarm[8] = 240;
						}
					}
				}
			}
		}
	}
	
}