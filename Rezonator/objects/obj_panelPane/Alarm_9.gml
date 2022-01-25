/// @description set panelPane focused unit
if (functionChainList_focusedUnitIndex < 0) {
	var discourseSubMap = global.nodeMap[? global.discourseNode];
	if (scr_isNumericAndExists(discourseSubMap, ds_type_map)) {
		var displayUnitList = discourseSubMap[? "displayUnitList"];
		if (scr_isNumericAndExists(displayUnitList, ds_type_list)) {
			if (ds_list_size(displayUnitList) > 0) {
				with (obj_panelPane) {
					functionChainList_focusedUnitIndex = 0;
					functionChainList_focusedUnit = displayUnitList[| functionChainList_focusedUnitIndex];
					scr_clearNavWindowTagging();
				}
			}
		}
	}
}