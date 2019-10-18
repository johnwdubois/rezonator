///@description "Normal" textAlign
if (!shortcutsEnabled || dialogueBoxActive) {
	exit;
}

if (not keyboard_check(vk_shift) and not keyboard_check(vk_alt)) {
	if(obj_control.shapeStartText == true) {
		obj_control.shapeStartText = false;
		//obj_control.shape = obj_control.shapeBlock;
	}
	if (shape == shapeBlock) {
		shape = shapeText;
	}
	else {
		shape = shapeBlock;
	}
}