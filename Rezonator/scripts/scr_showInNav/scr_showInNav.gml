function scr_showInNav(nodeID){
	obj_control.showInNavID = nodeID;
	var nodeSubMap = global.nodeMap[?nodeID];
	var nodeType = nodeSubMap[? "type"];
	
	if(nodeType == "chunk"){
		obj_control.switchToTab = obj_panelPane.functionChainList_tabChunk;
		//scroll to position after switching
		with(obj_alarm2){ alarm[0] = 3;}
		with(obj_panelPane){
			functionChainList_chunkSelected = nodeID;
		}
	}

}