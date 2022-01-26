function scr_tokenTagMapOptions(optionSelected) {
	
	with(obj_inputBox) {
		show_debug_message("destroying input box from dd select");
		instance_destroy();
	}
	// check if user is clearing tag
	var clearTag = (optionSelected == "menu_clear");

	if (optionSelected == "option_add-to-tag-set"){

		obj_control.newCustomTagToken = true;
		obj_control.dialogueBoxActive = true;

		if (!instance_exists(obj_dialogueBox)) {
			instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
		}
		obj_dialogueBox.inputWindowActive = true;
	
	}
	else {
		show_debug_message(" scr_tokenTagMapOptions    token to change: " + string(obj_control.tokenToChange));
		var repeatAmount = 1;
		var repeatCounter = 0;
		if(obj_control.multiWordTag){
			var searchSubMap = global.searchMap[? obj_panelPane.functionSearchList_searchSelected];
			if (scr_isNumericAndExists(searchSubMap, ds_type_map)) {
				var selectedTokenList = searchSubMap[? "selectedTokenList"];
			}
			else{
				instance_destroy(obj_dropDown);
				exit;
			}
			repeatAmount = ds_list_size(selectedTokenList);
		}
		repeat(repeatAmount){
			if(obj_control.multiWordTag){
				obj_control.tokenToChange = selectedTokenList[|repeatCounter]
			}
			// get the tokenToChange's submap, and that token's tagmap
			var tokenSubMap = global.nodeMap[? obj_control.tokenToChange];
			var type = "";
			if(scr_isNumericAndExists(tokenSubMap,ds_type_map)){
				type = tokenSubMap[?"type"];
				var tokenTagMap = tokenSubMap[? "tagMap"];
				// set the new value in this token's tagmap
				if(global.steamAPI){
					if(!steam_get_achievement("SA_tag-token")){
						steam_set_achievement("SA_tag-token");
					}
				}
				var newTagValue = clearTag ? "" : optionSelected;
				tokenTagMap[? obj_control.tokenFieldToChange] = newTagValue;
			}
			
			if (!clearTag) {
				with(obj_panelPane){
					if(type == "token"){
						functionField_tokenTagSelected = optionSelected;
						functionField_tokenFieldSelected = obj_control.tokenFieldToChange;
					}
					else{
						functionField_chunkTagSelected = optionSelected;
						functionField_chunkFieldSelected = obj_control.tokenFieldToChange;
					}
				}
			}
			repeatCounter++;
		}
		
		obj_control.tokenFieldToChange = "";
		obj_control.tokenToChange = "";
		obj_control.multiWordTag = false;
	}
	with(obj_dropDown){
		instance_destroy();
	}
}
