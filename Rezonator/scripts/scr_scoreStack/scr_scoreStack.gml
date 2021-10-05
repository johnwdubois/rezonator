// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_scoreStack(){

	
	var currentStackID = "";
	
	if(obj_panelPane.functionChainList_currentTab == obj_panelPane.functionChainList_tabShow && obj_panelPane.functionChainContents_showID != "" ){
		var currentShowSubMap = global.nodeMap[? obj_panelPane.functionChainList_playShowID];
		if (scr_isNumericAndExists(currentShowSubMap,ds_type_map)) {
			//get setlist of playing show
			var setList = currentShowSubMap[? "setIDList"];	
			if (scr_isNumericAndExists(setList, ds_type_list)) {		
				currentStackID = setList[| obj_panelPane.currentChainIndex];
			}
		}
	}

	var stackSubMap = global.nodeMap[?currentStackID];
	if (!scr_isNumericAndExists(stackSubMap, ds_type_map)) exit;
	var rezMap = stackSubMap[?"rezMap"];
	if (!scr_isNumericAndExists(rezMap, ds_type_map)) exit;
	var stackSubMap = global.nodeMap[?currentStackID];
	if(!scr_isNumericAndExists(stackSubMap, ds_type_map)){exit;}

	
	if(obj_chain.increaseStack){
		obj_chain.increaseStack = false;
		stackSubMap[? "movesMade"]++;
	}
	
	var chainMap = ds_map_create();
	var tempUnitList = scr_getChainTempList(currentStackID,true);
	var unitListSize = ds_list_size(tempUnitList);
	var rezChainsInStackList = ds_list_create();
	for(var i = 0; i < unitListSize; i ++){
	
		var currentUnit = tempUnitList[|i];
		var currentUnitSubMap = global.nodeMap[?currentUnit];
		var entryList = currentUnitSubMap[? "entryList"];
		if(!scr_isNumericAndExists(entryList, ds_type_list)){continue;}
		var entryListSize = ds_list_size(entryList);

		for(var j = 0; j < entryListSize; j ++){
			var currentEntry = entryList[|j];
			var currentEntrySubMap = global.nodeMap[?currentEntry];
			var currentToken = currentEntrySubMap[?"token"];
			var currentTokenSubMap = global.nodeMap[?currentToken];
			var inChainsList = currentTokenSubMap[?"inChainsList"];
			var inChainsListSize = ds_list_size(inChainsList);

			for(var k = 0; k < inChainsListSize; k++){
			
				var currentChainID = inChainsList[|k];
				scr_addToListOnce(rezChainsInStackList, currentChainID);
			}			
		}		
	}
	
	var totalNonResonanceMatches = 0;
	var rezChainsInStackListSize = ds_list_size(rezChainsInStackList);
	var stackScore = 0;
	for(var i = 0; i < rezChainsInStackListSize; i++){
		var currentRezChain = rezChainsInStackList[| i]
		totalNonResonanceMatches += scr_scoreChain(currentRezChain, rezMap);
		var currentRezChainSubMap = global.nodeMap[?currentRezChain];
		var currentChainScore = currentRezChainSubMap[?"maxResonance"];
		stackScore += power(currentChainScore, 2);
	}
	
	stackSubMap[?"score"] = stackScore - totalNonResonanceMatches;


	ds_list_destroy(rezChainsInStackList);
	ds_list_destroy(tempUnitList);
	ds_map_destroy(chainMap);


}