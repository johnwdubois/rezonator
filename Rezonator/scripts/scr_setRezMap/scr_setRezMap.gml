// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_setRezMap(stackID){

	var par = get_string("","");

	var chainMap = ds_map_create();


	var stackSubMap = global.nodeMap[?stackID];
	if(!scr_isNumericAndExists(stackSubMap, ds_type_map)){exit;}

	var unitList = scr_getChainTempList(stackID,true);
	
	var unitListSize = ds_list_size(unitList);
	
	for(var i = 0; i < unitListSize; i ++){
	
		var currentUnit = unitList[|i];
		var currentUnitSubMap = global.nodeMap[?currentUnit];
		var entryList = currentUnitSubMap[? "entryList"];
		if(!scr_isNumericAndExists(entryList, ds_type_list)){exit;}
		var entryListSize = ds_list_size(entryList);

		for(var j = 0; j < entryListSize; j ++){
			var currentEntry = entryList[|j];
			var currentEntrySubMap = global.nodeMap[?currentEntry];
			var currentToken = currentEntrySubMap[?"token"];
			
			var currentTokenSubMap = global.nodeMap[?currentToken];
			
			var tagMap = currentTokenSubMap[?"tagMap"];
			var displayString = tagMap[?global.displayTokenField];
			var inChainsList = currentTokenSubMap[?"inChainsList"];
			var inChainsListSize = ds_list_size(inChainsList);
			for(var k = 0; k < inChainsListSize; k++){
			
				var currentChainID = inChainsList[|k];
				
				if(ds_map_exists(chainMap,currentChainID)){
					var chainList = chainMap[?currentChainID];
					scr_addToListOnce(chainList, displayString)
				}
				else{
					var newList = ds_list_create();
					ds_list_add(newList, displayString)
					ds_map_add_list(chainMap, currentChainID, newList);
				}
			}			
		}		
	}
	
	var chainMapSize = ds_map_size(chainMap);
	var tokenMap = ds_map_create();
	var key = ds_map_find_first(chainMap);
	
	var totalScore = 0;
	
	repeat(chainMapSize){
		
		var chainList = chainMap[?key];
		var chainSubMap = global.nodeMap[?key];
		
		var chainListSize = ds_list_size(chainList);
		
		for(var i = 0; i < chainListSize; i++){
			
			var currentToken = chainList[|i];
			if(!ds_map_exists(tokenMap,currentToken)){
				var tokenList = ds_list_create();
				ds_list_add(tokenList,currentToken);
				ds_map_add_list(tokenMap,currentToken,tokenList);
			}
			else{
				var tokenList = tokenMap[?currentToken];
			}
			
			for(var j = 0; j < chainListSize; j++){	
				var currentTokenToAdd = chainList[|j];
				if(j == i){continue;}
				scr_addToListOnce(tokenList,currentTokenToAdd);
			}
			
		}
		
		var entryList = chainSubMap[?"setIDList"];
		
		var entryListSize = ds_list_size(entryList);
		totalScore += power(entryListSize,2);
		
		key = ds_map_find_next(chainMap, key);
	
	}
	
	
	
	
	
	ds_map_add_map(stackSubMap, "rezMap", tokenMap);
	ds_map_add(stackSubMap, "par", par);
	ds_map_add(stackSubMap, "totalScore", totalScore);
	ds_map_add(stackSubMap, "movesMade", 0);
	
	scr_deleteAllChains(global.nodeMap[?"resonanceList"]);
	
	
}