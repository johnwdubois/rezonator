///@description Confirm Merge Chains
// You can write your code in this editor
if (!instance_exists(obj_dialogueBox)) {
	instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
	obj_dialogueBox.combineChains = true;
	obj_dialogueBox.questionWindowActive = true;
}