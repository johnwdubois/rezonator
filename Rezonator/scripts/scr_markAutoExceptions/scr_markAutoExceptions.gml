// mark lines as exceptions until we reach first tag

var firstTagReached = false;
var exceptionDelimiter = "---";
var inExceptionCluster = false;

for (var i = 0; i < ds_grid_height(global.importTXTLineGrid); i++) {
	
	var currentLine = ds_grid_get(global.importTXTLineGrid, global.importTXTLineGrid_colLine, i);
	
	var delimiterLineCopy = string_copy(currentLine, 1, string_length(exceptionDelimiter));
	
	if (inExceptionCluster) {
		ds_grid_set(global.importTXTLineGrid, global.importTXTLineGrid_colException, i, true);
	}
	if (string_char_at(currentLine, 1) == "\\" && !firstTagReached) {
		firstTagReached = true;
	}
	else if (!firstTagReached) {
		ds_grid_set(global.importTXTLineGrid, global.importTXTLineGrid_colException, i, true);
	}
	else if (exceptionDelimiter == delimiterLineCopy) {
		inExceptionCluster = !inExceptionCluster;
		if (inExceptionCluster) {
			ds_grid_set(global.importTXTLineGrid, global.importTXTLineGrid_colException, i, true);
		}
	}
}