function scr_setDrawRange() {
	// set range of lines that we want to draw
	var lineGridHeight = ds_grid_height(currentActiveLineGrid);
	var relativeScrollBarHeight = camera_get_view_height(view_camera[0]) - wordTopMargin - (global.scrollBarWidth * 2) - 25;
	var relativeScrollBarPlusY = scrollBarPlusY - 15;
	//draw_text(camera_get_view_width(view_camera[0]) - 1200, 880, "lineGridHeight: " + string(lineGridHeight));
	//draw_text(camera_get_view_width(view_camera[0]) - 1200, 900, "ScrollBarHeight: " + string(relativeScrollBarHeight));
	//draw_text(camera_get_view_width(view_camera[0]) - 1200, 920, "scrollBarPlusY: " + string(relativeScrollBarPlusY));
	

	//still broke, gotta fix
	drawRangeCenter = ((relativeScrollBarPlusY) * lineGridHeight) / relativeScrollBarHeight;
	drawRangeCenter = round(drawRangeCenter) - 5;
	drawRangeCenter = clamp(drawRangeCenter, 0, lineGridHeight - 1);

	//var drawRangeOffset = 30;
	drawRangeStart = clamp(drawRangeCenter - drawRange, 0, lineGridHeight - 1);
	drawRangeEnd = clamp(drawRangeCenter + drawRange, 0, lineGridHeight - 1);




	var topY = wordTopMargin -(gridSpaceVertical * 5);
	var bottomY = camera_get_view_height(view_camera[0]) + (gridSpaceVertical * 5);



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

	if (drawRangeEnd + 1 < ds_grid_height(currentActiveLineGrid)) {
		while (ds_grid_get(currentActiveLineGrid, lineGrid_colPixelY, drawRangeEnd + 1) < bottomY) {
			drawRangeEnd++;
			drawRangeExtraStepsForward++;
		
			if (drawRangeEnd + 1 >= lineGridHeight) {
				break;
			}
		}
	}



}
