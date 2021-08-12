function scr_homeEnd(home) {
	
	show_debug_message("scr_homeEnd, home: " + string(home));
	
	var ltr = obj_control.drawLineState == obj_control.lineState_ltr;
	var startJustify = scr_checkNativeJustification();
	
	if ((home && startJustify) || (!home && !startJustify)) {
		obj_control.scrollPlusXDest = 0;
		obj_control.scrollPlusX = 0;
		exit;
	}

	
	var camWidth = camera_get_view_width(view_camera[0]);
	var camHeight = camera_get_view_height(view_camera[0]);
	
	var firstDisplayCol = 999999999;
	var firstPixelX = 9999999999;
	var lastDisplayCol = 0;
	var lastPixelX = 0;
	
	var discourseSubMap = global.nodeMap[? global.discourseNode];
	var displayUnitList = discourseSubMap[? "displayUnitList"];
	
	for (var i = obj_control.drawRangeStart; i < obj_control.drawRangeEnd; i++) {
		
		var currentUnit = displayUnitList[| i];
		var currentUnitSubMap = global.nodeMap[? currentUnit];
		var currentPixelY = currentUnitSubMap[? "pixelY"];
		
		if (currentPixelY >= obj_control.wordTopMargin && currentPixelY < camHeight) {
		
			var currentEntryList = currentUnitSubMap[? "entryList"];
			var currentEntryListSize = ds_list_size(currentEntryList);
		
			for (var j = 0; j < currentEntryListSize; j++) {
			
				var currentEntry = currentEntryList[| j];
				var currentEntrySubMap = global.nodeMap[? currentEntry];
				var currentToken = currentEntrySubMap[? "token"];
				var currentTokenSubMap = global.nodeMap[? currentToken];
			
				var currentDisplayCol = currentTokenSubMap[? "displayCol"];
				var currentPixelX = currentTokenSubMap[? "pixelX"];
			
			
				if (currentDisplayCol < firstDisplayCol) {
					firstDisplayCol = currentDisplayCol;
					firstPixelX = currentPixelX;
				}
				else if (currentDisplayCol > lastDisplayCol) {
					lastDisplayCol = currentDisplayCol;
					lastPixelX = currentPixelX;
				}
			}
		}
	}
	

	
	var reverseScreen = (!ltr && !home) || (ltr && home);
	var isBad = !ltr && home && !startJustify;
	
	var adjustedCamWidth = camWidth - global.toolPaneWidth - global.scrollBarWidth;
	if (reverseScreen) adjustedCamWidth = -obj_control.wordLeftMargin - obj_control.gridSpaceHorizontal;
	if (isBad) adjustedCamWidth -= (global.toolPaneWidth + global.scrollBarWidth);
	

	
	var adjustedPixelX = home ? firstPixelX : lastPixelX;
	
	
	var distToScroll = max(abs(adjustedPixelX) - adjustedCamWidth, 0);
	if (!reverseScreen) distToScroll = -distToScroll;
	
	
	obj_control.scrollPlusXDest += distToScroll;
	obj_control.scrollPlusX = obj_control.scrollPlusXDest;
	
}
