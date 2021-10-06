function scr_setSpecialFieldsVariables() {
	show_debug_message("scr_setSpecialFieldsVariables");

	// for ELAN (tab delimited) the UnitStart and UnitEnd columns are key fields
	var unitStartRow = -1;
	var unitEndRow = -1;
	if (global.importType == global.importType_TabDelimited) {
		unitStartRow = ds_grid_value_y(global.tagInfoGrid, global.tagInfoGrid_colKey, 0, global.tagInfoGrid_colKey, ds_grid_height(global.tagInfoGrid), "unit_start");
		unitEndRow = ds_grid_value_y(global.tagInfoGrid, global.tagInfoGrid_colKey, 0, global.tagInfoGrid_colKey, ds_grid_height(global.tagInfoGrid), "unit_end");
	}
	else {
		unitStartRow = ds_grid_value_y(global.tagInfoGrid, global.tagInfoGrid_colSpecialFields, 0, global.tagInfoGrid_colSpecialFields, ds_grid_height(global.tagInfoGrid), "unit_start");
		unitEndRow = ds_grid_value_y(global.tagInfoGrid, global.tagInfoGrid_colSpecialFields, 0, global.tagInfoGrid_colSpecialFields, ds_grid_height(global.tagInfoGrid), "unit_end");
	}
	if (unitStartRow >= 0) global.unitImportUnitStartColName = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colMarker, unitStartRow);
	if (unitEndRow >= 0) global.unitImportUnitEndColName = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colMarker, unitEndRow);
	


	var unitDelimiterRow = ds_grid_value_y(global.tagInfoGrid, global.tagInfoGrid_colKey, 0, global.tagInfoGrid_colKey, ds_grid_height(global.tagInfoGrid), "unit_delim");
	global.unitDelimField = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colMarker, unitDelimiterRow);

	var turnDelimiterRow = ds_grid_value_y(global.tagInfoGrid, global.tagInfoGrid_colSpecialFields, 0, global.tagInfoGrid_colSpecialFields, ds_grid_height(global.tagInfoGrid), "turn_delim");
	global.unitImportTurnDelimColName = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colMarker, turnDelimiterRow);
	
	var wordDelimiterRow = ds_grid_value_y(global.tagInfoGrid, global.tagInfoGrid_colKey, 0, global.tagInfoGrid_colKey, ds_grid_height(global.tagInfoGrid), "option_word-delimiter");
	if (wordDelimiterRow == -1) {
		wordDelimiterRow = ds_grid_value_y(global.tagInfoGrid, global.tagInfoGrid_colLevel, 0, global.tagInfoGrid_colLevel, ds_grid_height(global.tagInfoGrid), global.levelWord);
	}
	global.wordDelimField = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colMarker, wordDelimiterRow);

	var translationRow = ds_grid_value_y(global.tagInfoGrid, global.tagInfoGrid_colSpecialFields, 0, global.tagInfoGrid_colSpecialFields, ds_grid_height(global.tagInfoGrid), "option_translation");
	if(ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colMarker, translationRow) != undefined){
		scr_addToListOnce(global.translationList, ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colMarker, translationRow));
		global.currentTranslation = global.translationList[|0];
	}
	
	var speakerRow = ds_grid_value_y(global.tagInfoGrid, global.tagInfoGrid_colSpecialFields, 0, global.tagInfoGrid_colSpecialFields, ds_grid_height(global.tagInfoGrid), "participant");
	global.unitImportSpeakerColName = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colMarker, speakerRow);
	global.participantField = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colMarker, speakerRow);

	var transcriptionRow = ds_grid_value_y(global.tagInfoGrid, global.tagInfoGrid_colSpecialFields, 0, global.tagInfoGrid_colSpecialFields, ds_grid_height(global.tagInfoGrid), "msg_transcript");
	global.tokenImportTranscriptColName = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colMarker, transcriptionRow);
	
	var displayTokenRow = ds_grid_value_y(global.tagInfoGrid, global.tagInfoGrid_colKey, 0, global.tagInfoGrid_colKey, ds_grid_height(global.tagInfoGrid), "option_display-token");
	global.tokenImportDisplayTokenColName = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colMarker, displayTokenRow);
	global.displayTokenField = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colMarker, displayTokenRow);
	
	show_debug_message("scr_setSpecialFieldsVariables ... displayTokenField: " + string(global.displayTokenField));
	show_debug_message("scr_setSpecialFieldsVariables ... participantField: " + string(global.participantField));


}
