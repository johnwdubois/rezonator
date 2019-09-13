var discoID = argument0;
var lineStr = argument1;
discoID = obj_panelPane.selectedDiscoID;

if (lineStr == "") {
	exit;
}

if (string_length(string_digits(lineStr)) < string_length(lineStr)
or string_length(lineStr) < 1) {
	show_message("Numbers only.");
	exit;
}

var lineNum = real(lineStr);

var lineNumMin = ds_grid_get_min(obj_control.currentActiveLineGrid, obj_control.lineGrid_colLineNumberLabel, 0, obj_control.lineGrid_colLineNumberLabel, ds_grid_height(obj_control.currentActiveLineGrid));
var lineNumMax = ds_grid_get_max(obj_control.currentActiveLineGrid, obj_control.lineGrid_colLineNumberLabel, 0, obj_control.lineGrid_colLineNumberLabel, ds_grid_height(obj_control.currentActiveLineGrid));

lineNum = clamp(lineNum, lineNumMin, lineNumMax);


var currentLineCheck = lineNum;
while (!ds_grid_value_exists(obj_control.currentActiveLineGrid, obj_control.lineGrid_colLineNumberLabel, 0, obj_control.lineGrid_colLineNumberLabel, ds_grid_height(obj_control.currentActiveLineGrid), currentLineCheck)
and currentLineCheck >= lineNumMin) {
	
	currentLineCheck--;	
}
lineNum = currentLineCheck;

var rowInLineGrid = -1;
if (discoID == "") {
	rowInLineGrid = ds_grid_value_y(obj_control.currentActiveLineGrid, obj_control.lineGrid_colLineNumberLabel, 0, obj_control.lineGrid_colLineNumberLabel, ds_grid_height(obj_control.currentActiveLineGrid), lineNum);
}
else {
	rowInLineGrid = scr_findInGridTwoParameters(obj_control.currentActiveLineGrid, obj_control.lineGrid_colDiscoID, discoID, obj_control.lineGrid_colLineNumberLabel, lineNum);
}
	
if (rowInLineGrid >= 0) {
	var linePixelY = ds_grid_get(obj_control.currentActiveLineGrid, obj_control.lineGrid_colPixelYOriginal, rowInLineGrid);
	obj_control.scrollPlusYDest = -linePixelY + (camera_get_view_height(view_camera[0]) / 2) - 100;
}
else {
	exit;
}