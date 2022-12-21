function scr_cliqueGeneration(){

	var encounteredTokenListSize = ds_list_size(obj_chain.encounteredTokenList);

	repeat(encounteredTokenListSize){
		var tokenListID = obj_chain.encounteredTokenList[| 0];
		var tokenID = (scr_isChunk(tokenListID)) ? scr_getFirstWordOfChunk(tokenListID): tokenListID;
		var tokenSubMap = global.nodeMap[? tokenID];
		var unitID = tokenSubMap[? "unit"];
	
		if(ds_list_find_index(obj_chain.traversedUnitList, unitID) == -1){
		
			var unitSubMap =  global.nodeMap[? unitID];
			var entryList = unitSubMap[? "entryList"];
			
			var entryListSize = ds_list_size(entryList);

			for(var i = 0; i < entryListSize; i ++){
				var entryID = entryList[| i];
				var entrySubMap = global.nodeMap[? entryID];
				var tokenID = entrySubMap[? "token"];
				var tokenSubMap = global.nodeMap[? tokenID];
				var inChainsList = tokenSubMap[? "inChainsList"];
				
				var inChainsListSize = ds_list_size(inChainsList);
			
				for(var j = 0; j < inChainsListSize; j ++){
					var currentChainID = inChainsList[|j];
					if(ds_list_find_index(global.nodeMap[? "resonanceList"], currentChainID) >= 0){
						if(ds_list_find_index(obj_chain.encounteredUnitList, unitID) == -1){
							scr_addToListOnce(obj_chain.encounteredChainList, currentChainID);
						}
					}
				}
				
				var inChunkList = tokenSubMap[? "inChunkList"];
				var inChunkListSize = ds_list_size(inChunkList);
			
				for(var j = 0; j < inChunkListSize; j ++){
					var chunkID =  inChunkList[|j];
					if (scr_getFirstWordOfChunk(chunkID) == tokenID) {
						var chunkSubMap = global.nodeMap[? chunkID];
						var chunkInChainsList = chunkSubMap[? "inChainsList"];
						var chunkInChainsListSize = ds_list_size(chunkInChainsList);
						for(var k = 0; k < chunkInChainsListSize; k ++){
							var currentChainID = chunkInChainsList[|k];
							if(ds_list_find_index(global.nodeMap[? "resonanceList"], currentChainID) >= 0){
								if(ds_list_find_index(obj_chain.encounteredUnitList, unitID) == -1){
									scr_addToListOnce(obj_chain.encounteredChainList, currentChainID);
								}
							}
						}
					}
				}
				
			}
		
			ds_list_delete(obj_chain.encounteredTokenList, 0);
			scr_addToListOnce(obj_chain.traversedUnitList,unitID);
		
		}
		else{
			ds_list_delete(obj_chain.encounteredTokenList, 0);
		}
	}

	var encounteredChainListSize = ds_list_size(obj_chain.encounteredChainList);
	var i = 0;
	repeat(encounteredChainListSize){
		var currentChainSubMap = global.nodeMap[? obj_chain.encounteredChainList[|i]];
		var setList = currentChainSubMap[?"setIDList"];
		var setListSize = ds_list_size(setList);
		for(var j = 0; j < setListSize; j++){
			var rezNodeID = setList[|j];
			var rezNode = global.nodeMap[? rezNodeID];

			var tokenID = rezNode[? "token"];
			if(scr_isChunk(tokenID)){
				var tokenSubMap = global.nodeMap[? scr_getFirstWordOfChunk(tokenID)];
			}
			else{
				var tokenSubMap = global.nodeMap[? tokenID];
			}
			if (!scr_isNumericAndExists(tokenSubMap, ds_type_map)) continue;
			var unitID = tokenSubMap[? "unit"];
			if(ds_list_find_index(obj_chain.traversedUnitList, unitID) == -1){
				scr_addToListOnce(obj_chain.encounteredTokenList,tokenID);
			}
		}
	
		i++
	}

	if(ds_list_size(obj_chain.encounteredTokenList) > 0){
		scr_cliqueGeneration();
	}
	else{
		if(ds_list_size(obj_chain.encounteredChainList) > 0){
			var cliqueID = scr_generateRandomHex();
			var cliqueName = "Clique " + string(obj_chain.cliqueCount);
			var cliqueChainList = ds_list_create();
			var cliqueUnitList = ds_list_create();
	
			ds_list_copy(cliqueChainList, obj_chain.encounteredChainList);
			ds_list_copy(cliqueUnitList, obj_chain.traversedUnitList);
	
			var cliqueSubMap = ds_map_create();
	
			ds_map_add_list(cliqueSubMap, "chainList", cliqueChainList);
			ds_map_add_list(cliqueSubMap, "unitList", cliqueUnitList);
			ds_map_add(cliqueSubMap, "name", cliqueName);
	
			ds_map_add_map(global.cliqueMap, cliqueID, cliqueSubMap);
	
			var traversedUnitListSize = ds_list_size(obj_chain.traversedUnitList);
			for(var i = 0 ; i < traversedUnitListSize; i ++){
				scr_addToListOnce(obj_chain.encounteredUnitList,obj_chain.traversedUnitList[|i]);
			}
		
			scr_addToListOnce(obj_chain.cliqueList, cliqueID);
		
			ds_list_clear(obj_chain.traversedUnitList);
			ds_list_clear(obj_chain.encounteredChainList);
			obj_chain.cliqueCount++;
		}
	}
}