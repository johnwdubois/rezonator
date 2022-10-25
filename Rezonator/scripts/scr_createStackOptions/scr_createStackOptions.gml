function scr_createStackOptions(optionSelected) {

	
	var confirmStack = false;
	var stackChainList = global.nodeMap[? "stackList"];
	var doStacksExist = (ds_list_size(stackChainList) > 0);
	
	obj_stacker.stackerMode = "";
	

	switch (optionSelected) {	
	
		case "Default":
			// need to make this into custom message
			show_message(scr_get_translation("msg_drag-speaker"));
			if(obj_toolPane.currentMode == obj_toolPane.modeRead ) {
				obj_toolPane.currentMode = obj_toolPane.modeTrack;	
			}
			obj_control.mouseoverPanelPane = false;
			instance_destroy(obj_dropDown);
			break;
		case "menu_random":
			if (doStacksExist) {
				confirmStack = true;
			}
			else {
				//obj_stacker.splitSave = true;
				//obj_stacker.alarm[1] = 1;
			}
			obj_stacker.stackerMode = "menu_random";
			instance_destroy(obj_dropDown);
			break;
		case "menu_turn":
			if (doStacksExist) {
				confirmStack = true;
			}
			else {
				//obj_stacker.splitSave = true;
				//obj_stacker.alarm[4] = 1;
			}
			obj_stacker.stackerMode = "menu_turn";
			instance_destroy(obj_dropDown);
			break;
		case "tag_group":
			if (doStacksExist) {
				confirmStack = true;
			}
			else {
				//obj_stacker.splitSave = true;
				//obj_stacker.alarm[8] = 1;
			}
			obj_stacker.stackerMode = "tag_group";
			instance_destroy(obj_dropDown);
			break;
		case "Unit Label":
			if (doStacksExist) {
				confirmStack = true;
			}
			else {
				//obj_stacker.splitSave = true;
				//obj_stacker.alarm[6] = 1;
			}
			obj_stacker.stackerMode = "sentence";
			instance_destroy(obj_dropDown);
			break;
		case "menu_utterance":
			if (doStacksExist) {
				confirmStack = true;
			}
			else {
				//obj_stacker.splitSave = true;
				//obj_stacker.alarm[10] = 1;
			}
			obj_stacker.stackerMode = "menu_utterance";
			instance_destroy(obj_dropDown);
			break;
		case "menu_clique":
			if (doStacksExist) {
				confirmStack = true;
			}
			else {
				//obj_stacker.alarm[9] = 1;
			}
			obj_stacker.stackerMode = "menu_clique";
			instance_destroy(obj_dropDown);
			break;
		default:
			break;
	}
	
	
	
	if (confirmStack) {
		obj_stacker.confirmStackCreate = true;
	}
	else {
		obj_stacker.confirmStackName = true;
	}

}