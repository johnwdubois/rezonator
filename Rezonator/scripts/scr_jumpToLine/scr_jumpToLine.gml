var lineStr = get_string("Type in the line you would like to jump to.", "");

if (lineStr == "")
{
	exit;
}

if (string_length(string_digits(lineStr)) < string_length(lineStr)
or string_length(lineStr) < 1)
{
	show_message("Numbers only.");
	scr_jumpToLine();
}

var lineNum = real(lineStr);

lineNum = min(lineNum, ds_grid_get_max(obj_control.lineGrid, obj_control.lineGrid_colLineNumberLabel, 0, obj_control.lineGrid_colLineNumberLabel, ds_grid_height(obj_control.lineGrid)));
lineNum = max(lineNum, ds_grid_get_min(obj_control.lineGrid, obj_control.lineGrid_colLineNumberLabel, 0, obj_control.lineGrid_colLineNumberLabel, ds_grid_height(obj_control.lineGrid)));

var rowInLineGrid = ds_grid_value_y(obj_control.lineGrid, obj_control.lineGrid_colLineNumberLabel, 0, obj_control.lineGrid_colLineNumberLabel, ds_grid_height(obj_control.lineGrid), lineNum);
	
if (rowInLineGrid >= 0)
{
	obj_control.currentCenterDisplayRow = ds_grid_get(obj_control.lineGrid, obj_control.lineGrid_colDisplayRow, rowInLineGrid);
}
else
{
	exit;
}