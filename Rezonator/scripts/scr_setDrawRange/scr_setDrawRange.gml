function scr_setDrawRange() {
	
	var camHeight = camera_get_view_height(camera_get_active());
	
	// set range of lines that we want to draw
	var lineGridHeight = ds_grid_height(currentActiveLineGrid);
	var relativeScrollBarHeight = camHeight - wordTopMargin - (global.scrollBarWidth * 2) - 25;
	var relativeScrollBarPlusY = scrollBarPlusY - 15;

	// still broke, gotta fix
	drawRangeCenter = ((relativeScrollBarPlusY) * lineGridHeight) / relativeScrollBarHeight;
	drawRangeCenter = round(drawRangeCenter) - 5;
	drawRangeCenter = clamp(drawRangeCenter, 0, lineGridHeight - 1);
	
	// make sure the draw range is clamped to not go past lineGrid
	drawRangeStart = clamp(drawRangeCenter - drawRange, 0, lineGridHeight - 1);
	drawRangeEnd = clamp(drawRangeCenter + drawRange, 0, lineGridHeight - 1);
	
	var topY = wordTopMargin -(gridSpaceVertical * 5);
	var bottomY = camHeight + (gridSpaceVertical * 5);

	drawRangeExtraStepsForward = 0;
	drawRangeExtraStepsBack = 0;
	if (drawRangeStart - 1 >= 0) {
		while (ds_grid_get(currentActiveLineGrid, lineGrid_colPixelY, drawRangeStart - 1) > topY) {
			drawRangeStart--;
			drawRangeExtraStepsBack++;
		
			if (drawRangeStart - 1 < 0) {
				break;
			}
		}
	}
	
	// make sure that the drawRangeEnd is never extending more than it should
	if (drawRangeExtraStepsBack > 0) {
		drawRangeEnd = min(drawRangeEnd, drawRangeStart + (drawRange * 2));
	}

	if (drawRangeEnd + 1 < ds_grid_height(currentActiveLineGrid)) {
		while (ds_grid_get(currentActiveLineGrid, lineGrid_colPixelY, drawRangeEnd + 1) < bottomY) {
			drawRangeEnd++;
			drawRangeExtraStepsForward++;
		
			if (drawRangeEnd + 1 >= lineGridHeight) {
				break;
			}
		}
	}
	
	//show_debug_message("drawRange: " + string(drawRange) + ", drawRangeExtraStepsBack: " + string(drawRangeExtraStepsBack) + ", drawRangeExtraStepsForward: " + string(drawRangeExtraStepsForward));

}
