// set range of lines that we want to draw
//drawRangeStart = 0;
//drawRangeEnd = ds_grid_height(currentActiveLineGrid) - 1;


/*
while (ds_grid_get(currentActiveLineGrid, lineGrid_colPixelY, drawRangeStart) < -(obj_control.gridSpaceVertical * 10)) {
	drawRangeStart++;
	drawRangeStart = clamp(drawRangeStart, 0, ds_grid_height(currentActiveLineGrid) - 1);
	if (drawRangeStart == 0 or drawRangeStart == ds_grid_height(currentActiveLineGrid) - 1) {
		break;
	}
}

while (ds_grid_get(currentActiveLineGrid, lineGrid_colPixelY, drawRangeEnd) > camera_get_view_height(view_camera[0]) + (obj_control.gridSpaceVertical * 10)) {
	drawRangeEnd--;
	drawRangeEnd = clamp(drawRangeEnd, 0, ds_grid_height(currentActiveLineGrid) - 1);
	if (drawRangeEnd == 0 or drawRangeEnd == ds_grid_height(currentActiveLineGrid) - 1) {
		break;
	}
}
*/


var drawRangeCenter = (scrollBarPlusY * ds_grid_height(lineGrid)) / (camera_get_view_height(view_camera[0]) - 250);
drawRangeCenter = round(drawRangeCenter);
drawRangeCenter = clamp(drawRangeCenter, 0, ds_grid_height(currentActiveLineGrid) - 1);

drawRangeStart = clamp(drawRangeCenter - 30, 0, ds_grid_height(currentActiveLineGrid) - 1);
drawRangeEnd = clamp(drawRangeCenter + 30, 0, ds_grid_height(currentActiveLineGrid) - 1);


drawRangeExtraSteps = 0;

if (drawRangeStart - 1 >= 0) {
	while (ds_grid_get(currentActiveLineGrid, lineGrid_colPixelY, drawRangeStart - 1) > -(obj_control.gridSpaceVertical * 10)) {
		drawRangeStart--;
		drawRangeExtraSteps++;
		
		if (drawRangeStart - 1 < 0) {
			break;
		}
	}
}

if (drawRangeEnd + 1 < ds_grid_height(lineGrid)) {
	while (ds_grid_get(currentActiveLineGrid, lineGrid_colPixelY, drawRangeEnd + 1) < camera_get_view_height(view_camera[0]) + (obj_control.gridSpaceVertical * 10)) {
		drawRangeEnd++;
		drawRangeExtraSteps++;
		
		if (drawRangeEnd + 1 >= ds_grid_height(lineGrid)) {
			break;
		}
	}
}