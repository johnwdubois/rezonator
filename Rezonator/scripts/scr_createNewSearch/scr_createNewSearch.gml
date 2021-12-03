// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_createNewSearch(searchTermList){
	
	if(scr_isNumericAndExists(global.searchMap,ds_type_map)){
	

		var searchTermListCopy = ds_list_create();
		
		ds_list_copy(searchTermListCopy, searchTermList);
	
		var searchLists = scr_getSearchLists(searchTermListCopy);

		var displayUnitList = searchLists[|0];
		var displayTokenList = searchLists[|1];
	
		if(scr_isNumericAndExists(displayTokenList, ds_type_list)){

			if(ds_list_size(displayTokenList) > 0){
				var selectedTokenList = ds_list_create();
				//global.displayTokenField = obj_control.searchField;
				// type variable should be a string that declares what "type" of Node this is
				// for example, "Chain", "Link", "Unit", etc.
				var searchNodeList = global.nodeMap[?"searchNodeList"];
				if(scr_isNumericAndExists(searchNodeList, ds_type_list)){
					
					var nodeKey = scr_generateRandomHex();

					var sizeOfSearchList = ds_list_size(searchNodeList) + 1;
	
					var searchName = "Search " + string(sizeOfSearchList);

					// to attach, for example the type
					var subMap = ds_map_create();
	
					// add type to subMap
					ds_map_add(subMap, "type", "search");
	
					// add name to subMap
					ds_map_add(subMap, "name", searchName);
	
					// add range settings to subMap
					ds_map_add(subMap, "field", obj_control.searchField);
					ds_map_add(subMap, "range", obj_control.searchRange);
					ds_map_add(subMap, "regex", obj_control.regExCheck);
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
	
					show_debug_message("searchTermList  " + scr_getStringOfList(subMap[?"searchTermList"]));
					with(obj_panelPane){
						functionSearchList_searchSelected = nodeKey;
					}
				}
			}
			else{
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