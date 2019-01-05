var grid = argument0
var fileName = argument1;

var file = file_text_open_write_ns(fileName, -1);

for (var i = -1; i < ds_grid_height(grid); i++)
{	
	var lineStr = "";
	for (var j = 0; j < ds_grid_width(grid); j++)
	{
		if (i == -1)
		{
			lineStr += scr_getColNameString(grid, j);
		}
		else if (i >= 0)
		{
			lineStr += scr_drawGridViewerGetItemString(grid, j, i);
		}
		
		if (i >= -1 and j < ds_grid_width(grid) - 1)
		{
			lineStr += ",";
		}
	}
	
	file_text_write_line_ns(file, lineStr);
}

file_text_close_ns(file);