function scr_openFileRefreshCliques() {
	
	// when opening a rez file, we need to make sure that every rezchain is in a clique
	var resonanceList = global.nodeMap[? "resonanceList"];
	var cliqueList = obj_chain.cliqueList;
	var resonanceListSize = ds_list_size(resonanceList);
	for (var i = 0; i < resonanceListSize; i++) {
		
		var currentChain = resonanceList[| i];
		var currentChainSubMap = global.nodeMap[? currentChain];
		var currentChainInClique = currentChainSubMap[? "inClique"];
		
		// if this chain is not in a clique...
		if (!is_string(currentChainInClique) || currentChainInClique == "") {
			
			// spawn a new clique & refresh it
			currentChainInClique = scr_newClique(currentChain, undefined);
			currentChainSubMap[? "inClique"] = currentChainInClique;
			scr_refreshClique(currentChainInClique);
		}
		
		// make sure that this chain's clique is in cliquelist
		if (is_string(currentChainInClique) && currentChainInClique != "") {
			scr_addToListOnce(cliqueList, currentChainInClique);
		}
	}

}