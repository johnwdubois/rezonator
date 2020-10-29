///@description Transcript View
if (!shortcutsEnabled || dialogueBoxActive) {
	exit;
}

/*
if (keyboard_check(vk_control)) {
	
	if (showDevVars) {
		if (!instance_exists(obj_network)) {
			instance_create_layer(0, 0, "InstancesDialogue", obj_network);
		}
		with (obj_network) {
			scr_sendGridToServer(obj_control.wordGrid);
		}
	}
	exit;
}
*/

//On time out until we know what to do with it
//scr_toggleTranscription();

if( global.tokenImportTranscriptColName != undefined && global.tokenImportDisplayTokenColName != undefined){
	if( string_length(global.tokenImportTranscriptColName) > 0 &&  string_length(global.tokenImportDisplayTokenColName) > 0){
		var transcriptCol = ds_list_find_index(global.tokenImportColNameList, global.tokenImportTranscriptColName);
		var defaultCol = ds_list_find_index(global.tokenImportColNameList, global.tokenImportDisplayTokenColName);
		if(wordTokenView){
			scr_toggleTranscriptionMulti(global.tokenImportGrid, defaultCol);
			var inDisplayCol = ds_list_find_index(obj_control.currentDisplayTokenColsList, defaultCol);
			if(inDisplayCol >= 0){
				if(inDisplayCol == 0){
					wordView = inDisplayCol+2;
				}
				else{
					wordView = inDisplayCol+3;
				}
			}
			wordTokenView =  false;
		}
		else{
			scr_toggleTranscriptionMulti(global.tokenImportGrid, transcriptCol);
			
			var inDisplayCol = ds_list_find_index(obj_control.currentDisplayTokenColsList, transcriptCol);
			if(inDisplayCol >= 0){
				if(inDisplayCol == 0){
					wordView = inDisplayCol+2;
				}
				else{
					wordView = inDisplayCol+3;
				}
			}
			wordTokenView =  true;
		}

	}
}