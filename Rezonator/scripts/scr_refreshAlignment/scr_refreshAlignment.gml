// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_refreshAlignment(){
	
	// refresh alignment for all rez chains
	var rezChainList = global.nodeMap[? "rezChainList"];
	if (scr_isNumericAndExists(rezChainList, ds_type_list)) {
		var rezChainListSize = ds_list_size(rezChainList);
		for (var i = 0; i < rezChainListSize; i++) {
			scr_alignChain2ElectricBoogaloo(rezChainList[| i]);
		}
	}

}