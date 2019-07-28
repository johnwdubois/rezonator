var timeStr = argument0;
discoID = obj_panelPane.selectedDiscoID;

var foundRow = 0;

if (timeStr == "") {
	exit;
}

if (string_length(string_digits(timeStr)) < string_length(timeStr)
or string_length(timeStr) < 1) {
	show_message("Numbers only.");
	exit;
}

for(var i = 0 ; i< ds_grid_height(obj_control.lineGrid); i++){
	var currentTime = ds_grid_get(obj_control.lineGrid, obj_control.lineGrid_colUnitStart, i);
	if(currentTime > timeStr){
		foundRow = ds_grid_value_y(obj_control.lineGrid, obj_control.lineGrid_colUnitStart, 0, obj_control.lineGrid_colUnitStart, ds_grid_height(obj_control.lineGrid) , currentTime );
		i = ds_grid_height(obj_control.lineGrid);
	}
}

	show_message(foundRow);

var lineNum = real(foundRow);

var lineNumMin = ds_grid_get_min(obj_control.lineGrid, obj_control.lineGrid_colLineNumberLabel, 0, obj_control.lineGrid_colLineNumberLabel, ds_grid_height(obj_control.lineGrid));
var lineNumMax = ds_grid_get_max(obj_control.lineGrid, obj_control.lineGrid_colLineNumberLabel, 0, obj_control.lineGrid_colLineNumberLabel, ds_grid_height(obj_control.lineGrid));

lineNum = clamp(lineNum, lineNumMin, lineNumMax);

var rowInLineGrid = -1;
if (discoID == "") {
	rowInLineGrid = ds_grid_value_y(obj_control.lineGrid, obj_control.lineGrid_colLineNumberLabel, 0, obj_control.lineGrid_colLineNumberLabel, ds_grid_height(obj_control.lineGrid), lineNum);
}
else {
	rowInLineGrid = scr_findInGridTwoParameters(obj_control.lineGrid, obj_control.lineGrid_colDiscoID, discoID, obj_control.lineGrid_colLineNumberLabel, lineNum);
}
	
if (rowInLineGrid >= 0) {
	var linePixelY = ds_grid_get(obj_control.lineGrid, obj_control.lineGrid_colPixelYOriginal, rowInLineGrid);
	obj_control.scrollPlusYDest = -linePixelY + (camera_get_view_height(view_camera[0]) / 2) - 100;
}
else {
	exit;
}