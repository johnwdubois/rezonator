function scr_searchOptions(optionSelected) {

	switch (optionSelected)
	{
		case "menu_keyword": // search for words
		
			obj_control.preSwitchDisplayRow = obj_control.scrollPlusYDest;
			if (!obj_control.dialogueBoxActive) {
				keyboard_string = "";
				obj_control.fPressed = true;
			}


			obj_control.dialogueBoxActive = true;

			if (!instance_exists(obj_dialogueBox)) {
				instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
			}
			obj_dialogueBox.inputWindowActive = true;

			break;

		case "menu_clear":// clear search
			
			with(obj_panelPane){
			
				functionSearchList_searchSelected = "";
			
			}
			scr_disableFilter();

			break;

		default:
			break;
	}


}
