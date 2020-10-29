function scr_markAutoExceptions() {
	
	var exceptionDelimiter = "---";
	var inExceptionBlock = false;

	var importTXTLineGridHeight = ds_grid_height(global.importTXTLineGrid);
	for (var i = 0; i < importTXTLineGridHeight; i++) {
		
		// get the first n characters of the line, where n = the length of the exceptionDelimiter
		var currentLine = ds_grid_get(global.importTXTLineGrid, global.importTXTLineGrid_colLine, i);
		var delimiterLineCopy = string_copy(currentLine, 1, string_length(exceptionDelimiter));
		
		var firstToken = string_copy(currentLine, 0, 1); 
	
		if (inExceptionBlock) {
			ds_grid_set(global.importTXTLineGrid, global.importTXTLineGrid_colException, i, true);
		}
		
		if (exceptionDelimiter == delimiterLineCopy) {
			inExceptionBlock = !inExceptionBlock;
			if (inExceptionBlock) {
				ds_grid_set(global.importTXTLineGrid, global.importTXTLineGrid_colException, i, true);
			}
		}
		if(global.importType_IGT){
			if(firstToken == "#"){
				ds_grid_set(global.importTXTLineGrid, global.importTXTLineGrid_colException, i, true);
			}
		}
	}
}
