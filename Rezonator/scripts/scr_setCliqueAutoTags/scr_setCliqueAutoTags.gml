function scr_setCliqueAutoTags(cliqueID) {
	
	if (is_string(cliqueID) && cliqueID != "") {
		var cliqueSubMap = global.cliqueMap[? cliqueID];
		if (scr_isNumericAndExists(cliqueSubMap, ds_type_map)) {
			var cliqueChainList = cliqueSubMap[? "chainList"];
			if (scr_isNumericAndExists(cliqueChainList, ds_type_list)) {
				var cliqueEntryCount = 0;
				var cliqueChainListSize = ds_list_size(cliqueChainList);
				cliqueSubMap[? "chainCount"] = cliqueChainListSize;
				
				// sum up all the set list sizes from all the chains in this clique
				for (var i = 0; i < cliqueChainListSize; i++) {
					var currentCliqueChain = cliqueChainList[| i];
					var currentCliqueChainSubMap = global.nodeMap[? currentCliqueChain];
					var currentCliqueChainSetIDList = currentCliqueChainSubMap[? "setIDList"];
					if (scr_isNumericAndExists(currentCliqueChainSetIDList, ds_type_list)) {
						cliqueEntryCount += ds_list_size(currentCliqueChainSetIDList);
					}
				}
				
				cliqueSubMap[? "linkCount"] = cliqueEntryCount;
			}

			// to get the unit count, just get the size of the unit list
			var cliqueUnitList = cliqueSubMap[? "unitList"];
			if (scr_isNumericAndExists(cliqueUnitList, ds_type_list)) {
				cliqueSubMap[? "unitCount"] = ds_list_size(cliqueUnitList);
			}
		}
	}
	
}