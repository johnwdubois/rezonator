function scr_refreshCliques2(){
	
	
	var cliqueUnitList = ds_list_create();
	var cliqueChainList = ds_list_create();
	scr_addToListOnce(cliqueChainList, obj_chain.currentFocusedChainID);
	
	show_debug_message("scr_refreshCliques2 START");
	scr_cliqueCheckChain(obj_chain.currentFocusedChainID, cliqueChainList, cliqueUnitList);
	show_debug_message("scr_refreshCliques2 END, cliqueChainList: " + scr_getStringOfList(cliqueChainList));
	show_debug_message("scr_refreshCliques2 END, cliqueUnitList: " + scr_getStringOfList(cliqueUnitList));

}