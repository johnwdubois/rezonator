function scr_importAIChat(){
	
	var _msgList = obj_aiControl.msgList;
	var _msgListSize = ds_list_size(_msgList);

	ds_grid_clear(global.importTXTLineGrid, 0);
	ds_grid_resize(global.importTXTLineGrid, global.importTXTLineGridWidth, 0);
	
	for (var i = 0; i < _msgListSize; i++) {
		
		// get current message map
		var _msgMap = _msgList[| i];
		var _selected = _msgMap[? "selected"];
		
		// if this message is selected, let's get its text
		if (_selected) {
			
			var _text = string(_msgMap[? "text"]);
			
			// let's get rid of carriage returns
			_text = string_replace_all(_text, "\r", "");
			
			// and then split on newlines
			var _lines = scr_splitString(_text, "\n", false);
			var _linesSize = ds_list_size(_lines);
			
			for (var j = 0; j < _linesSize; j++) {
				
				// separate this line into its participant (everything before the first colon) and turn (everything else)
				var _currentLine = _lines[| j];
				var _participant = "";
				var _turn = "";
				var _colonPos = string_pos(": ", _currentLine);
			
				if (_colonPos >= 1) {
					_participant = string_copy(_currentLine, 1, _colonPos - 1);
					_turn = string_delete(_currentLine, 1, _colonPos + 1);
					show_debug_message("_participant: {0}, _turn: {1}", _participant, _turn);
				}
				else {
					// if we can't find a colon, we assume this entire line is the turn
					_turn = _currentLine;
				}
			
				// now let's split the turn into sentences, making sure to keep delimiters
				var _sentences = scr_splitString(_turn, ". ", true);
		
				// for each sentence, create a new row in the importLineGrid
				var _sentencesSize = ds_list_size(_sentences);
				for (var k = 0; k < _sentencesSize; k++) {
				
					// get current sentence, skip any blank lines
					var _currentSentence = _sentences[| k];
					if (scr_isStrOnlyWhitespace(_currentSentence) || _currentSentence == "") continue;
					show_debug_message("_currentSentence: " + string(_currentSentence));
				
					// grow grid by one row
					ds_grid_resize(global.importTXTLineGrid, ds_grid_width(global.importTXTLineGrid), ds_grid_height(global.importTXTLineGrid) + 1);
					var row = ds_grid_height(global.importTXTLineGrid) - 1;
			
					// put sentence data into grid
					global.importTXTLineGrid[# global.importTXTLineGrid_colLine, row] = _participant + "	" + _currentSentence;
					global.importTXTLineGrid[# global.importTXTLineGrid_colException, row] = _currentSentence == "";
				}
			}
		}
	}
	
	global.importType = "import_type_transcription";
	scr_importTabbedTXT("	");

}