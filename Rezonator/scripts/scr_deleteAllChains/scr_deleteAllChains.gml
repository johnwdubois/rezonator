

function scr_deleteAllChains(chainList){
	
	show_debug_message("scr_deleteAllChains");
	if (!scr_isNumericAndExists(chainList, ds_type_list)) {
		show_debug_message("chainList is invalid");
		exit;
	}
	
	while (ds_list_size(chainList) > 0) {
		var currentChainID = chainList[| 0];
		scr_deleteChain(currentChainID);
		scr_deleteFromList(chainList, currentChainID); // safety check to eliminate infinite loop
	}
}