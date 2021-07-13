// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_cliqueDetection(){

	var discourseSubMap = global.nodeMap[? global.discourseNode];
	var unitList = discourseSubMap[? "unitList"];

	var unitListSize = ds_list_size(unitList);

	for(var i = 0; i < unitListSize; i ++){
		var currentUnit = unitList[| i];
		if(ds_list_find_index(obj_chain.encounteredUnitList,currentUnit) == -1){
			var unitSubMap =  global.nodeMap[? currentUnit];
			var entryList = unitSubMap[? "entryList"];
			
			var entryListSize = ds_list_size(entryList);

			for(var j = 0; j < entryListSize; j ++){
				var entryID = entryList[| j];
				var entrySubMap = global.nodeMap[? entryID];
				var tokenID = entrySubMap[? "token"];
				var tokenSubMap = global.nodeMap[? tokenID];
				var inChainsList = tokenSubMap[? "inChainsList"];
				
				var inChainsListSize = ds_list_size(inChainsList);
			
				for(var k = 0; k < inChainsListSize; k ++){
					var currentChainID = inChainsList[|k];
					if(ds_list_find_index(global.nodeMap[? "rezChainList"], currentChainID) >= 0){
						// found rez in unit lets create a clique based off this token
						ds_list_add(obj_chain.encounteredTokenList, tokenID);
						
					}
				}
			}
			scr_cliqueGeneration()
		}
	}
	ds_list_clear(obj_chain.encounteredUnitList);
	obj_chain.cliqueCount = 0;
}