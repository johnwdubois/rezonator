function scr_homeEnd(home) {
	
	show_debug_message("scr_homeEnd, home: " + string(home));
	
	var ltr = obj_control.drawLineState == obj_control.lineState_ltr;
	var startJustify = scr_checkNativeJustification();
	var gridJustify = obj_control.shape == obj_control.shapeBlock;
	
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
	if (!scr_isNumericAndExists(discourseSubMap, ds_type_map)) exit;
	var displayUnitList = discourseSubMap[? "displayUnitList"];
	if (!scr_isNumericAndExists(displayUnitList, ds_type_list)) exit;
	if (!is_numeric(obj_control.drawRangeStart) || !is_numeric(obj_control.drawRangeEnd)) exit;
	var drawStart = obj_control.drawRangeStart;
	var drawEnd = obj_control.drawRangeEnd;
	
	for (var i = drawStart; i < drawEnd; i++) {
		
		var currentUnit = displayUnitList[| i];
		var currentUnitSubMap = global.nodeMap[? currentUnit];
		if (!scr_isNumericAndExists(currentUnitSubMap, ds_type_map)) continue;
		var currentPixelY = currentUnitSubMap[? "pixelY"];
		
		if (currentPixelY >= obj_control.wordTopMargin && currentPixelY < camHeight) {
		
			var currentEntryList = currentUnitSubMap[? "entryList"];
			if (!scr_isNumericAndExists(currentEntryList, ds_type_list)) continue;
			var currentEntryListSize = ds_list_size(currentEntryList);
		
			for (var j = 0; j < currentEntryListSize; j++) {
			
				var currentEntry = currentEntryList[| j];
				var currentEntrySubMap = global.nodeMap[? currentEntry];
				if (!scr_isNumericAndExists(currentEntrySubMap, ds_type_map)) continue;
				var currentToken = currentEntrySubMap[? "token"];
				var currentTokenSubMap = global.nodeMap[? currentToken];
				if (!scr_isNumericAndExists(currentTokenSubMap, ds_type_map)) continue;
			
				var currentDisplayCol = currentTokenSubMap[? "displayCol"];
				var currentPixelX = currentTokenSubMap[? "pixelX"];
				if (!is_numeric(currentDisplayCol) || !is_numeric(currentPixelX)) continue;
				
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
	
	
	var ltrEndJustityHomeCheck = ltr && !startJustify && home;
	if (ltrEndJustityHomeCheck && firstPixelX > obj_control.wordLeftMargin) {
		exit;
	}
	
	var rtlStartJustityEndCheck = !ltr && startJustify && !home;
	if (rtlStartJustityEndCheck && lastPixelX > obj_control.wordLeftMargin) {
		exit;
	}
	
	
	
	
	show_debug_message("firstPixelX: " + string(firstPixelX) + ", lastPixelX: " + string(lastPixelX));

	var reverseScreen = (!ltr && !home) || (ltr && home);
	var isBad = !ltr && home && !startJustify && !gridJustify;
	var isReallyBad = !ltr && home && !startJustify && gridJustify;
	var theWorst = !ltr && startJustify && gridJustify && !home;
	show_debug_message("reverseScreen: " + string(reverseScreen) + ", isBad: " + string(isBad));
	
	
	
	var adjustedCamWidth = camWidth - global.toolPaneWidth - global.scrollBarWidth;
	if (reverseScreen) adjustedCamWidth = -obj_control.wordLeftMargin - obj_control.gridSpaceHorizontal;
	if (isBad) adjustedCamWidth -= (global.toolPaneWidth + global.scrollBarWidth);

	

	
	var adjustedPixelX = home ? firstPixelX : lastPixelX;
	
	
	var distToScroll = max(abs(adjustedPixelX) - adjustedCamWidth, 0);
	if (!reverseScreen) distToScroll = -distToScroll;
	if (isReallyBad) distToScroll = -distToScroll;
	if (theWorst) distToScroll = -distToScroll;
	
	obj_control.scrollPlusXDest += distToScroll;
	obj_control.scrollPlusX = obj_control.scrollPlusXDest;
	
}
