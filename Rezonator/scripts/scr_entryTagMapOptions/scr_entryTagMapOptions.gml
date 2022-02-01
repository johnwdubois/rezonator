function scr_entryTagMapOptions(optionSelected) {
	var tagID = obj_control.navWindowTaggingID;
	with(obj_inputBox) {
		show_debug_message("scr_entryTagMapOptions destroying input box from dd select");
		instance_destroy();
	}
	// check if user is clearing tag
	var clearTag = (optionSelected == "menu_clear");

	if (optionSelected == "option_add-to-tag-set"){

		obj_control.newCustomTagEntry = true;
		obj_control.dialogueBoxActive = true;

		if (!instance_exists(obj_dialogueBox)) {
			instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
		}
		obj_dialogueBox.inputWindowActive = true;
	
	}
	else {
		obj_control.navWindowTaggingID = tagID;
		show_debug_message("navWindowTaggingID: "+ string(obj_control.navWindowTaggingID));
		//tagging from nav window vs tagging from right click
		if(obj_control.navWindowTaggingID != ""){
			
			var entrySubMap = global.nodeMap[?obj_control.navWindowTaggingID];
			if(scr_isNumericAndExists(entrySubMap, ds_type_map)){
				var tagMap = entrySubMap[?"tagMap"];
				if(scr_isNumericAndExists(tagMap,ds_type_map)){
					var newTagValue = clearTag ? "" : optionSelected;
					tagMap[?obj_control.tokenFieldToChange] = newTagValue;
					show_debug_message("newTagValue: "+ string(newTagValue));
				}	
			}
		}
		else{
			show_debug_message("obj_control.rightClickID:  " + string(obj_control.rightClickID));
			var rightClickSubMap = global.nodeMap[?obj_control.rightClickID];
			if(scr_isNumericAndExists(rightClickSubMap,ds_type_map)){
		
				var inChainsList = rightClickSubMap[?"inChainsList"];
				var inChainsListSize = ds_list_size(inChainsList);
	
				for(var i = 0 ; i < inChainsListSize; i ++){
					var currentChainID = inChainsList[|i];
					var chainSubMap = global.nodeMap[?currentChainID];
					if(scr_isNumericAndExists(chainSubMap,ds_type_map)){
					
						var setIDList = chainSubMap[?"setIDList"];
						var setIDListSize = ds_list_size(setIDList);
					
						for(var j = 0; j < setIDListSize;j ++){
						
							var currentEntry = setIDList[|j];
							var entrySubMap = global.nodeMap[?currentEntry];
						
							var entryTokenID = entrySubMap[?"token"];
							//if we clicked on unit check unit of sub map
							if(entryTokenID != obj_control.rightClickID){
								entryTokenID = entrySubMap[?"unit"];
							}
							if(entryTokenID == obj_control.rightClickID){
								var tagMap = entrySubMap[?"tagMap"];
								if(scr_isNumericAndExists(tagMap,ds_type_map)){
									var newTagValue = clearTag ? "" : optionSelected;
									tagMap[?obj_control.tokenFieldToChange] = newTagValue;
								}	
							}
						}
					}
				}
			}
		}
		
		if (!clearTag) {
			with(obj_panelPane){
				functionField_entryTagSelected = optionSelected;
				functionField_entryFieldSelected = obj_control.tokenFieldToChange;
			}
		}
		
		obj_control.tokenFieldToChange = "";
		obj_control.tokenToChange = "";
		
	}
	with(obj_dropDown){
		instance_destroy();
	}
}
