// set range of lines that we want to draw


var bottomY = camera_get_view_height(view_camera[0]);
if (instance_exists(obj_audioUI)) {
	bottomY = obj_audioUI.y;
}
var centerY = mean(wordTopMargin, bottomY);
var scrollBarHeight = camera_get_view_height(view_camera[0]) - wordTopMargin;
var drawRangeCenter = (scrollBarPlusY * ds_grid_height(currentActiveLineGrid)) / scrollBarHeight;
drawRangeCenter = round(drawRangeCenter);
drawRangeCenter = clamp(drawRangeCenter, 0, ds_grid_height(currentActiveLineGrid) - 1);

var drawRangeOffset = 30;
drawRangeStart = clamp(drawRangeCenter - drawRangeOffset, 0, ds_grid_height(currentActiveLineGrid) - 1);
drawRangeEnd = clamp(drawRangeCenter + drawRangeOffset, 0, ds_grid_height(currentActiveLineGrid) - 1);


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