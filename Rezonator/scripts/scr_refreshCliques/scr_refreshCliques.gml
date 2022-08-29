function scr_refreshCliques(){
	show_debug_message("scr_refreshCliques, START" + scr_printTime());
	
	obj_chain.cliqueCount = 1;
	
	// if cliqueMap doesn't exist, try to find it in the nodeMap
	// if it still doesn't exist, just exit
	if (!scr_isNumericAndExists(global.cliqueMap, ds_type_map)) {
		global.cliqueMap = global.nodeMap[? "cliqueMap"];
		if (!scr_isNumericAndExists(global.cliqueMap, ds_type_map)) exit;
	}
	
	scr_clearCliqueMap();
	scr_cliqueDetection();
	scr_chainOrderMap();
	var cliqueListSize = ds_list_size(obj_chain.cliqueList);
	
	var cliqueSubMap = -1;
	for(var i = 0 ; i < cliqueListSize; i ++){
		cliqueSubMap = global.cliqueMap[? obj_chain.cliqueList[| i ]];
		if(ds_map_exists(cliqueSubMap, obj_chain.currentFocusedChainID)){
			obj_chain.currentClique = obj_chain.cliqueList[| i ];
			break;
		}
		
	}
	
	if(scr_isNumericAndExists(cliqueSubMap,ds_type_map)){
		scr_cycleDetection(obj_chain.currentFocusedChainID);
	}
	ds_list_clear(obj_chain.encounteredChainList);
	obj_chain.cycleDetected = false;
	show_debug_message("scr_refreshCliques, END" + scr_printTime());
}