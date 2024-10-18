function scr_findDefaultLayer(_layerMap){
	
	// find the "default" layer so if we find chains that do not have a layer, we can assign one
	// basically, find the first item in layerMap that is not the "type" field
	var _defaultLayer = "";
	var _layerMapKey = ds_map_find_first(_layerMap);
	var _layerMapSize = ds_map_size(_layerMap);
	for (var i = 0; i < _layerMapSize; i++) {
		if (_layerMapKey != "type") _defaultLayer = _layerMapKey;
		_layerMapKey = ds_map_find_next(_layerMap, _layerMapKey);
	}
	return _defaultLayer;

}