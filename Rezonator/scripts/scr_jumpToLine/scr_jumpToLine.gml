var lineStr = get_string("Type in the line you would like to jump to.", "");

if (string_length(string_digits(lineStr)) < 1)
{
	exit;
}

var lineNum = real(lineStr);

if (lineNum >= 0 && lineNum <= ds_grid_height(obj_control.lineGrid))
{
	var rowInLineGrid = ds_grid_value_y(obj_control.lineGrid, obj_control.lineGrid_colLineNumberLabel, 0, obj_control.lineGrid_colLineNumberLabel, ds_grid_height(obj_control.lineGrid), lineNum);
	
	if (rowInLineGrid >= 0)
	{
		obj_control.currentCenterDisplayRow = ds_grid_get(obj_control.lineGrid, obj_control.lineGrid_colDisplayRow, rowInLineGrid);
	}
	else
	{
		exit;
	}
}
else
{
	exit;
}