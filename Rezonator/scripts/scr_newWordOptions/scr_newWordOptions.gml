function scr_newTokenOptions(optionSelected) {

	switch (optionSelected)
	{
		case "<0>":
			obj_control.newWordPre1 = true;
			obj_control.currentNewWordPre = 1;
			if (device_mouse_check_button_released(0, mb_left) and not obj_control.dialogueBoxActive) {				
					if (!obj_control.dialogueBoxActive) {
						keyboard_string = "";
						obj_control.newWordCreated =true;
					}

					obj_control.fromDropDown = true;
					obj_control.dialogueBoxActive = true;

					if (!instance_exists(obj_dialogueBox)) {
						instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
					}
					obj_dialogueBox.inputWindowActive = true;

			}
			obj_control.rightClicked = false;
			instance_destroy();
			break;
		case "<ZERO>":
			obj_control.newWordPre2 = true;
			obj_control.currentNewWordPre = 2;
			if (device_mouse_check_button_released(0, mb_left) and not obj_control.dialogueBoxActive) {				
					if (!obj_control.dialogueBoxActive) {
						keyboard_string = "";
						obj_control.newWordCreated =true;
					}

					obj_control.fromDropDown = true;
					obj_control.dialogueBoxActive = true;

					if (!instance_exists(obj_dialogueBox)) {
						instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
					}
					obj_dialogueBox.inputWindowActive = true;

			}
			obj_control.rightClicked = false;

			break;
		case "<PRO>":	
			obj_control.currentNewWordPre = 3;
			obj_control.newWordPre3 = true;
			if (device_mouse_check_button_released(0, mb_left) and not obj_control.dialogueBoxActive) {				
					if (!obj_control.dialogueBoxActive) {
						keyboard_string = "";
						obj_control.newWordCreated =true;
					}

					obj_control.fromDropDown = true;
					obj_control.dialogueBoxActive = true;

					if (!instance_exists(obj_dialogueBox)) {
						instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
					}
					obj_dialogueBox.inputWindowActive = true;

			}
			obj_control.rightClicked = false;

			break;
		case "Custom":
			obj_control.currentNewWordPre = 4;
			if (device_mouse_check_button_released(0, mb_left) and not obj_control.dialogueBoxActive) {				
				if (!obj_control.dialogueBoxActive) {
					keyboard_string = "";
					obj_control.newWordCreated =true;
				}

				obj_control.fromDropDown = true;
				obj_control.dialogueBoxActive = true;

				if (!instance_exists(obj_dialogueBox)) {
					instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
				}
				obj_dialogueBox.inputWindowActive = true;
			}
			obj_control.rightClicked = false;

			break;
		default:
			break;
	}
	with(obj_dropDown){
		instance_destroy();
	}


}
