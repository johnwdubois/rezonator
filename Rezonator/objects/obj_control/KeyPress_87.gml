///@description Transcript View
if (!shortcutsEnabled || dialogueBoxActive) {
	exit;
}

//On time out until we know what to do with it
//scr_toggleTranscription();
//show_message("trnascript col: " +string(global.tokenImportTranscriptColName) + ",      dispay col: " + string(global.tokenImportDisplayTokenColName));
if( global.tokenImportTranscriptColName != undefined && global.tokenImportDisplayTokenColName != undefined){
	if( string_length(global.tokenImportTranscriptColName) > 0 &&  string_length(global.tokenImportDisplayTokenColName) > 0){
		var transcriptCol = ds_list_find_index(global.tokenImportColNameList, global.tokenImportTranscriptColName);
		var defaultCol = ds_list_find_index(global.tokenImportColNameList, global.tokenImportDisplayTokenColName);
		
		if(wordTokenView){
			var inDisplayCol = ds_list_find_index(obj_control.currentDisplayTokenColsList, defaultCol);
			scr_toggleTranscriptionMulti(global.tokenImportGrid, defaultCol);
		}
		else{
			var inDisplayCol = ds_list_find_index(obj_control.currentDisplayTokenColsList, transcriptCol);
			scr_toggleTranscriptionMulti(global.tokenImportGrid, transcriptCol);
		}
			
		if(inDisplayCol >= 0){
			//if (inDisplayCol == 0) {
				wordView = inDisplayCol+2;
			//}
		}
		if(wordTokenView && global.tokenImportDisplayTokenColName == "~text"){
			wordView = 2;
		}
		
		wordTokenView = !wordTokenView;
	}
}