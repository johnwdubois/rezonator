

function scr_refreshAlignment() {
	
	// refresh alignment for all rez chains
	var rezChainList = global.nodeMap[? "resonanceList"];
	if (scr_isNumericAndExists(rezChainList, ds_type_list)) {
		var rezChainListSize = ds_list_size(rezChainList);
		for (var i = 0; i < rezChainListSize; i++) {
			scr_alignChain2ElectricBoogaloo(rezChainList[| i]);
		}
	}

}