

function scr_triggerSearch() {

	
	with (obj_control) {
		if (!shortcutsEnabled || obj_panelPane.discoSelectionActive || mouseoverTagShortcut != ""
		|| instance_exists(obj_dropDown) || instance_exists(obj_dialogueBox) || gridView || keyboard_check(vk_alt)) {
			exit;
		}


		preSwitchDisplayRow = obj_control.scrollPlusYDest;
		preSwitchSearchDisplayRow = 0;

		if (!obj_control.dialogueBoxActive) {
			keyboard_string = "";
			fPressed = true;
		}


		dialogueBoxActive = true;

		if (!instance_exists(obj_dialogueBox)) {
			instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
		}

		obj_dialogueBox.inputWindowActive = true;
	}

}