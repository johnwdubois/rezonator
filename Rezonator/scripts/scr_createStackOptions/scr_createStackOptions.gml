function scr_createStackOptions(optionSelected) {

	var optionIndex = ds_list_find_index(optionList, optionSelected);
	var confirmStack = false;
	var stackChainList = global.nodeMap[? "stackList"];
	var doStacksExist = (ds_list_size(stackChainList) > 0);
	var noConfirm = false;
	
	obj_stacker.stackerMode = "";
	

	switch (optionSelected) {	
	
		case "Default":
			// need to make this into custom message
			show_message(scr_get_translation("msg_drag-speaker"));
			if (obj_toolPane.currentMode == obj_toolPane.modeRead ) {
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
			
			// if the user has both turndelim and participant, show another dropdown with both options
			if (is_string(global.unitImportTurnDelimColName) && global.unitImportTurnDelimColName != ""
			&& is_string(global.participantField) && global.participantField != "") {
				noConfirm = true;
				var dropDownOptionList = ds_list_create();
				ds_list_add(dropDownOptionList, "From participant labels", "From turn delimiter");
				scr_createDropDown(x + windowWidth, y + (optionSpacing * optionIndex), dropDownOptionList, global.optionListTypeTurnStacker);
			}
			else {
				if (doStacksExist) {
					confirmStack = true;
				}
				instance_destroy(obj_dropDown);
				
				// if they only have turndelim or only have participant, use the one they have
				if (is_string(global.unitImportTurnDelimColName) && global.unitImportTurnDelimColName != "") obj_stacker.stackerMode = "menu_turn";
				else if (is_string(global.participantField) && global.participantField != "") obj_stacker.stackerMode = "participant";
			}
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
	
	
	if (!noConfirm) {
		//if (confirmStack) {
		//	obj_stacker.confirmStackCreate = true;
		//}
		//else {
		//	obj_stacker.confirmStackName = true;
		//}
		obj_stacker.confirmStackName = true;
		with (obj_dropDown) instance_destroy();
	}

}