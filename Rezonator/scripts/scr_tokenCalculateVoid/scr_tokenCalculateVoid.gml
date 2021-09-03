// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_tokenCalculateVoid(tokenID){
	
	var tokenSubMap = global.nodeMap[? tokenID];

	// check if this word is in an aligned chain
	var alignedChainID = "";
	var inChainsList = tokenSubMap[? "inChainsList"];
	var inChainsListSize = 0;
	if (!scr_isNumericAndExists(inChainsList, ds_type_list)) exit;
	inChainsListSize = ds_list_size(inChainsList);
	if (inChainsListSize > 0) {
		for (var i = 0; i < inChainsListSize; i++) {
			var currentChain = inChainsList[| i];
			var currentChainSubMap = global.nodeMap[? currentChain];
			if (scr_isNumericAndExists(currentChainSubMap, ds_type_map)) {
				if (currentChainSubMap[? "alignChain"]) alignedChainID = currentChain;
			}
		}
	}
	
	// get seq & displayCol for this token
	var tokenSeq = tokenSubMap[? "tokenOrder"];
	var tokenDisplayCol = tokenSubMap[? "displayCol"];

	// get displayCol of previous token
	var prevTokenID = tokenSubMap[? "prevToken"];
	if (is_undefined(prevTokenID)) tokenSubMap[? "prevToken"] = scr_prevTokenInSequence(tokenID);
	var prevTokenDisplayCol = -1;
	if (prevTokenID != "" && tokenSeq > 0) {
		var prevTokenSubMap = global.nodeMap[? prevTokenID];
		if (is_undefined(prevTokenSubMap)) {
			tokenSubMap[? "prevToken"] = scr_prevTokenInSequence(tokenID);
		}
		else {
			prevTokenDisplayCol = prevTokenSubMap[? "displayCol"];
		}
	}
	
	



	// set the void for this token
	var tokenVoid = 0;
	if (startJustify) tokenVoid = tokenDisplayCol - prevTokenDisplayCol;
	else tokenVoid = prevTokenDisplayCol - tokenDisplayCol;
	tokenSubMap[? "void"] = tokenVoid;
	
	
	// check if this word is the first word in an aligned chunk
	var alignedChunkChainID = scr_firstWordInAlignedChunk(tokenID);

	
	
	
	if (tokenVoid < 1 && prevTokenID != "") {
		if (startJustify) tokenDisplayCol++;
		else tokenDisplayCol--;
		tokenSubMap[? "displayCol"] = tokenDisplayCol;
			
		// if we are pushing a word in a chain, realign that chain
		if (inChainsListSize > 0) {
			for (var i = 0; i < inChainsListSize; i++) {
				var currentChain = ds_list_find_value(inChainsList, i);
				scr_alignChain2ElectricBoogaloo(currentChain);
			}
		}
		
		// if we are pushing a word in an aligned chunk, realign that chain too!
		if (alignedChunkChainID != "") scr_alignChain2ElectricBoogaloo(alignedChunkChainID);
	}

	
	// if this token is not in a chain, but has a void greater than 1, bring it back!!
	if (tokenVoid > 1) {
		
		if (alignedChainID == "" && alignedChunkChainID == "") {
			
			// if this token is not in an aligned chain and not in an aligned chunk, then it's displayCol should be the previous displayCol + 1
			if (startJustify) tokenDisplayCol = (tokenSeq == 0) ? 0 : prevTokenDisplayCol + 1;
			else tokenDisplayCol = (tokenSeq == 0) ? 0 : prevTokenDisplayCol - 1;
			tokenSubMap[? "displayCol"] = tokenDisplayCol;
			
		}
		else {
			
			// if this token is in a chain, and it has >1 void, let's quickly check that chain to see if it has any tokens with <=1 void
			// if it doesn't, let's pull that shit back!!!!
			for (var i = 0; i < inChainsListSize; i++) {
				var currentChain = inChainsList[| i];
				var currentChainSubMap = global.nodeMap[? currentChain];
				if (!scr_isNumericAndExists(currentChainSubMap, ds_type_map)) continue;
				
				var currentChainAlign = currentChainSubMap[? "alignChain"];
				if (currentChainAlign) {
					if (ds_list_find_index(obj_control.chainVoidCheckList, currentChain) == -1) {
						ds_list_add(obj_control.chainVoidCheckList, currentChain);
						
						scr_handleVoid(currentChainSubMap[? "vizSetIDList"]);
					}
				}
			}
		}
		
		
		
		// if this word is in an aligned chunk, we should check the aligned chain that the chunk is in to make sure it has a small void
		if (alignedChunkChainID != "") {
			var alignedChunkChainSubMap = global.nodeMap[? alignedChunkChainID];
			if (scr_isNumericAndExists(alignedChunkChainSubMap, ds_type_map)) {
				scr_handleVoid(alignedChunkChainSubMap[? "vizSetIDList"]);
			}
		}
	}
	
	
}