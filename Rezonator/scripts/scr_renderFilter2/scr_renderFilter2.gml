// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_renderFilter2(){
	
	var list = scr_getFilterList();
	
	// if we're doing a quickpick, just make a list that contains only the quickpicked chain
	var quickpick = obj_control.quickPickedChainID != "" && ds_map_exists(global.nodeMap, obj_control.quickPickedChainID);
	if (quickpick) {
		obj_control.quickFilterGridActive = true;
		list = ds_list_create();
		ds_list_add(list, obj_control.quickPickedChainID);
	}
	
	
	
	var search = obj_control.searchGridActive;
	if (search) {
		var searchSubMap = global.searchMap[?obj_panelPane.functionSearchList_searchSelected];
		if(!scr_isNumericAndExists(searchSubMap,ds_type_map)){exit;}
		var displayUnitList = searchSubMap[?"displayUnitList"];
		show_debug_message("scr_renderFilter2 search: " + string(obj_panelPane.functionSearchList_searchSelected));
		list = displayUnitList;
		show_debug_message("scr_renderFilter2 search, list: " + scr_getStringOfList(list));
	}
	

	
	
	
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
	
	
	// if search returned no results, then exit the filter
	if (ds_list_size(list) < 1) {
		scr_disableFilter();
		exit;
	}
	
	// set all units to be unactive
	scr_setValueForAllNodesInList(unitList, "active", false);
	
	
	// loop through list and check which one have filter set to true
	// and then add those units to the filterList
	for (var i = 0; i < listSize; i++) {
		
		// get current unit and its submap
		var currentNodeID = list[| i];
		var currentNodeSubMap = global.nodeMap[? currentNodeID];
		if (!scr_isNumericAndExists(currentNodeSubMap, ds_type_map)) continue;
		var currentNodeType = currentNodeSubMap[? "type"];
		
	
		if (currentNodeType == "unit") {
			// if this node is just a regular old unit, we can add the node directly to the filter list
			scr_addToListOnce(filterUnitList, currentNodeID);
			currentNodeSubMap[? "active"] = true;
		}
		else if (currentNodeType == "stack") {
			// if this node is a stackChain, we can loop through its entry list and add each unit
			var setIDList = currentNodeSubMap[? "setIDList"];
			if (scr_isNumericAndExists(setIDList, ds_type_list)) {
				var setIDListSize = ds_list_size(setIDList);
				for (var j = 0; j < setIDListSize; j++) {
					var currentEntry = setIDList[| j];
					var currentEntrySubMap = global.nodeMap[? currentEntry];
					if (scr_isNumericAndExists(currentEntrySubMap, ds_type_map)) {
						var currentUnitID = currentEntrySubMap[? "unit"];
						var currentUnitSubMap = global.nodeMap[? currentUnitID];
						if (scr_isNumericAndExists(currentUnitSubMap, ds_type_map)) {
							scr_addToListOnce(filterUnitList, currentUnitID);
							currentUnitSubMap[? "active"] = true;
						}
					}
				}
			}
		}
		else if (currentNodeType == "resonance" ||currentNodeType == "trail") {
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
						var tokenSubMap = global.nodeMap[? currentTokenID];
						if (scr_isNumericAndExists(tokenSubMap, ds_type_map)){
							var currentUnitID = tokenSubMap[? "unit"];
							var currentUnitSubMap = global.nodeMap[? currentUnitID];	
							if (scr_isNumericAndExists(currentUnitSubMap, ds_type_map)) {
								scr_addToListOnce(filterUnitList, currentUnitID);
								currentUnitSubMap[? "active"] = true;
							}
						}
					}
				}
			}
		}
		
		
		
	}
	
	scr_sortFilterList(filterUnitList);
	var filterUnitListSize = ds_list_size(filterUnitList);
	
	// get the first & last unit in the filter list so far, and find where they are in the full unit list
	var firstUnit = filterUnitList[| 0];
	var lastUnit = filterUnitList[| filterUnitListSize - 1];
	var indexOfFirst = ds_list_find_index(unitList, firstUnit);
	var indexOfLast = ds_list_find_index(unitList, lastUnit);
	
	//context above
	if (obj_panelPane.functionFilter_peek[0]) {
		for(var i = 0; i < indexOfFirst; i++){
			var currentUnitID = unitList[|i];
			var currentUnitSubMap = global.nodeMap[? currentUnitID];
			currentUnitSubMap[? "active"] = true;
			scr_addToListOnce(filterUnitList, currentUnitID);
		}
	}
	//context between
	if (obj_panelPane.functionFilter_peek[1]) {
		for(var i = indexOfFirst; i < indexOfLast; i++){
			var currentUnitID = unitList[|i];
			var currentUnitSubMap = global.nodeMap[? currentUnitID];
			currentUnitSubMap[? "active"] = true;
			scr_addToListOnce(filterUnitList, currentUnitID);
		}
	}
	//context below
	if (obj_panelPane.functionFilter_peek[2]) {
		var sizeOfUnitList = ds_list_size(unitList);
		for(var i = indexOfLast; i < sizeOfUnitList; i++){
			var currentUnitID = unitList[|i];
			var currentUnitSubMap = global.nodeMap[? currentUnitID];
			currentUnitSubMap[? "active"] = true;
			scr_addToListOnce(filterUnitList, currentUnitID);
		}
	}
	
	scr_sortFilterList(filterUnitList);
	
	// set the displayUnitList to be the filterUnitList
	ds_map_delete(discourseSubMap, "displayUnitList");
	ds_map_add_list(discourseSubMap, "displayUnitList", filterUnitList);
	
	var displayUnitList = discourseSubMap[? "displayUnitList"];
	var drawRangeUnit = displayUnitList[|0];
	var drawRangeUnitSubMap = global.nodeMap[?drawRangeUnit];
	var drawRangeUnitSeq = drawRangeUnitSubMap[?"unitSeq"];
	
	var unitListSize = ds_list_size(unitList);
	for(var i = 0; i < unitListSize; i ++){
		
		var currentUnit = unitList[|i];
		var currentUnitSubMap = global.nodeMap[?currentUnit];
		var unitSeq = currentUnitSubMap[?"unitSeq"];	

		if(unitSeq < drawRangeUnitSeq){
			currentUnitSubMap[? "pixelY"] = -9999;
		}
		else{
			currentUnitSubMap[? "pixelY"] = 9999;
		}	
		
	}
	
	if (quickpick) {
		ds_list_destroy(list);
	}
	
	// if there is a focused chain, let's jump back to the first thing in that chain
	if (obj_chain.currentFocusedChainID != "") scr_jumpToUnit(scr_getFirstUnitOfChain(obj_chain.currentFocusedChainID));

}