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
		
		// make sure each unit and chain in this clique is pointing to it
		var cliqueChainListSize = ds_list_size(cliqueChainList);
		for (var i = 0; i < cliqueChainListSize; i++) {
			var currentChain = cliqueChainList[| i];
			var currentChainSubMap = global.nodeMap[? currentChain];
			currentChainSubMap[? "inClique"] = cliqueID;
		}
		var cliqueUnitListSize = ds_list_size(cliqueUnitList);
		for (var i = 0; i < cliqueUnitListSize; i++) {
			var currentUnit = cliqueUnitList[| i];
			var currentUnitSubMap = global.nodeMap[? currentUnit];
			currentUnitSubMap[? "inClique"] = cliqueID;
		}
	}

}