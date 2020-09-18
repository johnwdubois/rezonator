function scr_searchOptions(argument0) {
	var optionSelected = argument0;

	switch (optionSelected)
	{
		case "Word": // search for words
		
			obj_control.preSwitchDisplayRow = obj_control.scrollPlusYDest;
			if (!obj_control.dialogueBoxActive) {
				keyboard_string = "";
				obj_control.fPressed = true;
			}


			obj_control.dialogueBoxActive = true;

			if (!instance_exists(obj_dialogueBox)) {
				instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
			}

		
			//show_message("BUH 1");
			break;

		case "Time":// go to time
		
			scr_jumpToLineCalled();
			obj_control.goToTime = true;
			
			//show_message("BUH 5");
			break;
		case "Line": // got to line
		
			scr_jumpToLineCalled();
			
			//show_message("BUH 5");
			break;
		default:
			break;
	}


}
