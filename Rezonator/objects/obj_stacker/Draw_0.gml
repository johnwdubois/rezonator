/// @description create dialogue boxes
if (!instance_exists(obj_dialogueBox)) {
	if (confirmStackCreate) {
		var inst = instance_create_layer(0, 0, "InstancesDialogue", obj_dialogueBox);
		inst.questionWindowActive = true;
	}
	else if (confirmStackName) {
		global.inputBoxDefStr = scr_get_translation(stackerMode);
		var inst = instance_create_layer(0, 0, "InstancesDialogue", obj_dialogueBox);
		inst.inputWindowActive = true;
	}
}