function scr_createNewLayer(_layerName, _layerType, stackName = undefined, stackerType = undefined){
	
	var _layerList = undefined;
	var _layerMap = undefined;
	
	// _layerType should be "stack"/"trail"
	if (_layerType == "stack") {
		_layerList = global.nodeMap[? "stackingList"];
		_layerMap = global.stackingMap;
	}
	else if (_layerType == "trail") {
		_layerList = global.nodeMap[? "trailLayerList"];
		_layerMap = global.trailLayerMap;
	}
	
	// verify layer's data structures exist
	if (!scr_isNumericAndExists(_layerMap, ds_type_map) || !scr_isNumericAndExists(_layerList, ds_type_list)) {
		show_debug_message("scr_createNewLayer, ERROR ... _layerMap or _layerList does not exist");
		exit;
	}
	
	// create submap for this new layer and add that to the layerMap
	var _newLayerID = scr_generateRandomID();
	var _newLayerSubMap = ds_map_create();
	_newLayerSubMap[? "name"] = _layerName;
	ds_map_add_map(_layerMap, _newLayerID, _newLayerSubMap);
	
	// also add it to layerList
	scr_addToListOnce(_layerList, _newLayerID);
	
	// fields specific to stacking
	if (_layerType == "stack") {
		_newLayerSubMap[? "stackName"] = stackName;
		_newLayerSubMap[? "stacker"] = stackerType;
	}
	
	// switch active layer to this new one
	scr_changeActiveLayer(_layerType, _newLayerID);

}