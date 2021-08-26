/// @description Export portion
// You can write your code in this editor
//if (!shortcutsEnabled || dialogueBoxActive || obj_panelPane.discoSelectionActive) {
	exit;
//}

if(not keyboard_check(vk_alt) and not keyboard_check(vk_shift) and global.ctrlHold){

if (!obj_control.dialogueBoxActive) {
	keyboard_string = "";
	ePressed = true;
}

dialogueBoxActive = true;

if (!instance_exists(obj_dialogueBox)) {
	instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
}
obj_dialogueBox.inputWindowActive = true;	
	
}