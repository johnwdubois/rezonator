function scr_dialogueBoxNewCustomTagToken() {
	
	show_debug_message("scr_dialogueBoxNewCustomTagToken ... tokenFieldToChange: "+ string(obj_control.tokenFieldToChange) + ",    tokenToChange: "+ string(obj_control.tokenToChange));
	show_debug_message("scr_dialogueBoxNewCustomTagToken ... chunk1to1FieldToChange: "+ string(obj_control.chunk1to1FieldToChange) + ",    chunkToChange: "+ string(obj_control.chunk1to1ChunkToChange));
	
	
	// get submap for this field
	var tokenTagMap = global.nodeMap[? "tokenTagMap"];
	if(obj_panelPane.functionChainList_currentTab == obj_panelPane.functionChainList_tabChunk && !obj_panelPane.chainViewOneToMany){
		var fieldSubMap = tokenTagMap[? obj_control.chunk1to1FieldToChange];
	}
	else{
		var fieldSubMap = tokenTagMap[? obj_control.tokenFieldToChange];
	}
	
	
	
	
	if (!scr_isNumericAndExists(fieldSubMap, ds_type_map)) {
		show_debug_message("scr_dialogueBoxNewCustomTagToken ... fieldSubMap does not exist");
		exit;
	}
	
	// get the tagset for this field
	var tagSet = fieldSubMap[? "tagSet"];
	if (!scr_isNumericAndExists(tagSet, ds_type_list)) {
		show_debug_message("scr_dialogueBoxNewCustomTagToken ... tagSet does not exist");
		exit;
	}
	
	// add new tag to this field's tagSet
	scr_addToListOnce(tagSet, obj_control.inputText);
	
	//add this to selected token if not in tag pane
	if(obj_panelPane.functionChainList_currentTab != obj_panelPane.functionChainList_tabField){
		if(obj_panelPane.functionChainList_currentTab == obj_panelPane.functionChainList_tabChunk && !obj_panelPane.chainViewOneToMany){
			// get the chunkToChange's submap, and that chunks's tagmap
			var chunkSubMap = global.nodeMap[? obj_control.chunk1to1ChunkToChange];
			if(scr_isNumericAndExists(chunkSubMap, ds_type_map)){
				var chunkTagMap = chunkSubMap[? "tagMap"];
				// set the new value in this token's tagmap
				chunkTagMap[? obj_control.chunk1to1FieldToChange] = obj_control.inputText;
			}
			obj_control.chunk1to1ChunkToChange = "";
		}
		else{
			// get the tokenToChange's submap, and that token's tagmap
			var tokenSubMap = global.nodeMap[? obj_control.tokenToChange];
			if(scr_isNumericAndExists(tokenSubMap, ds_type_map)){
				var tokenTagMap = tokenSubMap[? "tagMap"];
				// set the new value in this token's tagmap
				tokenTagMap[? obj_control.tokenFieldToChange] = obj_control.inputText;
			}
			obj_control.tokenToChange = "";
		}
	}
	
}
