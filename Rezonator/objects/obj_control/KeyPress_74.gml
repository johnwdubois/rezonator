///@description "Normal" textAlign
if (!shortcutsEnabled || dialogueBoxActive) {
	exit;
}

if (not keyboard_check(vk_shift) and not keyboard_check(vk_alt)) {
	var justifyOption = (justify == justifyLeft) ? "menu_right" : "menu_left";
	scr_justifyOptions(justifyOption);
}