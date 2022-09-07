function scr_newTokenOptions(optionSelected) {

	if (optionSelected == "option_zero-0") {
		//obj_control.newWordPre1 = true;
		obj_control.currentNewWordPre = 1;
			
				
		scr_newToken(scr_get_translation("option_zero-0"), obj_control.rightClickID);
		obj_control.alarm[11] = 60;

		
		obj_control.rightClicked = false;
		instance_destroy();
	}
	else if (optionSelected == "option_zero") {

		obj_control.currentNewWordPre = 2;
		scr_newToken(scr_get_translation("option_zero"), obj_control.rightClickID);
		obj_control.alarm[11] = 60;
		obj_control.rightClicked = false;

	}
	else if (optionSelected == "option_pronoun") {
		obj_control.currentNewWordPre = 3;
		scr_newToken(scr_get_translation("option_pronoun"), obj_control.rightClickID);
		obj_control.alarm[11] = 60;
		obj_control.rightClicked = false;

	}
	else if (optionSelected == "option_custom") {
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
				
			// put in default custom string if there is one set
			if (obj_control.insertTokenStr != "" && is_string(obj_control.insertTokenStr)) {
				global.inputBoxDefStr = obj_control.insertTokenStr;
			}
		}
		obj_control.rightClicked = false;
	}
	else if (is_string(optionSelected)) {
		// for adding endnotes
		var beforeState = obj_control.before;
		obj_control.before = false;
		scr_newToken(optionSelected, obj_control.rightClickID);
		obj_control.alarm[11] = 60;
		obj_control.rightClicked = false;
		obj_control.before = beforeState;
	}

	with(obj_dropDown){
		instance_destroy();
	}


}
