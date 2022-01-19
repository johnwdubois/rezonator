

function scr_cycleDetection(chainID){
	
	show_debug_message("scr_cycleDetection: START" + string(scr_printTime()) + "   ~"+string(chainID));
	
	var cliqueSubMap = global.cliqueMap[? obj_chain.currentClique];
	
	if(ds_list_find_index(obj_chain.encounteredChainList, chainID) == -1 && scr_isNumericAndExists(cliqueSubMap,ds_type_map)){
		
		ds_list_add(obj_chain.encounteredChainList, chainID);
		var chainOrderList = cliqueSubMap[? chainID];

		if(scr_isNumericAndExists(chainOrderList, ds_type_list)){
	
			if(ds_list_find_index(chainOrderList, chainID) >= 0  || ds_list_find_index(chainOrderList, obj_chain.currentFocusedChainID) >= 0 ){
				//cycle found
				if(ds_list_find_index(chainOrderList, chainID) >= 0 ){
					var chainSubMap =  global.nodeMap[? chainID];
				}
				else{
					var chainSubMap = global.nodeMap[?  obj_chain.currentFocusedChainID];
				}
				var setList = chainSubMap[? "setIDList"];
				var lastEntry = setList[| (ds_list_size(setList)-1)];
				var entrySubMap = global.nodeMap[? lastEntry];
				entrySubMap[?"stretch"] = true;
				show_debug_message("scr_cycleDetection, CYCLE DETECTED in chain: " + string(chainID));
				exit;
			}
			else{
				var chainOrderListSize = ds_list_size(chainOrderList);
				for(var i = 0;  i < chainOrderListSize; i++){
					//get current chain chain order List and call again
						scr_cycleDetection(chainOrderList[|i]);
				}
			}
		}
	}
	show_debug_message("scr_cycleDetection: END" + string(scr_printTime()));
}