function scr_removeTokenFromAllChains(_tokenID, _chainList){
	
	show_debug_message("scr_removeTokenFromAllChains, _tokenID: " + string(_tokenID));
	
	// get this token's inChainsList
	var _tokenSubMap = global.nodeMap[? _tokenID];
	var _inChainsList = _tokenSubMap[? "inChainsList"];
	
	// remove token from all chains in chainList, regardless of what layer the chains are on
	var _chainListSize = ds_list_size(_chainList);
	for (var i = 0; i < _chainListSize; i++) {
		var _chainID = _chainList[| i];
		obj_chain.currentFocusedChainID = _chainID;
		scr_refocusChainEntry(_tokenID);
		scr_deleteFromChain(true);
		scr_deleteFromList(_inChainsList, _chainID);
	}
	
}