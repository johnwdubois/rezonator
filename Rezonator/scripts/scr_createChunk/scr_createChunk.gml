// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_createChunk(){
	
	show_debug_message("....scr_createChunk, mouseoverPanelPane: " + string(obj_control.mouseoverPanelPane) + ", delayInput: " + string(global.delayInput));
	
	if (obj_control.mouseoverPanelPane) exit;
	if (global.delayInput > 0) exit;
	
	var chunkID = "";
	
	// Place all captured unit and token info into the box grid
	var inRectTokenIDListSize = ds_list_size(obj_control.inRectTokenIDList);
	var inRectUnitIDListSize = ds_list_size(obj_control.inRectUnitIDList);
	
	for(var i = 0; i < inRectTokenIDListSize; i++){
		var tokenToCheck = obj_control.inRectTokenIDList[|i];
		var tokenSubMap = global.nodeMap[? tokenToCheck];
		var tokenInChunkList = tokenSubMap[? "inChunkList"];
		var tokenInChunkListSize = ds_list_size(tokenInChunkList);
		for(var j =0; j < tokenInChunkListSize; j++){
			var chunkToCheck = tokenInChunkList[|j];
			var chunkSubMap = global.nodeMap[?chunkToCheck];
			var tokenList = chunkSubMap[? "tokenList"];
			if(scr_compareLists(tokenList, obj_control.inRectTokenIDList)){
				show_debug_message("CHUNK ALREADY EXISTS")
				exit;
			}
		}
	}
	
	
	if (inRectUnitIDListSize > 0 && inRectTokenIDListSize > 0) { // Make sure the box captured something

		// Retrieve references of the lists being added to
		var tokenIDList = ds_list_create();
		var inChainsList = ds_list_create();
		var inEntryList = ds_list_create();
		
		// copy contents of inRectTokenIDList into tokenIDList
		ds_list_copy(tokenIDList, obj_control.inRectTokenIDList);
		show_debug_message("scr_createChunk() ... tokenIDList: " + scr_getStringOfList(tokenIDList));
		
		// create Chunk new node in node map
		chunkID = scr_addToNodeMap("chunk");
		var chunkSubMap = global.nodeMap[? chunkID];
		ds_map_add_list(chunkSubMap, "tokenList", tokenIDList);
		ds_map_add_list(chunkSubMap, "inChainsList", inChainsList);
		ds_map_add_list(chunkSubMap, "inEntryList", inEntryList);
		
		var firstToken = tokenIDList[| 0];
		var firstTokenSubMap = global.nodeMap[? firstToken];
		var lastToken = tokenIDList[| ds_list_size(tokenIDList)-1];
		var lastTokenSubMap = global.nodeMap[? lastToken];
		
		var startDocOrder = firstTokenSubMap[? "docTokenSeq"];
		var endDocOrder = lastTokenSubMap[? "docTokenSeq"];
		
		var highestNest = 0;
		var lowestEncapsulatingNest = 999999999999999;
		var lowestEncapsulatingChunk = "";
		var highestEncapsulatedNest = 0;
		var highestEncapsulatedChunk = "";
			
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
					
					scr_addToListOnce(currentTokenInChunkList, chunkID);
					
					var chunkListSize =  ds_list_size(currentTokenInChunkList);
					//find highestNestedlevel for all chunks
					for(var j  = 0 ; j < chunkListSize; j++){
						var currentChunk = currentTokenInChunkList[|j]
						//skip over newest created chunk while calculating nesting
						if(currentChunk == chunkID){continue;}
						var currentChunkSubMap = global.nodeMap[? currentChunk];
						var currentChunkNest = currentChunkSubMap[? "nest"];
						
						var currentChunkTokenList = currentChunkSubMap[? "tokenList"];
						
						var currentChunkFirstToken = currentChunkTokenList[| 0];
						var currentChunkFirstTokenSubMap = global.nodeMap[? currentChunkFirstToken];
						var currentChunkLastToken = currentChunkTokenList[| ds_list_size(currentChunkTokenList)-1];
						var currentChunkLastTokenSubMap = global.nodeMap[? currentChunkLastToken];
							
						
						//get token seq of current chunk for comaparison
						var currentChunkStartDocOrder = currentChunkFirstTokenSubMap[? "docTokenSeq"];
						var currentChunkEndDocOrder = currentChunkLastTokenSubMap[? "docTokenSeq"];
						
						//the chunk is encapsulating the new chunk
						if(currentChunkStartDocOrder <= startDocOrder && currentChunkEndDocOrder >= endDocOrder){
							if(currentChunkNest < lowestEncapsulatingNest) {
								lowestEncapsulatingChunk = currentChunk;
								lowestEncapsulatingNest = currentChunkNest;
							}
						}
						
						
						////the new chunk is contains any part of the currentChunk
						else if(startDocOrder <= currentChunkStartDocOrder  && endDocOrder >= currentChunkEndDocOrder){
							if(currentChunkNest > highestEncapsulatedNest) {
								highestEncapsulatedChunk = currentChunk;
								highestEncapsulatedNest = currentChunkNest;
							}
						}
						
						//check the semi encapsulated tokens
						else if ((currentChunkStartDocOrder >= startDocOrder && currentChunkStartDocOrder <= endDocOrder) xor (currentChunkEndDocOrder >= startDocOrder && currentChunkEndDocOrder <= endDocOrder)) {
							if(currentChunkNest > highestEncapsulatedNest) {
								highestEncapsulatedChunk = currentChunk;
								highestEncapsulatedNest = currentChunkNest;
								show_debug_message("SEMI ENCAPSULATED");
							}
						}



						highestNest = max(highestNest,currentChunkNest);	
					}	
				}
			}
		}
		
		if(lowestEncapsulatingChunk == ""){
			// give the chunk it's nested level
			chunkSubMap[? "nest"] = highestNest + 1;
			show_debug_message("no lowestEncapsulatingChunk");
			
		}
		else{
			
			show_debug_message("highestEncapsulatedNest: " + string(highestEncapsulatedNest));
			show_debug_message("lowestEncapsulatingNest: " + string(lowestEncapsulatingNest));

			chunkSubMap[? "nest"] = highestEncapsulatedNest + 1;
			
			ds_list_clear(obj_chain.encounteredChunkList);
			if(highestEncapsulatedNest + 1 >= lowestEncapsulatingNest ){

				ds_list_add(obj_chain.encounteredChunkList,chunkID);
				scr_expandChunk(lowestEncapsulatingChunk);
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
				
				if(focusedChainSubMap[?"type"] != "stack"){
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
	
	with (obj_panelPane) {
		functionChainList_chunkSelected = chunkID;
		if (currentFunction == functionChainList) {
			scrollPlusYDest = -9999999999999;
		}
	}

	global.delayInput = 5;
}