var optionSelected = argument0;

switch (optionSelected)
{
	case "Delete All Stacks":
			

		if (!instance_exists(obj_dialogueBox)) {
			instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
			obj_dialogueBox.clearAllStacks = true;
			obj_dialogueBox.questionWindowActive = true;
		}
		
			
	//	show_message("Coming Soon");
		break;
	case "Delete All Rez Chains":
		

		if (!instance_exists(obj_dialogueBox)) {
			instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
			obj_dialogueBox.clearAllRez = true;
			obj_dialogueBox.questionWindowActive = true;
		}
		

		break;
	case "Delete All Track Chains":
		

		if (!instance_exists(obj_dialogueBox)) {
			instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
			obj_dialogueBox.clearAllTracks = true;
			obj_dialogueBox.questionWindowActive = true;
		}
		
		
		//show_message("Coming Soon");
		break;
	case "Delete All":
		

		if (!instance_exists(obj_dialogueBox)) {
			instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
			obj_dialogueBox.clearAllLinks = true;
			obj_dialogueBox.questionWindowActive = true;
		}
		
			
		//show_message("Coming Soon");
		break;
	case "Add Tag Category":
		

		if (!instance_exists(obj_dialogueBox)) {
			instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
			obj_dialogueBox.clearAllLinks = true;
			obj_dialogueBox.questionWindowActive = true;
		}
		
			
		//show_message("Coming Soon");
		break;
	case "Developer":
		show_message("Coming Soon");
	break;
	case "Shuffle":
		show_message("Coming Soon");
	break;
	default:
		break;
}