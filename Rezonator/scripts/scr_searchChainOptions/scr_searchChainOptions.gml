// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_searchChainOptions(optionSelected){
	
	var searchSubMap = global.searchMap[? obj_panelPane.functionSearchList_searchSelected];
	if (scr_isNumericAndExists(searchSubMap, ds_type_map)) {
		var selectedTokenList = searchSubMap[? "selectedTokenList"];
	}
	else{
		instance_destroy(obj_dropDown);
		exit;
	}
	
	obj_toolPane.currentMode = obj_toolPane.modeTrack;
	var selectedTokenListSize = ds_list_size(selectedTokenList);
	
	if (optionSelected == "Create New Chain") {	
		
		var i = 0;
		var chainCreated = false;
		repeat(selectedTokenListSize){
			var currentToken = selectedTokenList[|i];
			
			//find if in chain already
			var inChain = false;
			var tokenSubMap = global.nodeMap[?currentToken];
			var inChainsList = tokenSubMap[?"inChainsList"];
			var inChainsListSize = ds_list_size(inChainsList);
			if(inChainsListSize > 0 ){
				var j = 0;
				repeat(inChainsListSize){
					var currentChain = inChainsList[|j];
					var chainSubMap = global.nodeMap[?currentChain];
					var chainType = chainSubMap[?"type"];
					if(string(chainType) == "trail") {
						inChain = true;
					}
					j++;
				}
			}

			
			if(!inChain){
				if(!chainCreated){
					scr_newChain(currentToken);
					scr_newLink(currentToken);
					chainCreated = true;
				}
				else{
					scr_newLink(currentToken);
				}
			}
			i++;
		}
		

	}
	else {
		obj_chain.currentFocusedChainID = optionSelected;
		var i = 0;
		repeat(selectedTokenListSize){
			
			var currentToken = selectedTokenList[|i];
			
			//find if in chain already
			var inChain = false;
			var tokenSubMap = global.nodeMap[?currentToken];
			var inChainsList = tokenSubMap[?"inChainsList"];
			var inChainsListSize = ds_list_size(inChainsList);
			if(inChainsListSize > 0 ){
				var j = 0;
				repeat(inChainsListSize){
					var currentChain = inChainsList[|j];
					var chainSubMap = global.nodeMap[?currentChain];
					var chainType = chainSubMap[?"type"];
					if(string(chainType) == "trail") {
						inChain = true;
					}
					j++;
				}
			}
			
			if(!inChain){
				scr_newLink(currentToken);
			}
			i++;
		}
	}
	instance_destroy(obj_dropDown);
	
}