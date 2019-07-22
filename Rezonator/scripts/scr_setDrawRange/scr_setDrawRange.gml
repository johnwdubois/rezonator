// set range of lines that we want to draw
drawRangeStart = 0;
drawRangeEnd = ds_grid_height(currentActiveLineGrid) - 1;

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
