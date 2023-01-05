function scr_helpOptions(optionSelected) {
	//helpOptions

	switch (optionSelected)
	{
		case "menu_help":
			obj_panelPane.functionHelp_collapsed = !obj_panelPane.functionHelp_collapsed;
			break;
		case "menu_guide":
			if (!instance_exists(obj_dialogueBox)) {
				instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
				obj_dialogueBox.questionWindowActive = true;
				obj_control.openURLGuide = true;
			}
			
			break;
		case "menu_about":
			if (!instance_exists(obj_dialogueBox)) {
				instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
				obj_dialogueBox.questionWindowActive = true;
				obj_control.openURLAbout = true;
			}
			
			break;
			
		case "menu_check-updates":
			show_debug_message("Checking for update...");
			
			break;
		default:
			break;
	}



}
