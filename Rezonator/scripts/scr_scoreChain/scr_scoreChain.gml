// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_scoreChain(chainID, rezMap){
	
	
	if (!scr_isNumericAndExists(rezMap, ds_type_map)) {exit;}
	var chainSubMap = global.nodeMap[? chainID];
	if (!scr_isNumericAndExists(chainSubMap, ds_type_map)) {exit;}
	var vizSetIDList = chainSubMap[? "vizSetIDList"];
	var vizSetIDListSize = ds_list_size(vizSetIDList);
	

	
	var maxResonance = 0;
	
	for (var i = 0; i < vizSetIDListSize; i++) {
		
		var resonanceMatches = 0;
		
		var currentEntry = vizSetIDList[| i];
		var currentEntrySubMap = global.nodeMap[? currentEntry];
		var currentToken = currentEntrySubMap[? "token"];
		var currentTokenSubMap = global.nodeMap[? currentToken];
		var currentTokenTagMap = currentTokenSubMap[? "tagMap"];
		var currentDisplayStr = currentTokenTagMap[? global.displayTokenField];
		
		if (!ds_map_exists(rezMap, currentDisplayStr)) continue;
		var rezList = rezMap[? currentDisplayStr];
		if (!scr_isNumericAndExists(rezList, ds_type_list)) continue;
		
		for (var j = 0; j < vizSetIDListSize; j++) {
			
			var currentCheckEntry = vizSetIDList[| j];
			var currentCheckEntrySubMap = global.nodeMap[? currentCheckEntry];
			var currentCheckToken = currentCheckEntrySubMap[? "token"];
			var currentCheckTokenSubMap = global.nodeMap[? currentCheckToken];
			var currentCheckTokenTagMap = currentCheckTokenSubMap[? "tagMap"];
			var currentCheckDisplayStr = currentCheckTokenTagMap[? global.displayTokenField];
			
			// check if the j-token appears in the i-token's rezList
			if (ds_list_find_index(rezList, currentCheckDisplayStr) >= 0) resonanceMatches++;
		}
		
		// update the maximum amount of resonance
		if (resonanceMatches > maxResonance) {
			maxResonance = resonanceMatches;
			
			for (var j = 0; j < vizSetIDListSize; j++) {
				var currentCheckEntry = vizSetIDList[| j];
				var currentCheckEntrySubMap = global.nodeMap[? currentCheckEntry];
				var currentCheckToken = currentCheckEntrySubMap[? "token"];
				var currentCheckTokenSubMap = global.nodeMap[? currentCheckToken];
				currentCheckTokenSubMap[? "rezEffect"] = false;
				var currentCheckTokenTagMap = currentCheckTokenSubMap[? "tagMap"];
				var currentCheckDisplayStr = currentCheckTokenTagMap[? global.displayTokenField];
				if (ds_list_find_index(rezList, currentCheckDisplayStr) >= 0) currentCheckTokenSubMap[? "rezEffect"] = true;
			}

		}
	}
	

	chainSubMap[? "maxResonance"] = maxResonance;

}