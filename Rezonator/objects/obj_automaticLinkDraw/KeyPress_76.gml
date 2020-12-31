/// @description Sequential Link Generation
// You can write your code in this editor
//show_message("here");
/*
if(obj_control.showDevVars) {
	if(wordIDCounter < ds_grid_height(obj_control.wordGrid) - 1) {
		with(obj_chain) {
			scr_wordClicked(obj_automaticLinkDraw.wordIDCounter++, obj_automaticLinkDraw.unitIDCounter);
		}
		if(ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colUnitID, wordIDCounter-1) != unitIDCounter) {
			unitIDCounter++;
		}
	}
}
