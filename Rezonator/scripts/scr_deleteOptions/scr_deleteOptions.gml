function scr_deleteOptions(optionSelected) {

	switch (optionSelected)
	{
		case "menu_stacks_pl":
			

			if (!instance_exists(obj_dialogueBox)) {
				instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
				obj_dialogueBox.clearAllStacks = true;
				obj_dialogueBox.questionWindowActive = true;
			}
		

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

			break;
		// case "tab_name_chunk":
		// alexluu: https://github.com/johnwdubois/rezonator/issues/1500
		case "Chunks": //vs. "Chunk" ("tab_name_chunk")
		

			if (!instance_exists(obj_dialogueBox)) {
				instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
				obj_dialogueBox.clearAllChunks = true;
				obj_dialogueBox.questionWindowActive = true;
			}

			break;			
		case "Trees": //vs. "Tree" ("tab_name_tree")
		

			if (!instance_exists(obj_dialogueBox)) {
				instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
				obj_dialogueBox.clearAllTrees = true;
				obj_dialogueBox.questionWindowActive = true;
			}

			break;
		case "menu_chains_pl":
		

			if (!instance_exists(obj_dialogueBox)) {
				instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
				obj_dialogueBox.clearAllLinks = true;
				obj_dialogueBox.questionWindowActive = true;
			}

			break;
		
			default:
			break;
		
	}


}
