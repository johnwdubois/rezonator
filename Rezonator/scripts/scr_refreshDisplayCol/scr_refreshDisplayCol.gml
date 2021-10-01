// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_refreshDisplayCol(){
	
	show_debug_message("scr_refreshDisplayCol");
	
	obj_control.chainStretchCheck = false;
	with (obj_alarm2) alarm[2] = 15;
	var camWidth = camera_get_view_width(view_camera[0]);
	var docSubMap = global.nodeMap[? global.discourseNode];
	var unitList = docSubMap[? "unitList"];
	var unitListSize = ds_list_size(unitList);
	
	var startJustify = scr_checkNativeJustification();
	var maxColsOnScreen = scr_getMaxColsOnScreen();
	
	for (var i = 0; i < unitListSize; i++) {
		var currentUnit = unitList[| i];
		var currentUnitSubMap = global.nodeMap[? currentUnit];
		var currentEntryList = currentUnitSubMap[? "entryList"];
		var currentEntryListSize = ds_list_size(currentEntryList);
		for (var j = 0; j < currentEntryListSize; j++) {
			var currentEntry = currentEntryList[| j];
			var currentEntrySubMap = global.nodeMap[? currentEntry];
			var currentToken = currentEntrySubMap[? "token"];
			var currentTokenSubMap = global.nodeMap[? currentToken];
			

			var currentDisplayCol = 0;
			if (startJustify) {
				currentDisplayCol = j;
			}
			else {
				currentDisplayCol = maxColsOnScreen - currentEntryListSize + j - 1;
			}
			currentTokenSubMap[? "displayCol"] = currentDisplayCol;
			
		}
	}
	
	obj_control.scrollPlusXDest = 0;
	scr_refreshAlignment();
}