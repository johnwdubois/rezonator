/// @description Insert description here
// You can write your code in this editor
if (confirmStackCreate && !instance_exists(obj_dialogueBox)) {
	var inst = instance_create_layer(0, 0, "InstancesDialogue", obj_dialogueBox);
	inst.questionWindowActive = true;
}