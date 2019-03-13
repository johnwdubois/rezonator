if (instance_exists(obj_input_text)) {
	exit;
}

if (not keyboard_check(vk_shift) and not keyboard_check(vk_alt)) {
	if (shape == shapeBlock) {
		shape = shapeText;
	}
	else {
		shape = shapeBlock;
	}
}