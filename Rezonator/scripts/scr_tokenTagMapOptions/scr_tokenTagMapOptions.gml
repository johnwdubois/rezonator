function scr_tokenTagMapOptions(optionSelected) {

	if (optionSelected == "Add to tag set"){

		obj_control.newCustomTagToken = true;
		obj_control.dialogueBoxActive = true;

		if (!instance_exists(obj_dialogueBox)) {
			instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
		}
	
	}
	else {
		
		// get the tokenToChange's submap, and that token's tagmap
		var tokenSubMap = global.nodeMap[? obj_control.tokenToChange];
		var tokenTagMap = tokenSubMap[? "tagMap"];
		
		// set the new value in this token's tagmap
		tokenTagMap[? obj_control.tokenFieldToChange] = optionSelected;
		
	}

}
