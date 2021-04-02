// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_chain1ToManyHeaderRightClickOptions(optionSelected){
	
	switch (optionSelected) {
		case "Create Field":
			
			obj_control.newCustomFieldEntry = true;
			obj_control.dialogueBoxActive = true;

			if (!instance_exists(obj_dialogueBox)) {
				instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
			}
			exit;

			break;
		default:
			break;
	}
	
}