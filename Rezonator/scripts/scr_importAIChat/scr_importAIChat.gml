function scr_importAIChat(){
	
	var _msgList = global.aiChatMsgList;
	var _msgListSize = ds_list_size(_msgList);
	
	var lineList = ds_list_create();
	
	// if we need to find last ai message
	var lastAiMsg = -1;
	if (obj_aiControl.aiImportType == "last") {
		for (var i = 0; i < _msgListSize; i++) {
			if (lastAiMsg == -1) {
				var _msgMap = _msgList[| i];
				if (!scr_isNumericAndExists(_msgMap, ds_type_map)) continue;
				var _author = _msgMap[? "author"];
				if (_author == "ChatGPT") lastAiMsg = _msgMap;
			}
		}
	}
	
	
	for (var i = _msgListSize - 1; i >= 0; i--) {
		
		// get current message map
		var _msgMap = _msgList[| i];
		if (!scr_isNumericAndExists(_msgMap, ds_type_map)) continue;
		var _selected = _msgMap[? "selected"];
		
		
		// if this message is selected, let's get its text
		if ((obj_aiControl.aiImportType == "all") || (obj_aiControl.aiImportType == "selected" && _selected) || obj_aiControl.aiImportType == "last" && _msgMap == lastAiMsg) {
			
			// get data from this message
			var _text = string(_msgMap[? "text"]);
			var _author = _msgMap[? "author"];
			var _chatID = _msgMap[? "chatID"];
			
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
					
					// and we will take the author of the message to be the participant
					_participant = string(_author);
				}
			
				// now let's split the turn into sentences, making sure to keep delimiters
				var _sentences = scr_splitSentence(_turn);
		
				// for each sentence, create a new row in the importLineGrid
				var _sentencesSize = ds_list_size(_sentences);
				for (var k = 0; k < _sentencesSize; k++) {
				
					// get current sentence, skip any blank lines
					var _currentSentence = _sentences[| k];
					if (scr_isStrOnlyWhitespace(_currentSentence) || _currentSentence == "") continue;
					
					// finally, format the sentence in tab-delimited style and add it to lineList
					var _currentSentenceFormatted = string(_participant) + "	" + string(_currentSentence) + "	" + string(_chatID);
					show_debug_message("_currentSentenceFormatted: " + string(_currentSentenceFormatted));
					ds_list_add(lineList, _currentSentenceFormatted);
				}
			}
		}
	}
	
	global.project = "import";
	return lineList;

}