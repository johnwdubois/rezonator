function scr_refreshCliqueDelete(cliqueID, deletedChainID, deletedEntryID){
	
	// we need to check if the clique can still reach the deletedChainID
	
	var deleteClique = false;
	show_debug_message("scr_refreshCliqueDelete: " + string(cliqueID) + ", deletedChainID: " + string(deletedChainID));
	var cliqueSubMap = global.cliqueMap[? cliqueID];	
	var cliqueChainList = cliqueSubMap[? "chainList"];
	
	// we copy the chainlist before we do any deleting to see if we can still reach every chain
	var cliqueChainListCopy = ds_list_create();
	ds_list_copy(cliqueChainListCopy, cliqueChainList);
	
	
	
	var cliqueChainListSize = ds_list_size(cliqueChainList);
	show_debug_message("scr_refreshCliqueDelete, cliqueChainListSize: " + string(cliqueChainListSize));
	if (cliqueChainListSize >= 2) {
		// clear everything but first chain in clique
		var cliqueFirstChain = "";
		for (var i = 0; i < cliqueChainListSize; i++) {
			if (cliqueChainList[| i] != deletedChainID) {
				cliqueFirstChain = cliqueChainList[| i];
				break;
			}
		}
		ds_list_clear(cliqueChainList);
		ds_list_add(cliqueChainList, cliqueFirstChain);
		
		// clear unit list for clique
		var cliqueUnitList = cliqueSubMap[? "unitList"];
		ds_list_clear(cliqueUnitList);
		
		scr_cliqueCheckChain(cliqueFirstChain, cliqueChainList, cliqueUnitList);
	}
	else if (cliqueChainListSize == 1) {
		// in this case, the only chain left in the clique is the chain deleted from, so we should check if that chain still has any entries (other than the entry being deleted)
		var deletedChainSubMap = global.nodeMap[? deletedChainID];
		var deletedChainSetIDList = deletedChainSubMap[? "setIDList"];
		var deletedChainSetIDListSize = ds_list_size(deletedChainSetIDList);
		show_debug_message("deletedChainSetIDListSize: " + string(deletedChainSetIDListSize));
		if (deletedChainSetIDListSize < 1) {
			deleteClique = true;
		}
		else if (deletedChainSetIDListSize == 1) {
			if (deletedChainSetIDList[| 0] == deletedEntryID) {
				deleteClique = true;
			}
		}
	}
	else {
		deleteClique = true;
	}
	
	
	
	// delete clique if we need to
	if (deleteClique) {
		scr_mapDeepDestroy(cliqueSubMap);
		ds_map_delete(global.cliqueMap, cliqueID);
		scr_deleteFromList(obj_chain.cliqueList, cliqueID);
	}
	else {
		
		scr_refreshClique(cliqueID);
		scr_sortCliqueChainList(cliqueID);
		
		// collect any chains that were originally in the clique, but are not there anymore
		var chainsKickedOutList = ds_list_create();
		var cliqueChainListCopySize = ds_list_size(cliqueChainListCopy);
		for (var i = 0; i < cliqueChainListCopySize; i++) {
			var currentChain = cliqueChainListCopy[| i];
			var currentChainSubMap = global.nodeMap[? currentChain];
			var currentChainSetIDList = currentChainSubMap[? "setIDList"];
			
			// if this chain is empty, or only contains the deleted entry, we shouldn't put it into a new clique
			if (ds_list_size(currentChainSetIDList) < 1) continue;
			else if (ds_list_size(currentChainSetIDList) == 1) {
				if (currentChainSetIDList[| 0] == deletedEntryID) continue;
			}
			
			// otherwise, if this chain does not appear in our clique's chainlist, we'll keep track of it
			if (ds_list_find_index(cliqueChainList, currentChain) == -1) {
				scr_addToListOnce(chainsKickedOutList, currentChain);
			}
		}
		
		// if there was at least 1 chain kicked out, create a new clique
		var chainsKickedOutListSize = ds_list_size(chainsKickedOutList);
		if (chainsKickedOutListSize >= 1) {
			var firstChainKickedOut = chainsKickedOutList[| 0];
			var newCliqueID = scr_newClique(firstChainKickedOut, undefined);
			scr_refreshClique(newCliqueID);
		}
		ds_list_destroy(chainsKickedOutList);
	}
	
	scr_setCliqueAutoTags(cliqueID);

}