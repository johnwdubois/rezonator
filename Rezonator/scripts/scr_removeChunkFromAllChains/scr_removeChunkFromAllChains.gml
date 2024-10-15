function scr_removeChunkFromAllChains(_chunkID, _chainList){
	
	show_debug_message("scr_removeChunkFromAllChains, _chunkID: " + string(_chunkID));
	
	// get this chunk's inChainsList
	var _chunkSubMap = global.nodeMap[? _chunkID];
	var _inChainsList = _chunkSubMap[? "inChainsList"];
	
	// remove chunk from all chains in chainList, regardless of what layer the chains are on
	var _chainListSize = ds_list_size(_chainList);
	for (var i = 0; i < _chainListSize; i++) {
		var _chainID = _chainList[| i];
		obj_chain.currentFocusedChainID = _chainID;
		scr_refocusChainEntry(_chunkID);
		scr_deleteFromChain(true);
		scr_deleteFromList(_inChainsList, _chainID);
	}
	
}