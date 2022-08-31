function scr_refreshClique(cliqueID){
	
	show_debug_message("scr_refreshClique: " + string(cliqueID));
	var cliqueSubMap = global.cliqueMap[? cliqueID];	
	var cliqueChainList = cliqueSubMap[? "chainList"];
	if (ds_list_size(cliqueChainList) >= 1) {
		
		// clear everything but first chain in clique
		var cliqueFirstChain = cliqueChainList[| 0];
		ds_list_clear(cliqueChainList);
		ds_list_add(cliqueChainList, cliqueFirstChain);
		
		// clear unit list for clique
		var cliqueUnitList = cliqueSubMap[? "unitList"];
		ds_list_clear(cliqueUnitList);
		
		scr_cliqueCheckChain(cliqueFirstChain, cliqueChainList, cliqueUnitList);
	}

}