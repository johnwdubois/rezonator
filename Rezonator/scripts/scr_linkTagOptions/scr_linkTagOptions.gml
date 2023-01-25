

function scr_linkTagOptions(optionSelected) {
	
	// check if user is clearing tag
	var clearTag = (optionSelected == "menu_clear");

	if (optionSelected == "msg_create_tag") {
		obj_control.newCustomTagLink = true;
		obj_control.dialogueBoxActive = true;
		obj_control.tokenFieldToChange = obj_control.linkFieldSelected;
								
		if (!instance_exists(obj_dialogueBox)) {
			instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
		}
		obj_dialogueBox.inputWindowActive = true;
	}
	else{
		var linkSubMap = global.treeMap[? obj_panelPane.functionTree_treeLinkSelected];
		if (!scr_isNumericAndExists(linkSubMap, ds_type_map)) exit;
		var linkTagMap = linkSubMap[? "tagMap"];
		if (!scr_isNumericAndExists(linkTagMap, ds_type_map)) exit;
		var newTagValue = clearTag ? "" : optionSelected;
		linkTagMap[? obj_control.linkFieldSelected] = newTagValue;
		if (!clearTag) {
			with(obj_panelPane) {
				functionField_linkFieldSelected = obj_control.linkFieldSelected;
				functionField_linkTagSelected = optionSelected;
			}
		}
	}
	with (obj_dropDown) instance_destroy();
	

}