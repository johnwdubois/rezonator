function scr_exportREZ() {
	// DECOMMISSIONED

	var exportFile = get_save_filename("REZ file|*.rez", "Rezonator Project");

	if (exportFile == "")
	{
		exit;
	}

	var file = file_text_open_write(exportFile);

	if (file == -1)
	{
		exit;
	}

	var fileLineRipGridHeight = ds_grid_height(global.fileLineRipGrid);
	for (var i = 0; i < fileLineRipGridHeight; i++)
	{
		var currentFileLineRipList = ds_grid_get(global.fileLineRipGrid, global.fileLineRipGrid_colFileLineRipList, i);
	
		var currentFileLineRipListSize = ds_list_size(currentFileLineRipList);
		for (var j = 0; j < currentFileLineRipListSize; j++)
		{
			var currentFileLine = ds_list_find_value(currentFileLineRipList, j);
			if (string_length(currentFileLine) <= 0)
			{
				continue;
			}
		
			file_text_write_string(file, currentFileLine);
		}
	}

	file_text_writeln(file);

	scr_exportLinks(file, obj_chain.linkGrid);

	file_text_close(file);


}
