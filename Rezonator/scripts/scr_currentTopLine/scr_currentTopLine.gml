function scr_currentTopLine() {

	var camHeight = camera_get_view_height(view_camera[0]);
	var docSubMap = global.nodeMap[? global.discourseNode];
	var displayUnitList = docSubMap[? "displayUnitList"];
	
	var currentUnitIndex = obj_control.drawRangeStart;
	var currentUnit = displayUnitList[| currentUnitIndex];
	var currentUnitSubMap = global.nodeMap[? currentUnit];
	if (!scr_isNumericAndExists(currentUnitSubMap, ds_type_map)) exit;
	var currentUnitY = currentUnitSubMap[? "pixelY"];


	while (currentUnitY < obj_control.wordTopMargin + obj_control.gridSpaceVertical) {
		currentUnitIndex++;
		currentUnit = displayUnitList[| currentUnitIndex];
		currentUnitSubMap = global.nodeMap[? currentUnit];
		if (!scr_isNumericAndExists(currentUnitSubMap, ds_type_map)) exit;
		currentUnitY = currentUnitSubMap[? "pixelY"];
	}
	
	show_debug_message("scr_currentTopLine, currentUnit: " + string(currentUnit));
	return currentUnit;


}
