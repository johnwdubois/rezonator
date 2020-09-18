function scr_exportLinks(argument0, argument1) {
	// DECOMMISSIONED
	var file = argument0;
	var grid = argument1;
	var gridName = scr_getGridNameString(grid);

	file_text_writeln(file);
	file_text_write_string(file, "<" + gridName + ">");
	file_text_writeln(file);

	var gridHeight = ds_grid_height(grid);
	var gridWidth = ds_grid_width(grid);

	for (var i = 0; i < gridHeight; i++)
	{
		var linkFileLine = "";
	
		for (var j = 0; j < gridWidth; j++)
		{
			linkFileLine += string(ds_grid_get(grid, j, i));
		
			if (j < gridWidth - 1)
			{
				linkFileLine += ",";
			}
		}
	
		file_text_write_string(file, linkFileLine);
		file_text_writeln(file);
	}

	file_text_write_string(file, "</" + gridName + ">");
	file_text_writeln(file);


}
