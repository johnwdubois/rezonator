// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_chain1To1HeaderRightClickOptions(optionSelected){
	
	switch (optionSelected) {
		case "Create new field":
			
			obj_control.newCustomFieldChain = true;
			obj_control.dialogueBoxActive = true;

			if (!instance_exists(obj_dialogueBox)) {
				instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
			}
			obj_dialogueBox.inputWindowActive = true;
			exit;

			break;
		default:
			break;
	}

}