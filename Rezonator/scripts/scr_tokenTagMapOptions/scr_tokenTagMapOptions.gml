function scr_tokenTagMapOptions(optionSelected) {

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
		// get the tokenToChange's submap, and that token's tagmap
		var tokenSubMap = global.nodeMap[? obj_control.tokenToChange];
		var type = "";
		if(scr_isNumericAndExists(tokenSubMap,ds_type_map)){
			type = tokenSubMap[?"type"];
			var tokenTagMap = tokenSubMap[? "tagMap"];
			show_debug_message(string(obj_control.tokenFieldToChange));
			// set the new value in this token's tagmap
			if(global.steamAPI){
				if(!steam_get_achievement("SA_tag-token")){
					steam_set_achievement("SA_tag-token");
				}
			}
			tokenTagMap[? obj_control.tokenFieldToChange] = optionSelected;
		}
		
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
		
		obj_control.tokenFieldToChange = "";
		obj_control.tokenToChange = "";
	}
	with(obj_dropDown){
		instance_destroy();
	}
}
