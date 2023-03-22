function scr_importAIChat(){
	
	var _msgList = obj_aiControl.msgList;
	var _msgListSize = ds_list_size(_msgList);

	ds_grid_clear(global.importTXTLineGrid, 0);
	ds_grid_resize(global.importTXTLineGrid, global.importTXTLineGridWidth, 0);
	
	for (var i = 0; i < _msgListSize; i++) {
		
		// get current message map
		var _msgMap = _msgList[| 0];
		var _selected = _msgMap[? "selected"];
		
		// if this message is selected, let's get its text
		if (_selected) {
			var _text = string(_msgMap[? "text"]);
			var _textSplit = string_split(_text, ". ", false);
			
			var _textSplitSize = array_length(_textSplit);
			show_debug_message("_textSplit: " + string(_textSplit));
			for (var j = 0; j < _textSplitSize; j++) {
				
				var _currentSplit = _textSplit[j];
				show_debug_message("_currentSplit: " + string(_currentSplit));
				
				ds_grid_resize(global.importTXTLineGrid, ds_grid_width(global.importTXTLineGrid), ds_grid_height(global.importTXTLineGrid) + 1);
				var row = ds_grid_height(global.importTXTLineGrid) - 1;
			
				global.importTXTLineGrid[# global.importTXTLineGrid_colLine, row] = _currentSplit;
				global.importTXTLineGrid[# global.importTXTLineGrid_colException, row] = _currentSplit == "";
			}
		}
	}
	
	global.importType = "import_type_prose";
	scr_importPlainTXT();

}