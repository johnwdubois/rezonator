function scr_helpOptions(optionSelected) {
	//helpOptions

	switch (optionSelected)
	{
		case "menu_help":// hide/show track chains
			obj_panelPane.functionHelp_collapsed = !obj_panelPane.functionHelp_collapsed;
			break;
		case "menu_guide":// hide/show rez chains
			if (!instance_exists(obj_dialogueBox)) {
				instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
				obj_dialogueBox.questionWindowActive = true;
				obj_control.openURLGuide = true;
			}
			
			break;
		case "menu_about":// hide/show stack chains
			if (!instance_exists(obj_dialogueBox)) {
				instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
				obj_dialogueBox.questionWindowActive = true;
				obj_control.openURLAbout = true;
			}
			
			break;
		default:
			break;
	}



}
