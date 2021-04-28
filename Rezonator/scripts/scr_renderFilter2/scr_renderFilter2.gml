// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_renderFilter2(){
	
	var list = scr_getFilterList();
	// determine if filter should be activated or disabled
	obj_control.filterGridActive = (obj_panelPane.functionChainList_currentTab == obj_panelPane.functionChainList_tabRezBrush && obj_control.filterActiveRez)
									|| (obj_panelPane.functionChainList_currentTab == obj_panelPane.functionChainList_tabTrackBrush && obj_control.filterActiveTrack)
									|| (obj_panelPane.functionChainList_currentTab == obj_panelPane.functionChainList_tabStackBrush && obj_control.filterActiveStack)
									|| (obj_panelPane.functionChainList_currentTab == obj_panelPane.functionChainList_tabShow && obj_control.filterActiveStack);
	
	show_debug_message("scr_renderFilter2!");
	
	var listSize = ds_list_size(list);
	
	var filterUnitList = obj_control.filterUnitList;
	ds_list_clear(filterUnitList);
	
	var discourseSubMap = global.nodeMap[? global.discourseNode];
	var unitList = discourseSubMap[? "unitList"];
	
	
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
			else if (currentNodeType == "rezChain" ||currentNodeType == "trackChain") {
				// if this node is a stackChain, we can loop through its entry list and add each unit
				var setIDList = currentNodeSubMap[? "setIDList"];
				if (scr_isNumericAndExists(setIDList, ds_type_list)) {
					var setIDListSize = ds_list_size(setIDList);
					for (var j = 0; j < setIDListSize; j++) {
						var currentEntry = setIDList[| j];
						var currentEntrySubMap = global.nodeMap[? currentEntry];
						if (scr_isNumericAndExists(currentEntrySubMap, ds_type_map)) {
							var currentTokenID = currentEntrySubMap[? "token"];
							if (scr_isChunk(currentTokenID)) currentTokenID = scr_getFirstWordOfChunk(currentTokenID);
							var tokenSubMap = global.nodeMap[?currentTokenID];
							var currentUnitID = tokenSubMap[?"unit"];
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
	
	scr_sortFilterList(filterUnitList);
	var filterUnitListSize = ds_list_size(filterUnitList);
	
	var firstUnit = filterUnitList[|0];
	var lastUnit = filterUnitList[|filterUnitListSize-1];
	
	var indexOfFirst = ds_list_find_index(unitList,firstUnit);
	var indexOfLast = ds_list_find_index(unitList,lastUnit);
	
	//context above
	if (obj_panelPane.functionFilter_peek[0]) {
		
		for(var i = 0; i < indexOfFirst; i++){
			var currentUnitID = unitList[|i];
			if(ds_list_find_index(filterUnitList, currentUnitID) == -1){
				ds_list_add(filterUnitList, currentUnitID);
			}
		}
		
		
	}
	//context between
	if (obj_panelPane.functionFilter_peek[1]) {
		
		for(var i = indexOfFirst; i < indexOfLast; i++){
			var currentUnitID = unitList[|i];
			if(ds_list_find_index(filterUnitList, currentUnitID) == -1){
				ds_list_add(filterUnitList, currentUnitID);
			}
		}
	}
	//context below
	if (obj_panelPane.functionFilter_peek[2]) {
		var sizeOfUnitList = ds_list_size(unitList);
		for(var i = indexOfLast; i < sizeOfUnitList; i++){
			var currentUnitID = unitList[|i];
			if(ds_list_find_index(filterUnitList, currentUnitID) == -1){
				ds_list_add(filterUnitList, currentUnitID);
			}
		}
	}
	
	scr_sortFilterList(filterUnitList);
	
	// set the displayUnitList to be the filterUnitList
	discourseSubMap[? "displayUnitList"] = filterUnitList;

}