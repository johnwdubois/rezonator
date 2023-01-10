function scr_updateDisplayTokenList(field){
	
	// make sure this is a valid field
	show_debug_message("scr_updateDisplayTokenList, field: " + string(field));	
	if (!is_string(field) || field == "") exit;
	
	// get the wordform list
	var wordFormList = obj_control.displayTokenList;
	
	// if this field is already in the list, we don't care about it
	if (ds_list_find_index(wordFormList, field) >= 0) {
		show_debug_message("scr_updateDisplayTokenList, already exists in list");
		exit;
	}
	
	// get text & transcript fields
	var textField = "";
	if (is_string(global.tokenImportDisplayTokenColName) && global.tokenImportDisplayTokenColName != "") textField = global.tokenImportDisplayTokenColName;
	var transcriptField = "";
	if (is_string(global.tokenImportTranscriptColName) && global.tokenImportTranscriptColName != "") transcriptField = global.tokenImportTranscriptColName;
	show_debug_message("scr_updateDisplayTokenList, textField: " + string(textField) + ", transcriptField: " + string(transcriptField));
	
	// if this field is the text or transcript field, it should already be in the list
	if (field != textField && field != transcriptField) {
		
		// add this field to the back of the list
		scr_addToListOnce(wordFormList, field);
		
		// if there are 5 or more things in the list, let's delete a field that is not text, transcript,
		// or the newly added field
		var wordFormListSize = ds_list_size(wordFormList);
		if (wordFormListSize >= 5) {
			for (var i = 0; i < wordFormListSize; i++) {
				var currentField = wordFormList[| i];
				if (currentField != textField && currentField != transcriptField && currentField != field) {
					ds_list_delete(wordFormList, i);
					break;
				}
			}
		}
	}
	
	// force the text and transcript fields to be in the list, if they exist
	if (is_string(textField) && textField != "") scr_addToListOnce(wordFormList, textField);
	if (is_string(transcriptField) && transcriptField != "") scr_addToListOnce(wordFormList, transcriptField);

	show_debug_message("scr_updateDisplayTokenList, wordFormList: " + scr_getStringOfList(wordFormList));
	
}