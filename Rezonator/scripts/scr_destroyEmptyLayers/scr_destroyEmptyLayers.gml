function scr_destroyEmptyLayers(_layerType){
	
	// while there are 2+ layers and there exists a layer with no chains, kill off the layer with no chains
	var _layerMap = undefined;
	var _layerList = undefined;
	var _chainList = undefined;
	var _layerFieldName = "";
	if (_layerType == "resonance") {
		_layerList = global.nodeMap[? "resonanceLayerList"];
		_chainList = global.nodeMap[? "resonanceList"];
		_layerMap = global.resonanceLayerMap;
		_layerFieldName = "layer";
	}
	else if (_layerType == "trail") {
		_layerList = global.nodeMap[? "trailLayerList"];
		_chainList = global.nodeMap[? "trailList"];
		_layerMap = global.trailLayerMap;
		_layerFieldName = "layer";
	}
	else if (_layerType == "stack") {
		_layerList = global.nodeMap[? "stackingList"];
		_chainList = global.nodeMap[? "stackList"];
		_layerMap = global.stackingMap;
		_layerFieldName = "stacking";
	}
	
	// function to get the amount of chains that belong to a layer
	var _GetChainCountForLayer = function(_layerID, _chainList, _layerFieldName) {
		var _chainCount = 0;
		var _chainListSize = ds_list_size(_chainList);
		for (var i = 0; i < _chainListSize; i++) {
			var _chainID = _chainList[| i];
			var _chainSubMap = global.nodeMap[? _chainID];
			var _chainLayer = _chainSubMap[? _layerFieldName];
			if (_chainLayer == _layerID) _chainCount++;
		}
		return _chainCount;
	}
	
	// first, let's check if any of the layers has any chains that belong to it
	var _layerWithChainsExists = false;
	var _layerListSize = ds_list_size(_layerList);
	for (var i = 0; i < _layerListSize; i++) {
		var _layerID = _layerList[| i];
		var _layerChainCount = _GetChainCountForLayer(_layerID, _chainList, _layerFieldName);		
		if (_layerChainCount >= 1) {
			_layerWithChainsExists = true;
			break;
		}
	}
		
	// find all empty layers
	var _layersWithoutChains = [];
	for (var i = 0; i < _layerListSize; i++) {
		var _layerID = _layerList[| i];
		var _layerChainCount = _GetChainCountForLayer(_layerID, _chainList, _layerFieldName);
		if (_layerChainCount < 1) array_push(_layersWithoutChains, _layerID);
	}
	
	// destroy all empty layers
	var _layersWithoutChainsLen = array_length(_layersWithoutChains);
	for (var i = 0; i < _layersWithoutChainsLen; i++) {
		
		// if this is the first layer with no chains, but there are no layers with chains, then we will keep this one
		if (i == 0 && !_layerWithChainsExists) continue;
		
		var _layerID = _layersWithoutChains[i];
		var _layerSubMap = _layerMap[? _layerID];
			
		// destroy and remove references to current layer
		ds_map_destroy(_layerSubMap);
		ds_map_delete(_layerMap, _layerID);
		scr_deleteFromList(_layerList, _layerID);
	}

}