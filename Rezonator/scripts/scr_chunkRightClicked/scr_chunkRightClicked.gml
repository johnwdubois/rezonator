// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_chunkRightClicked(){
	
	if (instance_exists(obj_control) and !instance_exists(obj_dialogueBox)) {
		
		var chunkSubMap = global.nodeMap[?obj_control.rightClickID];
		if(!scr_isNumericAndExists(chunkSubMap, ds_type_map)){exit;}
		
		var tokenInChainsList = chunkSubMap[?"inChainsList"];

		obj_control.rightClicked = true;
		obj_control.wideDropDown = true;
		var dropDownOptionList = ds_list_create();

		// Options for a word in a Chain
		if(ds_list_size(tokenInChainsList) > 0){
					
			ds_list_add(dropDownOptionList,  "Delete Link");
		
			for(var i = 0; i < ds_list_size(tokenInChainsList); i++){
				var chainID = tokenInChainsList[|i];
				var chainSubMap = global.nodeMap[?chainID];
				if(scr_isNumericAndExists(chainSubMap, ds_type_map)){
					var chainType = chainSubMap[?"type"];
				}
			
				// check whether we should refocus this word's entry or not
				var refocusEntry = (chainType == "rezChain" && obj_toolPane.currentMode == obj_toolPane.modeRez)
					or (chainType == "trackChain" && obj_toolPane.currentMode == obj_toolPane.modeTrack)
					or (obj_toolPane.currentMode == obj_toolPane.modeRead);
				
				if(refocusEntry){
					obj_chain.currentFocusedChainID = chainID;
					scr_refocusChainEntry(obj_control.rightClickID);
				}
			}
					
		}

		ds_list_add(dropDownOptionList, "Delete Chunk");

				
		// Create the dropdown
		if (ds_list_size(dropDownOptionList) > 0 and obj_control.ableToCreateDropDown) {
			scr_createDropDown(mouse_x, mouse_y, dropDownOptionList, global.optionListTypeRightClickWord);
		}
	}
}