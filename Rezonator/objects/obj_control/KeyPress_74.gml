///@description "Normal" textAlign
if (!shortcutsEnabled || dialogueBoxActive) {
	exit;
}

if (not keyboard_check(vk_shift) and not keyboard_check(vk_alt)) {
	scr_justifyWords();
}