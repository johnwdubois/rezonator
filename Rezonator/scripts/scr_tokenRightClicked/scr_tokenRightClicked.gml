// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_tokenRightClicked(){
	
	if (instance_exists(obj_control) and !instance_exists(obj_dialogueBox)) {
		
		var tokenSubMap = global.nodeMap[?obj_control.rightClickTokenID];
		if(!scr_isNumericAndExists(tokenSubMap, ds_type_map)){exit;}
		
		var tokenInChainsList = tokenSubMap[?"inChainsList"];
		var unitID = tokenSubMap[?"unit"]
		
		var unitSubMap = global.nodeMap[?unitID];
		var entryList = unitSubMap[?"entryList"];
		var firstEntry = entryList[|0];
		var firstEntrySubMap = global.nodeMap[?firstEntry];
		
		obj_control.rightClickonWord = true;
		obj_control.wideDropDown = true;
		var dropDownOptionList = ds_list_create();
			
		// check if this is the first word in its line

		var firstWordInLine = (firstEntrySubMap[?"token"] == obj_control.rightClickTokenID);

		

		// Options for a word in a Chain
		if(ds_list_size(tokenInChainsList) > 0){
			if(obj_control.searchGridActive){
				ds_list_add(dropDownOptionList, "Delete Link");
			}
			else{
				//"Split Word", "New Word",
				ds_list_add(dropDownOptionList,  "Delete Link");
				if (!firstWordInLine && obj_control.showDevVars) {
					ds_list_add(dropDownOptionList, "Split Line");
				}
			}

			//ds_list_add(dropDownOptionList, "Delete New Word", "Replace Word", "Restore Word");

			
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
					scr_refocusChainEntry(obj_control.rightClickTokenID);
				}
			}
					
		}
		// Options for a chainless word
		else{
			if(obj_control.searchGridActive){
				obj_control.ableToCreateDropDown = false;
			}
			else{

				//ds_list_add(dropDownOptionList, "Split Word", "New Word");
				if (!firstWordInLine && obj_control.showDevVars) {
					ds_list_add(dropDownOptionList, "Split Line");
				}
				
			}

			//ds_list_add(dropDownOptionList, "Delete Word", "Replace Word");
			
		}
				
		// Create the dropdown
		if (ds_list_size(dropDownOptionList) > 0 and obj_control.ableToCreateDropDown) {
			scr_createDropDown(mouse_x, mouse_y, dropDownOptionList, global.optionListTypeRightClickWord);
		}
	}
}