function scr_lockChunks(lock) {
	
	// get the chunk list & make sure it exists
	var chunkList = global.nodeMap[? "chunkList"];
	if (!scr_isNumericAndExists(chunkList, ds_type_list)) {
		show_debug_message("scr_lockChunks ... chunkList does not exist");
		exit;
	}
	
	var chunkListSize = ds_list_size(chunkList);
	for (var i = 0; i < chunkListSize; i++) {
		var currentChunk = chunkList[| i];
		var currentChunkSubMap = global.nodeMap[? currentChunk];
		if (!scr_isNumericAndExists(currentChunkSubMap, ds_type_map)) continue;
		
		currentChunkSubMap[? "lock"] = true;
	}

}