///@description End Chain Use
// End chain adding/use
if(!obj_control.dialogueBoxActive){
	//if(obj_control.stackShowActive and (currentFocusedChainIndex > -1)) {
	//	var currentChainWordList = ds_grid_get(currentChainGrid, chainGrid_colWordIDList, currentFocusedChainIndex);
	//	var correct = false;
	//	// Compare the focused list with the preset list
	//	if(ds_list_size(currentChainWordList) == ds_list_size(arbitraryList)) {
	//		correct = true;
	//		for(var goldStandardListLoop = 0; goldStandardListLoop < ds_list_size(arbitraryList); goldStandardListLoop++) {
	//			var playerWord = ds_list_find_value(currentChainWordList, goldStandardListLoop);
	//			var goldWord = ds_list_find_value(arbitraryList, goldStandardListLoop);
	//			if(playerWord != goldWord) {
	//				correct = false;
	//				continue;
	//			}
	//		}
	//	}
	//	if(correct) {
	//		show_message("correct");
	//	}
	//	else {
	//		show_message("incorrect");
	//	}
	//}
	
	scr_chainDeselect();

	scr_refreshVizLinkGrid();
}