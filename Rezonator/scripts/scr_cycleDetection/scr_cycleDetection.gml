// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_cycleDetection(chainOrderList){
	
	if(!scr_isNumericAndExists(chainOrderList, ds_type_list)) {
		show_debug_message("scr_cycleDetection, Not a List WTF")
		exit;
	}
	
	var cliqueSubMap = global.cliqueMap[? obj_chain.currentClique]
	if(ds_list_find_index(chainOrderList, obj_chain.currentFocusedChainID) >= 0 ){
		//cycle found
		var chainSubMap = global.nodeMap[? obj_chain.currentFocusedChainID];
		var setList = chainSubMap[? "setIDList"];
		var lastEntry = setList[| (ds_list_size(setList)-1)];
		var entrySubMap = global.nodeMap[? lastEntry];
		entrySubMap[?"stretch"] = true;
		show_debug_message("scr_cycleDetection, CYCLE DETECTED in chain: " + string(obj_chain.currentFocusedChainID));
		exit;
	}
	else{
		var chainOrderListSize = ds_list_size(chainOrderList);
		for(var i = 0;  i < chainOrderListSize; i++){
			//get current chain chain order List and call again
			scr_cycleDetection(cliqueSubMap[? chainOrderList[|i]]);
		}
	}
}