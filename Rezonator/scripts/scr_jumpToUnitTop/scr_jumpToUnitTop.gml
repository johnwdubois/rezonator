function scr_jumpToUnitTop(unitOrSeq) {
	
	show_debug_message("scr_jumpToUnitTop: " + string(unitOrSeq));
	if( unitOrSeq == "" || unitOrSeq == undefined ){exit;}
	
	// get display unit list
	var discourseSubMap = global.nodeMap[? global.discourseNode];
	if (!scr_isNumericAndExists(discourseSubMap, ds_type_map)) exit;
	var displayUnitList = discourseSubMap[? "displayUnitList"];
	if (!scr_isNumericAndExists(displayUnitList, ds_type_list)) exit;
	var fullUnitList = discourseSubMap[? "unitList"];
	if (!scr_isNumericAndExists(fullUnitList, ds_type_list)) exit;
	
	// check whether this function was given the unitID (string) or the unitSeq (number)
	var unitID = "";
	var unitSubMap = global.nodeMap[? unitOrSeq];
	if (is_string(unitOrSeq) && scr_isNumericAndExists(unitSubMap, ds_type_map)) {
		// if we are given a unitID, we are good
		unitID = unitOrSeq;
	}
	else if (is_numeric(unitOrSeq)) {
		// if we are given a unitSeq, we need to look in the fullUnitList to get the unitID
		unitID = fullUnitList[| unitOrSeq];
	}
	
	// now we can search the displayUnitList to get the unitIndex
	var unitIndex = ds_list_find_index(displayUnitList, unitID);
	unitSubMap = global.nodeMap[? unitID];
	show_debug_message("scr_jumpToUnitTop: unitID: " + string(unitID) + ", unitIndexTop: " + string(unitIndex));
	
	// make sure the unit exists and is in the displayUnitList
	if (unitIndex < 0 || !scr_isNumericAndExists(unitSubMap, ds_type_map)) {
		show_debug_message("scr_jumpToUnitTop ... unit is not in displayUnitList. Exiting...");
		exit;
	}
	var trueIndex = (obj_control.offIndex) ? unitIndex-1 : unitIndex;
	// set scroll position
	var scrollPos = -(((trueIndex) * obj_control.gridSpaceVertical));
	show_debug_message("scr_jumpToUnitTop ... setting scroll from " + string(obj_control.scrollPlusYDest) + " to " + string(scrollPos));
	obj_control.scrollPlusYDest = scrollPos;
	obj_control.updateChainShowMap = true;
	
	obj_control.refreshYValuesUnit = unitID;
	with (obj_alarm2) alarm[9] = 2;
	
	if(!obj_control.offIndex){
		obj_control.unitFlash = obj_control.flashTime;
		obj_control.unitToFlash = unitID;
	}
	else{
		
	}
	obj_control.offIndex = false;
	

}
