if (directory_exists(global.rezonatorDirString)) {
	var filename = global.rezonatorDirString + "\\~fps.txt";
	fpsTrackFile = file_text_open_write(filename);
	
	var gridStr = "";
	for (var i = 0; i < fpsGridCurrentRow; i++) {	
		
		if (i >= ds_grid_height(fpsGrid)) {
			continue;
		}
		
		for (var j = 0; j < ds_grid_width(fpsGrid); j++) {
			
			gridStr += string(ds_grid_get(fpsGrid, j, i)) + ", ";
			
		}
		
		gridStr += "#";
	}
	
	file_text_write_string(fpsTrackFile, string_hash_to_newline(gridStr));
	file_text_close(fpsTrackFile);
}