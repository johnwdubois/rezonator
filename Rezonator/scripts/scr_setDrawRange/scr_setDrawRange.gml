// set range of lines that we want to draw

var relativeScrollBarHeight = camera_get_view_height(view_camera[0]) - wordTopMargin - (scrollBarWidth * 2);
var relativeScrollBarPlusY = scrollBarPlusY;

drawRangeCenter = (relativeScrollBarPlusY * ds_grid_height(currentActiveLineGrid)) / relativeScrollBarHeight;
drawRangeCenter = round(drawRangeCenter);
drawRangeCenter = clamp(drawRangeCenter, 0, ds_grid_height(currentActiveLineGrid) - 1);

//var drawRangeOffset = 30;
drawRangeStart = clamp(drawRangeCenter - obj_control.drawRange, 0, ds_grid_height(currentActiveLineGrid) - 1);
drawRangeEnd = clamp(drawRangeCenter + obj_control.drawRange, 0, ds_grid_height(currentActiveLineGrid) - 1);




var topY = wordTopMargin -(obj_control.gridSpaceVertical * 10);
var bottomY = camera_get_view_height(view_camera[0]) + (obj_control.gridSpaceVertical * 10);



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
		
		if (drawRangeEnd + 1 >= ds_grid_height(currentActiveLineGrid)) {
			break;
		}
	}
}
