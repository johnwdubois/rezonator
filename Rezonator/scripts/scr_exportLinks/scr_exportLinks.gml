var file = argument0;
var grid = argument1;
var gridName = scr_getGridNameString(grid);

file_text_writeln(file);
file_text_write_string(file, "<" + gridName + ">");
file_text_writeln(file);


for (var i = 0; i < ds_grid_height(grid); i++)
{
	var linkFileLine = "";
	
	for (var j = 0; j < ds_grid_width(grid); j++)
	{
		linkFileLine += string(ds_grid_get(grid, j, i));
		
		if (j < ds_grid_width(grid) - 1)
		{
			linkFileLine += ",";
		}
	}
	
	file_text_write_string(file, linkFileLine);
	file_text_writeln(file);
}

file_text_write_string(file, "</" + gridName + ">");
file_text_writeln(file);