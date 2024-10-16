

function scr_createNewSearch(searchTermList) {
	
	if (scr_isNumericAndExists(global.searchMap,ds_type_map)) {
	

		var searchTermListCopy = ds_list_create();
		if (ds_list_size(searchTermList) >= 2) {
			if (global.steamAPI) {
				if (!steam_get_achievement("SA_mw-search")) {
					steam_set_achievement("SA_mw-search");
				}
			}
		}
		
		ds_list_copy(searchTermListCopy, searchTermList);
	
		var searchLists = scr_getSearchLists(searchTermListCopy);

		var displayUnitList = searchLists[|0];
		var displayTokenList = searchLists[|1];
		
		
		var unitListSize = ds_list_size(displayUnitList);
		var counter = 0;
		show_debug_message("unitListSize:  " +string(unitListSize));
		repeat(unitListSize) {
			show_debug_message(string(counter) + ":  "+string(displayUnitList[|counter]));
			if (!is_string(displayUnitList[|counter])) {
				ds_list_delete(displayUnitList,counter);
			}
			else {
				counter++;
			}
		}
	
		if (scr_isNumericAndExists(displayTokenList, ds_type_list)) {

			if (ds_list_size(displayTokenList) > 0) {
				var selectedTokenList = ds_list_create();
				//global.displayTokenField = obj_control.searchField;
				// type variable should be a string that declares what "type" of Node this is
				// for example, "Chain", "Link", "Unit", etc.
				var searchNodeList = global.nodeMap[? "searchNodeList"];
				if (scr_isNumericAndExists(searchNodeList, ds_type_list)) {
					
					var nodeKey = scr_generateRandomID();

					var sizeOfSearchList = ds_list_size(searchNodeList) + 1;
	
					var searchName = "Search " + string(sizeOfSearchList);

					// to attach, for example the type
					var subMap = ds_map_create();
	
					// add type to subMap
					ds_map_add(subMap, "type", "search");
	
					// add name to subMap
					ds_map_add(subMap, "name", searchName);
	
					// add range settings to subMap
					show_debug_message("field:  "+ string(obj_control.searchField))
					ds_map_add(subMap, "field", obj_control.searchField);
					show_debug_message("range:  "+ string(scr_get_translation(obj_control.searchRange)))
					ds_map_add(subMap, "range", obj_control.searchRange);
					show_debug_message("regex:  "+ string(obj_control.regExCheck))
					ds_map_add(subMap, "regex", obj_control.regExCheck);
					show_debug_message("caseSensitive:  "+ string(obj_control.caseSensitive))
					ds_map_add(subMap, "caseSensitive", obj_control.caseSensitive);
					
					
	
					// add searchTermListCopy to subMap
					ds_map_add_list(subMap, "searchTermList", searchTermListCopy);
	
					// add displayUnitList to subMap
					ds_map_add_list(subMap, "displayUnitList", displayUnitList);
	
					// add displayTokenList to subMap
					ds_map_add_list(subMap, "displayTokenList", displayTokenList);
					
					// add selectedTokenList to subMap
					ds_map_add_list(subMap, "selectedTokenList", selectedTokenList);
	
					// add Node to NodeMap
					ds_map_add_map(global.searchMap, nodeKey, subMap);
	
					//add to searchNodeList 
					ds_list_add(searchNodeList, nodeKey);
	
					show_debug_message("searchTermList  " + scr_getStringOfList(subMap[? "searchTermList"]));
					with (obj_panelPane) {
						functionSearchList_searchSelected = nodeKey;
					}
				}
			}
			else {
				with (obj_dialogueBox) instance_destroy();
				with (obj_inputBox) instance_destroy();
				scr_closeDialogueBoxVariables();
				
				instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
				obj_dialogueBox.alertWindowActive = true;
				obj_dialogueBox.descriptionText = scr_get_translation("msg_no-results-found");
				obj_control.noResultsFound = true;
			}
		}
	}
}