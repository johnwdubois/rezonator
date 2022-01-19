

function scr_chunk1To1TagOptions(optionSelected){
	
	// check if user is clearing tag
	var clearTag = (optionSelected == "menu_clear");
	
	// check to see if the user is trying to create a new tag
	if (optionSelected == "option_add-to-tag-set") {
		obj_control.newCustomTagChunk = true;
		obj_control.dialogueBoxActive = true;

		if (!instance_exists(obj_dialogueBox)) {
			instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
		}
		obj_dialogueBox.inputWindowActive = true;
		exit;
	}
	
	
	show_debug_message("scr_chunk1To1TagOptions, optionSelected: " + string(optionSelected));
	
	// get chunk's submap and make sure it exists
	var chunkSubMap = global.nodeMap[? obj_control.chunk1to1ChunkToChange];
	if (!scr_isNumericAndExists(chunkSubMap, ds_type_map)) exit;
	var chunkTagMap = chunkSubMap[? "tagMap"];
	if (!scr_isNumericAndExists(chunkTagMap, ds_type_map)) exit;
	
	// set the chunk tag
	var newTagValue = clearTag ? "" : optionSelected;
	chunkTagMap[? obj_control.chunk1to1FieldToChange] = newTagValue;
	
	if (!clearTag) {
		with(obj_panelPane){
			functionField_chunkTagSelected = optionSelected;
			functionField_chunkFieldSelected = obj_control.chunk1to1FieldToChange;
		}
	}
	
}