/// @description create dialogue boxes
if (!instance_exists(obj_dialogueBox)) {
	if (confirmStackName) {
		var confirmStackNameDefStr = scr_get_translation(stackerMode);
		if (stackerMode == "participant") confirmStackNameDefStr = scr_get_translation("menu_turn");
		
		
		
		global.inputBoxDefStr = scr_get_translation(confirmStackNameDefStr);
		var inst = instance_create_layer(0, 0, "InstancesDialogue", obj_dialogueBox);
		inst.inputWindowActive = true;
	}
}