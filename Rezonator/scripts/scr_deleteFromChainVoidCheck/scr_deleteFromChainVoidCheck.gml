// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_deleteFromChainVoidCheck(chainID, deletedTokenID, deletedTokenPushBack){
	
	show_debug_message("scr_deleteFromChainVoidCheck() chainID " + string(chainID) + ", deletedTokenID: " + string(deletedTokenID) + ", deletedTokenPushBack: " + string(deletedTokenPushBack));
	
	// get chain submap and make sure it exists
	var chainSubMap = global.nodeMap[? chainID];
	if (!scr_isNumericAndExists(chainSubMap, ds_type_map)) exit;
	var chainType = chainSubMap[? "type"];
	if (chainType != "rezChain") exit;
	var chainSetList = chainSubMap[? "vizSetIDList"];
	if (!scr_isNumericAndExists(chainSetList, ds_type_list)) exit;
	var chainSetListSize = ds_list_size(chainSetList);
	var deletedTokenSubMap = global.nodeMap[? deletedTokenID];
	


	
	if (deletedTokenPushBack and scr_isNumericAndExists(deletedTokenSubMap, ds_type_map)) {
		
		
		var deletedTokenSeq = deletedTokenSubMap[? "tokenSeq"];
		var deleteDisplayColDest = 0;
		if (deletedTokenSeq > 1) {
			deleteDisplayColDest = scr_getPrevDisplayCol(deletedTokenID);
		}
		else {
			deleteDisplayColDest = 0;
		}
		
		deletedTokenSubMap[? "displayCol"] = deleteDisplayColDest;

		

			
			
		//var currentChunkFirstWord = -1;	
		for (var i = 0; i < chainSetListSize; i++) {
			var currentEntry = chainSetList[| i];
			var currentEntrySubMap = global.nodeMap[? currentEntry];
			if (!scr_isNumericAndExists(currentEntrySubMap, ds_type_map)) continue;
			var currentTokenID = currentEntrySubMap[? "token"];
			var currentTokenSubMap = global.nodeMap[? currentTokenID];
			

			if (!scr_isNumericAndExists(currentTokenSubMap, ds_type_map)) continue;
			var currentTokenSeq = currentTokenSubMap[? "tokenSeq"];
			var currentDisplayColDest = 0;
			if (deletedTokenSeq > 1) {
				var prevDisplayCol = scr_getPrevDisplayCol(currentTokenID);
				currentDisplayColDest = prevDisplayCol + 1;
			}
			else {
				currentDisplayColDest = 0;
			}
			
			currentTokenSubMap[? "displayCol"] = currentDisplayColDest;			
			

		}
		
	}
	
	
	
	
	
	
	


	
	// check chain for voids (if this is a rezChain)
	if (chainType == "rezChain") {
		
		var smallVoidExists = false;

		for (var i = 0; i < chainSetListSize; i++) {
		
			var currentEntry = chainSetList[| i];
			var currentEntrySubMap = global.nodeMap[? currentEntry];
			if (!scr_isNumericAndExists(currentEntrySubMap, ds_type_map)) continue;
			var currentTokenID = currentEntrySubMap[? "token"];
			if (scr_isChunk(currentTokenID)) {
				currentTokenID = scr_getFirstWordOfChunk(currentTokenID);
			}
			var currentTokenSubMap = global.nodeMap[? currentTokenID];
			
			if (!scr_isNumericAndExists(currentTokenSubMap, ds_type_map)) continue;
			var currentTokenSeq = currentTokenSubMap[? "tokenSeq"];
			var currentDisplayCol = currentTokenSubMap[? "displayCol"];
			
			if (currentTokenSeq > 1) {
				var prevDisplayCol = scr_getPrevDisplayCol(currentTokenID);
				if (is_numeric(prevDisplayCol)) {
					var currentVoid = currentDisplayCol - prevDisplayCol;
					show_debug_message("currentVoid: " + string(currentVoid));
					if (currentVoid <= 1) {
						smallVoidExists = true;
					}
				}
			}
			else if (currentDisplayCol == 0) {
				smallVoidExists = true;
			}
		}
		
	

		
		
		if (!smallVoidExists) {
			// bring all the words back so that they have a void of 1
			for (var i = 0; i < chainSetListSize; i++) {
				var currentEntry = chainSetList[| i];
				var currentEntrySubMap = global.nodeMap[? currentEntry];
				if (!scr_isNumericAndExists(currentEntrySubMap, ds_type_map)) continue;
				
				var currentTokenID = currentEntrySubMap[? "token"];			
				if(scr_isChunk(currentTokenID)){
					currentTokenID = scr_getFirstWordOfChunk(currentTokenID);
				}
				var currentTokenSubMap = global.nodeMap[? currentTokenID];
				if (!scr_isNumericAndExists(currentTokenSubMap, ds_type_map)) continue;
				var currentTokenSeq = currentTokenSubMap[? "tokenSeq"];
				var currentDisplayCol = currentTokenSubMap[? "displayCol"];
			
				if (currentTokenSeq > 1) {
					var prevDisplayCol = scr_getPrevDisplayCol(currentTokenID);
					currentDisplayCol = prevDisplayCol + 1;
				}
				else {
					currentDisplayCol = 0;
				}
				
				currentTokenSubMap[? "displayCol"] = currentDisplayCol;
			}
		}
		
		scr_alignChain2ElectricBoogaloo(chainID);
	}
	
	
}