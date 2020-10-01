function scr_createStackOptions(argument0) {
	//if (live_call(argument0)) return live_result;
	
	var optionSelected = argument0;
	var confirmStack = false;
	var doStacksExist = (ds_grid_height(obj_chain.stackChainGrid) > 0);
	
	obj_stacker.createStacksRandom = false;
	obj_stacker.createStacksTurn = false;
	obj_stacker.createStacksSentence = false;
	

	switch (optionSelected)
	{	
	
		case "Default":
			// need to make this into custom message
			show_message("Click or Drag on Speaker Labels to create default stacks.");
			if(obj_toolPane.currentMode == obj_toolPane.modeRead ) {
				obj_toolPane.currentMode = obj_toolPane.modeTrack;	
			}
			obj_control.mouseoverPanelPane = false;
			instance_destroy(obj_dropDown);
			break;
		case "Random":
			if (doStacksExist) {
				confirmStack = true;
			}
			else {
				obj_stacker.splitSave = true;
				obj_stacker.alarm[1] = 1;
			}
			obj_stacker.createStacksRandom = true;
			break;
		case "Turn":
			if (doStacksExist) {
				confirmStack = true;
			}
			else {
				obj_stacker.splitSave = true;
				obj_stacker.alarm[4] = 1;
			}
			obj_stacker.createStacksTurn = true;
			break;
		case "Sentence":
			if (doStacksExist) {
				confirmStack = true;
			}
			else {
				obj_stacker.showEndNoteWindow = true;
			}
			obj_stacker.createStacksSentence = true;
			break;
		default:
			break;
	}
	
	if (confirmStack) {
		obj_stacker.confirmStackCreate = true;
	}

}