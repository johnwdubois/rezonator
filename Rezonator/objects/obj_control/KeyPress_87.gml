///@description Transcript View
if (!shortcutsEnabled || dialogueBoxActive) {
	exit;
}

/*
if (keyboard_check(vk_control)) {
	
	if (showDevVars) {
		if (!instance_exists(obj_network)) {
			instance_create_layer(0, 0, "InstancesDialogue", obj_network);
		}
		with (obj_network) {
			scr_sendGridToServer(obj_control.wordGrid);
		}
	}
	exit;
}
*/

//On time out until we know what to do with it
//scr_toggleTranscription();