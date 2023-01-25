

function scr_setUnitYValues(unitID) {
	
	show_debug_message("scr_setUnitYValues, unitID: " + string(unitID));
	if (unitID == "" || !is_string(unitID)) exit;
	var docSubMap = global.nodeMap[? global.discourseNode];
	var displayUnitList = docSubMap[? "displayUnitList"];
	var unitIndex = ds_list_find_index(displayUnitList, unitID);
	var camHeight = camera_get_view_height(view_camera[0]);
	
	if (unitIndex >= 0) {
		var displayUnitListSize = ds_list_size(displayUnitList);
		for (var i = 0; i < displayUnitListSize; i++) {
		
			var currentUnit = displayUnitList[|i];
			var currentUnitSubMap = global.nodeMap[?currentUnit];
			if (scr_isNumericAndExists(currentUnitSubMap,ds_type_map)) {

				if (i < unitIndex) {
					currentUnitSubMap[? "pixelY"] = -500;
				}
				else{
					currentUnitSubMap[? "pixelY"] = camHeight + 500;
				}
			}
		}
	}
}