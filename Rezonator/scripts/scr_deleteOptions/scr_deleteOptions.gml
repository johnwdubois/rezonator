function scr_deleteOptions(optionSelected) {

	switch (optionSelected)
	{
		case "menu_stacks_pl":
			

			if (!instance_exists(obj_dialogueBox)) {
				instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
				obj_dialogueBox.clearAllStacks = true;
				obj_dialogueBox.questionWindowActive = true;
			}
		
			
		//	show_message("Coming Soon");
			break;
		case "menu_rez_chains_pl":
		

			if (!instance_exists(obj_dialogueBox)) {
				instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
				obj_dialogueBox.clearAllRez = true;
				obj_dialogueBox.questionWindowActive = true;
			}
		

			break;
		case "menu_track_chains_pl":
		

			if (!instance_exists(obj_dialogueBox)) {
				instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
				obj_dialogueBox.clearAllTracks = true;
				obj_dialogueBox.questionWindowActive = true;
			}
		
		
			//show_message("Coming Soon");
			break;
		case "menu_chains_pl":
		

			if (!instance_exists(obj_dialogueBox)) {
				instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
				obj_dialogueBox.clearAllLinks = true;
				obj_dialogueBox.questionWindowActive = true;
			}
		
			
			//show_message("Coming Soon");
			break;
		
			default:
			break;
		
	}


}
