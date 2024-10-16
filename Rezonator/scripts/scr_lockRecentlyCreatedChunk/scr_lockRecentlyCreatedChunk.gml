function scr_lockRecentlyCreatedChunk(){
	
	// if a chunk was recently created, let's lock that chunk
	if (is_string(obj_control.chunkRecentlyCreated) && obj_control.chunkRecentlyCreated != "") {
		var _chunkSubMap = global.nodeMap[? obj_control.chunkRecentlyCreated];
		if (scr_isNumericAndExists(_chunkSubMap, ds_type_map)) {
			_chunkSubMap[? "lock"] = true;
		}
		with (obj_control) chunkRecentlyCreated = "";
	}

}