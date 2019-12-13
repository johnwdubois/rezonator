///@description Transcript View
if (!shortcutsEnabled || dialogueBoxActive) {
	exit;
}

/*
if (keyboard_check(vk_control)) {
	
	if (showDevVars) {
		if (!instance_exists(obj_network)) {
			instance_create(0, 0, obj_network);
		}
		with (obj_network) {
			scr_sendGridToServer(obj_control.wordGrid);
		}
	}
	exit;
}
*/

scr_toggleTranscription();