function scr_deleteOptions(optionSelected) {

	switch (optionSelected)
	{
		case "Stacks":
			

			if (!instance_exists(obj_dialogueBox)) {
				instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
				obj_dialogueBox.clearAllStacks = true;
				obj_dialogueBox.questionWindowActive = true;
			}
		
			
		//	show_message("Coming Soon");
			break;
		case "Rez Chains":
		

			if (!instance_exists(obj_dialogueBox)) {
				instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
				obj_dialogueBox.clearAllRez = true;
				obj_dialogueBox.questionWindowActive = true;
			}
		

			break;
		case "Track Chains":
		

			if (!instance_exists(obj_dialogueBox)) {
				instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
				obj_dialogueBox.clearAllTracks = true;
				obj_dialogueBox.questionWindowActive = true;
			}
		
		
			//show_message("Coming Soon");
			break;
		case "Chains":
		

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
