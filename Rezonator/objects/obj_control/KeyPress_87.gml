///@description Transcript View
if (!shortcutsEnabled || dialogueBoxActive) {
	exit;
}

if( global.tokenImportTranscriptColName != undefined && global.tokenImportDisplayTokenColName != undefined){
	if( string_length(global.tokenImportTranscriptColName) > 0 &&  string_length(global.tokenImportDisplayTokenColName) > 0){
		var transcriptCol = ds_list_find_index(global.tokenImportColNameList, global.tokenImportTranscriptColName);
		var defaultCol = ds_list_find_index(global.tokenImportColNameList, global.tokenImportDisplayTokenColName);
		
		if(wordTokenView){
			scr_toggleTranscriptionMulti(global.tokenImportGrid, defaultCol);
		}
		else{
			scr_toggleTranscriptionMulti(global.tokenImportGrid, transcriptCol);
		}
			

		
		wordTokenView = !wordTokenView;
	}
}