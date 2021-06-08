// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_unitRightClicked(){
	
	if (instance_exists(obj_control) and !instance_exists(obj_dialogueBox)) {
		
		var unitSubMap = global.nodeMap[?obj_control.rightClickID];
		if(!scr_isNumericAndExists(unitSubMap, ds_type_map)){exit;}
		
		var unitInChainsList = unitSubMap[?"inChainsList"];

		obj_control.rightClicked = true;
		obj_control.wideDropDown = true;
		var dropDownOptionList = ds_list_create();

		// Options for a word in a Chain
		if(ds_list_size(unitInChainsList) > 0){
					
			ds_list_add(dropDownOptionList,  "Delete Link");
		
			for(var i = 0; i < ds_list_size(unitInChainsList); i++){
				var chainID = unitInChainsList[|i];
				var chainSubMap = global.nodeMap[?chainID];
				if(scr_isNumericAndExists(chainSubMap, ds_type_map)){
					var chainType = chainSubMap[?"type"];
					
					
					if (obj_panelPane.functionField_chainFieldSelected != "" && obj_panelPane.functionField_chainTagSelected != ""
						&& is_string(obj_panelPane.functionField_chainFieldSelected) && is_string(obj_panelPane.functionField_chainTagSelected)) {
							scr_addToListOnce(dropDownOptionList , "Tag Chain");
					}
					if (obj_panelPane.functionField_entryFieldSelected != "" && obj_panelPane.functionField_entryTagSelected != ""
						&& is_string(obj_panelPane.functionField_entryFieldSelected) && is_string(obj_panelPane.functionField_entryTagSelected)) {
							scr_addToListOnce(dropDownOptionList , "Tag Entry");
					}
			
				}
			
				// check whether we should refocus this word's entry or not
				var refocusEntry = (chainType == "stackChain") or (obj_toolPane.currentMode == obj_toolPane.modeRead);
				
				if(refocusEntry){
					obj_chain.currentFocusedChainID = chainID;
					scr_refocusChainEntry(obj_control.rightClickID);
				}
			}
					
		}

		//ds_list_add(dropDownOptionList, "Delete Chunk");

				
		// Create the dropdown
		if (ds_list_size(dropDownOptionList) > 0 and obj_control.ableToCreateDropDown) {
			scr_createDropDown(mouse_x, mouse_y, dropDownOptionList, global.optionListTypeSpeakerLabel);
		}
	}
}