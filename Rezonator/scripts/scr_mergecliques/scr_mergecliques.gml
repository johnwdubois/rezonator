function scr_mergeCliques(clique1, clique2){


	// first, let's determine which clique should "eat" the other: cliqueA should eat cliqueB
	scr_setCliqueAutoTags(clique1);
	scr_setCliqueAutoTags(clique2);
	var clique1SubMap = global.cliqueMap[? clique1];
	var clique2SubMap = global.cliqueMap[? clique2];
	var clique1LinkCount = clique1SubMap[? "linkCount"];
	var clique2LinkCount = clique2SubMap[? "linkCount"];
	
	show_debug_message("scr_mergeCliques, clique1: " + string(clique1) + ", clique1LinkCount: " + string(clique1LinkCount) + ", clique2: " + string(clique2) + ", clique2LinkCount: " + string(clique2LinkCount));
	
	var cliqueA = "";
	var cliqueB = "";
	if (clique1LinkCount > clique2LinkCount) {
		// clique1 is larger
		cliqueA = clique1;
		cliqueB = clique2;
	}
	else if (clique2LinkCount > clique1LinkCount) {
		// clique2 is larger
		cliqueA = clique2;
		cliqueB = clique1;
	}
	else {
		// clique1 and clique2 are equal size
		var clique1ChainList = clique1SubMap[? "chainList"];
		
		var clique1ChainListSize = ds_list_size(clique1ChainList);
		for (var i = 0 ; i < clique1ChainListSize; i++) {
			var currentClique1Chain = clique1ChainList[| i];
			if (currentClique1Chain == obj_chain.currentFocusedChainID) {
				cliqueA = clique1;
				cliqueB = clique2;
				break;
			}
		}
		if (cliqueA == "" || cliqueB == "") {
			cliqueA = clique2;
			cliqueB = clique1;
		}
	}
	
	
	// get unitlist & chainlist from each clique
	var cliqueASubMap = global.cliqueMap[? cliqueA];
	var cliqueBSubMap = global.cliqueMap[? cliqueB];
	var cliqueAUnitList = cliqueASubMap[? "unitList"];
	var cliqueAChainList = cliqueASubMap[? "chainList"];
	var cliqueBUnitList = cliqueBSubMap[? "unitList"];
	var cliqueBChainList = cliqueBSubMap[? "chainList"];
	
	// every unit that points to cliqueB should point to cliqueA, and also put every unit in cliqueB into cliqueA's chainlist
	var cliqueBUnitListSize = ds_list_size(cliqueBUnitList);
	for (var i = 0; i < cliqueBUnitListSize; i++) {
		var currentUnit = cliqueBUnitList[| i];
		var currentUnitSubMap = global.nodeMap[? currentUnit];
		if (scr_isNumericAndExists(currentUnitSubMap, ds_type_map)) {
			currentUnitSubMap[? "inClique"] = cliqueA;
			scr_addToListOnce(cliqueAUnitList, currentUnit);
		}
	}
	
	// every chain that points to cliqueB should point to cliqueA, and also put every chain in cliqueB into cliqueA's chainlist
	var cliqueBChainListSize = ds_list_size(cliqueBChainList);
	for (var i = 0; i < cliqueBChainListSize; i++) {
		var currentChain = cliqueBChainList[| i];
		var currentChainSubMap = global.nodeMap[? currentChain];
		if (scr_isNumericAndExists(currentChainSubMap, ds_type_map)) {
			currentChainSubMap[? "inClique"] = cliqueA;
			scr_addToListOnce(cliqueAChainList, currentChain);
		}
	}
	
	// we don't need cliqueB data structures anymore, let's get rid of them
	ds_list_destroy(cliqueBUnitList);
	ds_list_destroy(cliqueBChainList);
	ds_map_destroy(cliqueBSubMap);
	ds_map_delete(global.cliqueMap, cliqueB);
	scr_deleteFromList(obj_chain.cliqueList, cliqueB);
	
	scr_sortCliqueChainList(cliqueA);
	scr_setCliqueAutoTags(cliqueA);

}