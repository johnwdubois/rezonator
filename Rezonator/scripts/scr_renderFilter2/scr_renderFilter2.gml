// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_renderFilter2(list){
	
	show_debug_message("scr_renderFilter2!");
	
	var listSize = ds_list_size(list);
	
	var filterUnitList = obj_control.filterUnitList;
	ds_list_clear(filterUnitList);
	
	
	// loop through list and check which one have filter set to true
	// and then add those units to the filterList
	for (var i = 0; i < listSize; i++) {
		
		// get current unit and its submap
		var currentNodeID = list[| i];
		var currentNodeSubMap = global.nodeMap[? currentNodeID];
		if (!scr_isNumericAndExists(currentNodeSubMap, ds_type_map)) continue;
		var currentNodeType = currentNodeSubMap[? "type"];
		
		
		// check if this node should be filtered, and make sure its not in the filterUnitList already
		if (currentNodeSubMap[? "filter"]) {
			
			if (currentNodeType == "unit") {
				// if this node is just a regular old unit, we can add the node directly to the filter list
				if (ds_list_find_index(filterUnitList, currentNodeID) == -1) {
					show_debug_message("scr_renderFilter2() ... adding unit " + string(currentNodeID));
					ds_list_add(filterUnitList, currentNodeID);
				}
			}
			else if (currentNodeType == "stackChain") {
				// if this node is a stackChain, we can loop through its entry list and add each unit
				var setIDList = currentNodeSubMap[? "setIDList"];
				if (scr_isNumericAndExists(setIDList, ds_type_list)) {
					var setIDListSize = ds_list_size(setIDList);
					for (var j = 0; j < setIDListSize; j++) {
						var currentEntry = setIDList[| j];
						var currentEntrySubMap = global.nodeMap[? currentEntry];
						if (scr_isNumericAndExists(currentEntrySubMap, ds_type_map)) {
							var currentUnitID = currentEntrySubMap[? "unit"];
							if (ds_list_find_index(filterUnitList, currentUnitID) == -1 && is_string(currentUnitID)) {
								show_debug_message("scr_renderFilter2() ... adding unit " + string(currentUnitID));
								ds_list_add(filterUnitList, currentUnitID);
							}
						}
					}
				}
			}
		}
	}
	
	
	
	// sort filterUnitList based on discourse time
	var filterUnitListSize = ds_list_size(filterUnitList);
	var sortFilterTempGrid = ds_grid_create(2, filterUnitListSize);
	var sortFilterTempGrid_colUnitID = 0;
	var sortFilterTempGrid_colUnitSeq = 1;
	for (var i = 0; i < filterUnitListSize; i++) {
		var currentUnitID = filterUnitList[| i];
		var currentUnitSubMap = global.nodeMap[? currentUnitID];
		var currentUnitSeq = currentUnitSubMap[? "unitSeq"];
		ds_grid_set(sortFilterTempGrid, sortFilterTempGrid_colUnitID, i, currentUnitID);
		ds_grid_set(sortFilterTempGrid, sortFilterTempGrid_colUnitSeq, i, currentUnitSeq);
	}
	ds_grid_sort(sortFilterTempGrid, sortFilterTempGrid_colUnitSeq, true);
	ds_list_clear(filterUnitList);
	for (var i = 0; i < filterUnitListSize; i++) {
		var currentUnitID = ds_grid_get(sortFilterTempGrid, sortFilterTempGrid_colUnitID, i);
		ds_list_add(filterUnitList, currentUnitID);
	}
	
	// set the displayUnitList to be the filterUnitList
	var discourseSubMap = global.nodeMap[? global.discourseNode];
	discourseSubMap[? "displayUnitList"] = filterUnitList;

}