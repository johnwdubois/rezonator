// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_unitRightClicked(){
	
	if (instance_exists(obj_control) and !instance_exists(obj_dialogueBox)) {
		
		var unitSubMap = global.nodeMap[?obj_control.rightClickID];
		if(!scr_isNumericAndExists(unitSubMap, ds_type_map)){exit;}
		//deselect tree pane chain entities
		obj_panelPane.functionTree_treeLinkSelected = "";
		obj_chain.currentFocusedEntryID = "";
		
		var unitInChainsList = unitSubMap[?"inChainsList"];

		obj_control.rightClicked = true;
		obj_control.wideDropDown = true;
		var dropDownOptionList = ds_list_create();

		// Options for a word in a Chain
		if(ds_list_size(unitInChainsList) > 0){
					
			ds_list_add(dropDownOptionList,  "help_label_delete-link", "option_set-chain-name");
		
			for(var i = 0; i < ds_list_size(unitInChainsList); i++){
				var chainID = unitInChainsList[|i];
				var chainSubMap = global.nodeMap[?chainID];
				if(scr_isNumericAndExists(chainSubMap, ds_type_map)){
					var chainType = chainSubMap[?"type"];
					obj_control.inChain = true;
				}
			
				// check whether we should refocus this word's entry or not
				var refocusEntry = (chainType == "stack") or (obj_toolPane.currentMode == obj_toolPane.modeRead);
				
				if(refocusEntry){
					obj_chain.currentFocusedChainID = chainID;
					scr_refocusChainEntry(obj_control.rightClickID);
				}
			}
					
		}
		
		ds_list_add(dropDownOptionList, "tab_name_tag" ,"option_create-tree");
				
		// Create the dropdown
		if (ds_list_size(dropDownOptionList) > 0 and obj_control.ableToCreateDropDown) {
			scr_createDropDown(mouse_x, mouse_y, dropDownOptionList, global.optionListTypeSpeakerLabel);
		}
	}
}