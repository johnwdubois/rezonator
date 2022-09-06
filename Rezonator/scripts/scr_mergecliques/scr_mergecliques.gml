function scr_mergeCliques(cliqueA, cliqueB){
	
	show_debug_message("scr_mergeCliques, cliqueA: " + string(cliqueA) + ", cliqueB: " + string(cliqueB));
	
	// cliqueA will eat cliqueB
	
	// get all submaps and lists for both cliques
	var cliqueASubMap = global.cliqueMap[? cliqueA];
	var cliqueAUnitList = cliqueASubMap[? "unitList"];
	var cliqueAChainList = cliqueASubMap[? "chainList"];
	var cliqueBSubMap = global.cliqueMap[? cliqueB];
	var cliqueBUnitList = cliqueBSubMap[? "unitList"];
	var cliqueBChainList = cliqueBSubMap[? "chainList"];
	
	// every unit that points to cliqueB should point to cliqueA, and also put every unit in cliqueB into cliqueA's chainlist
	var cliqueBUnitListSize = ds_list_size(cliqueBUnitList);
	for (var i = 0; i < cliqueBUnitListSize; i++) {
		var currentUnit = cliqueBUnitList[| i];
		var currentUnitSubMap = global.nodeMap[? currentUnit];
		currentUnitSubMap[? "inClique"] = cliqueA;
		scr_addToListOnce(cliqueAUnitList, currentUnit);
	}
	
	// every chain that points to cliqueB should point to cliqueA, and also put every chain in cliqueB into cliqueA's chainlist
	var cliqueBChainListSize = ds_list_size(cliqueBChainList);
	for (var i = 0; i < cliqueBChainListSize; i++) {
		var currentChain = cliqueBChainList[| i];
		var currentChainSubMap = global.nodeMap[? currentChain];
		currentChainSubMap[? "inClique"] = cliqueA;
		scr_addToListOnce(cliqueAChainList, currentChain);
	}
	
	// we don't need cliqueB data structures anymore, let's get rid of them
	ds_list_destroy(cliqueBUnitList);
	ds_list_destroy(cliqueBChainList);
	ds_map_destroy(cliqueBSubMap);
	ds_map_delete(global.cliqueMap, cliqueB);
	scr_deleteFromList(obj_chain.cliqueList, cliqueB);
	
	scr_sortCliqueChainList(cliqueA);
	

}