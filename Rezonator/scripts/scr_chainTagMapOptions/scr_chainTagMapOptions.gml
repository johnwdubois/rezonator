function scr_chainTagMapOptions(optionSelected) {

	if (optionSelected == "option_add-to-tag-set"){

		obj_control.newCustomTagChain = true;
		obj_control.dialogueBoxActive = true;

		if (!instance_exists(obj_dialogueBox)) {
			instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
		}
		obj_dialogueBox.inputWindowActive = true;
	
	}
	else {
		var rightClickSubMap = global.nodeMap[?obj_control.rightClickID];
		if(scr_isNumericAndExists(rightClickSubMap,ds_type_map)){
		
			var inChainsList = rightClickSubMap[?"inChainsList"];
			var inChainsListSize = ds_list_size(inChainsList);
	
			for(var i = 0 ; i < inChainsListSize; i ++){
				var currentChainID = inChainsList[|i];
				var chainSubMap = global.nodeMap[?currentChainID];
				if(scr_isNumericAndExists(chainSubMap,ds_type_map)){
					var tagMap = chainSubMap[?"tagMap"];
					if(scr_isNumericAndExists(tagMap,ds_type_map)){
						tagMap[?obj_control.tokenFieldToChange] = optionSelected;
					}
				}
			}
		}

		
		with(obj_panelPane){
			functionField_chainTagSelected = optionSelected;
			functionField_chainFieldSelected = obj_control.tokenFieldToChange;
		}
		
		obj_control.tokenFieldToChange = "";
		obj_control.tokenToChange = "";
	}
	with(obj_dropDown){
		instance_destroy();
	}
}
