///@description "Normal" textAlign
if (!shortcutsEnabled || fPressed) {
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