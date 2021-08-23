function scr_jumpToUnit(unitOrSeq) {
	
	show_debug_message("scr_jumpToUnit: " + string(unitOrSeq));
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
	show_debug_message("scr_jumpToUnit: unitID: " + string(unitID) + ", unitIndex: " + string(unitIndex));
	
	// make sure the unit exists and is in the displayUnitList
	if (unitIndex < 0 || !scr_isNumericAndExists(unitSubMap, ds_type_map)) {
		show_debug_message("scr_jumpToUnit ... unit is not in displayUnitList. Exiting...");
		exit;
	}
	
	// set scroll position
	var scrollPos = -((unitIndex * obj_control.gridSpaceVertical) - obj_control.wordTopMargin);
	show_debug_message("scr_jumpToUnit ... setting scroll from " + string(obj_control.scrollPlusYDest) + " to " + string(scrollPos));
	obj_control.scrollPlusYDest = scrollPos;

	
	

}
