function scr_setDrawRange(camHeight, displayUnitList, displayUnitListSize) {
	
	// set range of lines that we want to draw
	var relativeScrollBarHeight = camHeight - wordTopMargin - (global.scrollBarWidth * 2) - 25;
	var relativeScrollBarPlusY = scrollBarPlusY - 15;

	// still broke, gotta fix
	drawRangeCenter = ((relativeScrollBarPlusY) * displayUnitListSize) / relativeScrollBarHeight;
	drawRangeCenter = round(drawRangeCenter) - 5;
	drawRangeCenter = clamp(drawRangeCenter, 0, displayUnitListSize - 1);
	
	// make sure the draw range is clamped to not go past lineGrid
	drawRangeStart = clamp(drawRangeCenter - drawRange, 0, displayUnitListSize - 1);
	drawRangeEnd = clamp(drawRangeCenter + drawRange, 0, displayUnitListSize - 1);
	
	var topY = wordTopMargin -(gridSpaceVertical * 5);
	var bottomY = camHeight + (gridSpaceVertical * 5);
	
	var currentUnit = "";
	var currentUnitSubMap = -1;
	var currentUnitPixelY = 0;
	drawRangeExtraStepsForward = 0;
	drawRangeExtraStepsBack = 0;
	
	
	// extend drawRange backwards
	if (drawRangeStart - 1 >= 0) {
		currentUnit = displayUnitList[| drawRangeStart - 1];
		currentUnitSubMap = global.nodeMap[? currentUnit];
		if (scr_isNumericAndExists(currentUnitSubMap, ds_type_map)) {

			currentUnitPixelY = currentUnitSubMap[? "pixelY"];
		
			while (currentUnitPixelY > topY) {
				drawRangeStart--;
				drawRangeExtraStepsBack++;
		
				if (drawRangeStart - 1 < 0) {
					break;
				}
				else {
					currentUnit = displayUnitList[| drawRangeStart - 1];
					currentUnitSubMap = global.nodeMap[? currentUnit];
					currentUnitPixelY = currentUnitSubMap[? "pixelY"];
				}
			}
		}
	}
	
	
	
	var firstUnit = displayUnitList[| drawRangeStart];
	var firstUnitSubMap = global.nodeMap[? firstUnit];
	if (scr_isNumericAndExists(firstUnitSubMap, ds_type_map)) { 
		
		var firstUnitPixelY = firstUnitSubMap[? "pixelY"];
		while (firstUnitPixelY > -gridSpaceVertical && drawRangeStart - 1 >= 0) {
			drawRangeStart--;
			drawRangeExtraStepsBack++;
		
			if (drawRangeStart - 1 < 0) {
				break;
			}
			else {
				firstUnit = displayUnitList[| drawRangeStart];
				firstUnitSubMap = global.nodeMap[? firstUnit];
				firstUnitPixelY = firstUnitSubMap[? "pixelY"];
			}
		}
	}

	
	
	
	// make sure that the drawRangeEnd is never extending more than it should
	if (drawRangeExtraStepsBack > 0) {
		drawRangeEnd = min(drawRangeEnd, drawRangeStart + (drawRange * 2));
	}
	


	// extend drawRange forwards
	if (drawRangeEnd + 1 < displayUnitListSize) {
		currentUnit = displayUnitList[| drawRangeEnd + 1];
		currentUnitSubMap = global.nodeMap[? currentUnit];
		if (scr_isNumericAndExists(currentUnitSubMap, ds_type_map)) {
			currentUnitPixelY = currentUnitSubMap[? "pixelY"];
		
		
			while (currentUnitPixelY < bottomY) {
				drawRangeEnd++;
				drawRangeExtraStepsForward++;
		
				if (drawRangeEnd + 1 >= displayUnitListSize) {
					break;
				}
				else {
					currentUnit = displayUnitList[| drawRangeEnd + 1];
					currentUnitSubMap = global.nodeMap[? currentUnit];
					currentUnitPixelY = currentUnitSubMap[? "pixelY"];
				}
			}
		}
	}

	
}
