function scr_removeFromChunk(chunkID, removeFromStart) {
	
	show_debug_message("scr_removeFromChunk, chunkID: " + string(chunkID) + ", removeFromStart: " + string(removeFromStart));
	
	
	
	// make sure we have a valid chunk with a tokenlist
	var chunkSubMap = global.nodeMap[? chunkID];
	if (!scr_isNumericAndExists(chunkSubMap, ds_type_map)) {
		exit;
	}
	var tokenList = chunkSubMap[? "tokenList"];
	if (!scr_isNumericAndExists(tokenList, ds_type_list)) {
		exit;
	}
	
	// delete from start or end of chunk, only if the chunk has 2+ tokens
	if (ds_list_size(tokenList) >= 2) {
		
		// remove token from chunk, see if that chunk already exists
		var listBeforeRemoving = ds_list_create();
		ds_list_copy(listBeforeRemoving, tokenList);
		ds_list_delete(tokenList, removeFromStart ? 0 : ds_list_size(tokenList) - 1);

		// show alert if chunk already exists
		if (scr_checkChunkAlreadyExists(chunkID, tokenList)) {
			show_debug_message("scr_removeFromChunk, chunk already exists");
			var inst = instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
			with (inst) {
				alertWindowActive = true;
				chunkAlreadyExists = true;
			}
			
			// if the chunk already exists, we will restore the original list
			ds_list_copy(tokenList, listBeforeRemoving);
		}
		
		ds_list_destroy(listBeforeRemoving);
	}
}