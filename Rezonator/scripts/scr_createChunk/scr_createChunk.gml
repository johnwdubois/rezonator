// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_createChunk(){
	
	show_debug_message("scr_createChunk()");
	
	var chunkID = "";
	
	// Place all captured unit and token info into the box grid
	var inRectTokenIDListSize = ds_list_size(inRectTokenIDList);
	var inRectUnitIDListSize = ds_list_size(inRectUnitIDList);
	
	// only allow single-token chunks if this is an IGT file with a word delimiter
	if (inRectTokenIDListSize <= 1) {
		//if(!instance_exists(obj_loadingControl)) exit;
	}
	
	
	if (inRectUnitIDListSize > 0 && inRectTokenIDListSize > 0) { // Make sure the box captured something

		// Retrieve references of the lists being added to
		var tokenIDList = ds_list_create();
		var inChainsList = ds_list_create();
		
		// copy contents of inRectTokenIDList into tokenIDList
		ds_list_copy(tokenIDList, inRectTokenIDList);
		show_debug_message("scr_createChunk() ... tokenIDList: " + scr_getStringOfList(tokenIDList));
		
		// create Chunk new node in node map
		chunkID = scr_addToNodeMap("chunk");
		var chunkSubMap = global.nodeMap[? chunkID];
		ds_map_add_list(chunkSubMap, "tokenList", tokenIDList);
		ds_map_add_list(chunkSubMap, "inChainsList", inChainsList);
			
		//set to focused chunk
		obj_chain.currentFocusedChunkID = chunkID;
		
		// loop over tokenIDList and tell each token what its chunk is
		var tokenIDListSize = ds_list_size(tokenIDList);
		for (var i = 0; i < tokenIDListSize; i++) {
			var currentTokenID = tokenIDList[| i];
			var currentTokenSubMap = global.nodeMap[? currentTokenID];
			if (scr_isNumericAndExists(currentTokenSubMap, ds_type_map)) {
				var currentTokenInChunkList = currentTokenSubMap[? "inChunkList"];
				if (scr_isNumericAndExists(currentTokenInChunkList, ds_type_list)) {
					if (ds_list_find_index(currentTokenInChunkList, chunkID) == -1) {
						ds_list_add(currentTokenInChunkList, chunkID);
					}
				}
			}
		}
		
		// add the new chunk to the chunkList
		var chunkList = global.nodeMap[? "chunkList"];
		if (scr_isNumericAndExists(chunkList, ds_type_list)) {
			if (ds_list_find_index(chunkList, chunkID) == -1) ds_list_add(chunkList, chunkID);
		
			// give the chunk a name
			chunkSubMap[? "name"] = "Chunk " + string(ds_list_size(chunkList));
		}
		
		
		// give the chunk a tagMap
		var chunkTagMap = ds_map_create();
		ds_map_add_map(chunkSubMap, "tagMap", chunkTagMap);
		var tokenFieldListSize = ds_list_size(obj_control.tokenFieldList);
		for (var i = 0; i < tokenFieldListSize; i++) {
			var currentTokenField = obj_control.tokenFieldList[| i];
			if (is_string(currentTokenField)) {
				chunkTagMap[? currentTokenField] = "";
			}
		}
	}
	
	
	var chunksInChainsList = chunkSubMap[? "inChainsList"];
	if (ds_list_size(chunksInChainsList) < 1) {
		//in chain making tool
		if(obj_toolPane.currentMode == obj_toolPane.modeRez || obj_toolPane.currentMode == obj_toolPane.modeTrack){
			//chain is already seleceted
			if(obj_chain.currentFocusedChainID != ""){
				var focusedChainSubMap = global.nodeMap[?obj_chain.currentFocusedChainID];
				
				if(focusedChainSubMap[?"type"] != "stackChain"){
					scr_newLink(chunkID);
				}
				else{
					scr_newChain(chunkID);
					scr_newLink(chunkID);
				}
			}
			else{
				scr_newChain(chunkID);
				scr_newLink(chunkID);
			}
		}
	}
	
	// if there is a focused chain, unfocus the chunk
	if (obj_chain.currentFocusedChainID != "") {
		obj_chain.currentFocusedChunkID = "";
	}

	global.delayInput = 5;
}