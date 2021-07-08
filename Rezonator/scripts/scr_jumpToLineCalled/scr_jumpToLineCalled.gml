function scr_jumpToLineCalled() {


	if (!obj_control.shortcutsEnabled || obj_control.dialogueBoxActive || obj_panelPane.discoSelectionActive) {
		exit;
	}


	if (!obj_control.dialogueBoxActive) {
		keyboard_string = "";
		obj_control.gPressed = true;
	}



	

	obj_control.dialogueBoxActive =true;
	if (!instance_exists(obj_dialogueBox)) {
		instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
	}
	obj_dialogueBox.inputWindowActive = true;
	obj_control.moveCounter++;


}
