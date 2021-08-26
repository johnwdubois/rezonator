function scr_newTokenOptions(optionSelected) {

	switch (optionSelected)
	{
		case "option_zero-0":
			//obj_control.newWordPre1 = true;
			obj_control.currentNewWordPre = 1;
			
				
			scr_newToken(scr_get_translation("option_zero-0"), obj_control.rightClickID);
			obj_control.alarm[11] = 60;

		
			obj_control.rightClicked = false;
			instance_destroy();
			break;
		case "option_zero":

			obj_control.currentNewWordPre = 2;
			scr_newToken(scr_get_translation("option_zero"), obj_control.rightClickID);
			obj_control.alarm[11] = 60;
			obj_control.rightClicked = false;

			break;
		case "option_pronoun":	
			obj_control.currentNewWordPre = 3;
			scr_newToken(scr_get_translation("option_pronoun"), obj_control.rightClickID);
			obj_control.alarm[11] = 60;
			obj_control.rightClicked = false;

			break;
		case "option_custom":
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
