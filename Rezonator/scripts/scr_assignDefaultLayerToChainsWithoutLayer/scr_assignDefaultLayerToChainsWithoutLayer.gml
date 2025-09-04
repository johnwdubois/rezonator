function scr_assignDefaultLayerToChainsWithoutLayer(_chainType){
	
	var _layerMap = undefined;
	var _chainList = undefined;
	if (_chainType == "resonance") {
		_chainList = global.nodeMap[? "resonanceList"];
		_layerMap = global.resonanceLayerMap;
	}
	else if (_chainType == "trail") {
		_chainList = global.nodeMap[? "trailList"];
		_layerMap = global.trailLayerMap;
	}
	else if (_chainType == "stack") {
		_chainList = global.nodeMap[? "stackList"];
		_layerMap = global.stackingMap;
	}
	else if (_chainType == "tree") {
		_chainList = global.nodeMap[? "treeList"];
		_layerMap = global.stackingMap;
	}
	
	var _mainMap = _chainType == "tree" ? global.treeMap : global.nodeMap;
	
	var _defaultLayer = scr_findDefaultLayer(_layerMap);
	
	var _chainListSize = ds_list_size(_chainList);
	for (var i = 0; i < _chainListSize; i++) {
		var _chainID = _chainList[| i];
		var _chainSubMap = _mainMap[? _chainID];
		if (!scr_isNumericAndExists(_chainSubMap, ds_type_map)) continue;
		var _layerKey = _chainType == "stack" ? "stacking" : "layer";
		var _chainLayer = _chainSubMap[? _layerKey];
		if (!is_string(_chainLayer) || _chainLayer == "") {
			_chainSubMap[? _layerKey] = _defaultLayer;
		}
	}

}