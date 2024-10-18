function scr_getInactiveChainsThatIDIsIn(_tokenOrChunkID, _chainType){
	
	var _chainList = undefined;
	if (_chainType == "resonance") _chainList = global.nodeMap[? "resonanceList"];
	else if (_chainType == "trail") _chainList = global.nodeMap[? "trailList"];
	
	var _inactiveChains = [];
	var _chainListSize = ds_list_size(_chainList);
	for (var i = 0; i < _chainListSize; i++) {
		var _chainID = _chainList[| i];
		var _chainSubMap = global.nodeMap[? _chainID];
		var _chainLayer = _chainSubMap[? "layer"];
		show_debug_message("scr_getInactiveChainsThatIDIsIn _chainID: " + string(_chainID) + ", _chainLayer: " + string(_chainLayer));
			
		// if this chain is in an inactive layer, let's check if the token/chunk is in the chain
		if ((_chainType == "resonance" && _chainLayer != obj_control.activeResonanceLayer)
		|| (_chainType == "trail" && _chainLayer != obj_control.activeTrailLayer)) {
				
			var _entryList = _chainSubMap[? "setIDList"];
			var _entryListSize = ds_list_size(_entryList);
			for (var j = 0; j < _entryListSize; j++) {
				var _entryID = _entryList[| j];
				var _entrySubMap = global.nodeMap[? _entryID];
				var _entryTokenID = _entrySubMap[? "token"];
				if (_entryTokenID == _tokenOrChunkID) {
					show_debug_message("adding");
					array_push(_inactiveChains, _chainID);
				}
			}
		}
	}
	return _inactiveChains;
}