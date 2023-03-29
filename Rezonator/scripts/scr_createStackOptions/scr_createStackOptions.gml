function scr_createStackOptions(optionSelected) {

	var optionIndex = ds_list_find_index(optionList, optionSelected);
	
	show_debug_message("scr_createStackOptions, optionSelected: " + string(optionSelected));
	if (!is_string(optionSelected)) {
		exit;
	}
	
	with (obj_stacker) stackerMode = "";
	var subDropDown = false;
	
	if (optionSelected == "menu_turn") {
		// if the user has both turndelim and participant, show another dropdown with both options
		var turnDelimValid = is_string(global.unitImportTurnDelimColName) && global.unitImportTurnDelimColName != "";
		var participantValid = is_string(global.participantField) && global.participantField != "";
		show_debug_message("turnDelimValid: " + string(turnDelimValid) + ", participantValid: " + string(participantValid));
		if (turnDelimValid && participantValid) {
			var dropDownOptionList = ds_list_create();
			ds_list_add(dropDownOptionList, "From participant labels", "From turn delimiter");
			scr_createDropDown(x + windowWidth, y + (optionSpacing * optionIndex), dropDownOptionList, global.optionListTypeTurnStacker);
			subDropDown = true;
		}
		else {
			// if they only have turndelim or only have participant, use the one they have
			if (turnDelimValid) obj_stacker.stackerMode = "menu_turn";
			else if (participantValid) obj_stacker.stackerMode = "participant";
		}
	}
	
	if (!subDropDown) {
		with (obj_stacker) {
			if (stackerMode == "") stackerMode = optionSelected;
			confirmStackName = true;
		}
		with (obj_dropDown) instance_destroy();
	}

}