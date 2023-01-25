function scr_disableFilter() {

	with (obj_control) {		
		quickPickedChainID = "";
		currentView = mainView;
		wordLeftMarginDest = 170; // Make sure the margin is placed correctly
	}
	

	// set the displayUnitList to be the filterUnitList
	var discourseSubMap = global.nodeMap[? global.discourseNode];
	var displayUnitList = discourseSubMap[? "displayUnitList"];
	var drawRangeUnit = "";
	
	// if there is a focused chain, let's jump back to the first thing in that chain
	if (obj_chain.currentFocusedChainID != "") drawRangeUnit = scr_getFirstUnitOfChain(obj_chain.currentFocusedChainID);
	
	if (drawRangeUnit == "") drawRangeUnit = displayUnitList[|0];
	var drawRangeUnitSubMap = global.nodeMap[?drawRangeUnit];
	var drawRangeUnitSeq = 0;
	if (scr_isNumericAndExists(drawRangeUnitSubMap,ds_type_map)) {
		drawRangeUnitSeq = drawRangeUnitSubMap[? "unitSeq"];
	}
	var unitList = discourseSubMap[? "unitList"];
	
	show_debug_message("scr_disableFilter ... drawRangeUnit: " + string(drawRangeUnit));
	
	
	ds_list_copy(discourseSubMap[? "displayUnitList"], unitList);
	scr_jumpToUnitTop(drawRangeUnit);
	scr_setValueForAllNodesInList(unitList, "active", true);
	

	var unitListSize = ds_list_size(unitList);
	for (var i = 0; i < unitListSize; i++) {
		
		var currentUnit = unitList[|i];
		var currentUnitSubMap = global.nodeMap[?currentUnit];
		if (scr_isNumericAndExists(currentUnitSubMap,ds_type_map)) {
			var unitSeq = currentUnitSubMap[? "unitSeq"];	

			if (unitSeq < drawRangeUnitSeq) {
				currentUnitSubMap[? "pixelY"] = -9999;
			}
			else{
				currentUnitSubMap[? "pixelY"] = 9999;
			}	
		}
		
	}
	
	

}