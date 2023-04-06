function scr_createDialogBox(type, _cancelOption = false, _noOption = false){
	
	// create dialog box
	if (!instance_exists(obj_dialogueBox)) {
		instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
	}
	
	// want to change this eventually so we don't have to use alertWindowActive/questionWindowActive...
	if (!_cancelOption && !_noOption) {
		with (obj_dialogueBox) alertWindowActive = true;
	}
	else if (_cancelOption && !_noOption) {
		with (obj_dialogueBox) questionWindowActive = true;
	}
	
	// set type & options
	with (obj_selectControl) {
		dialogBoxType = type;
		cancelOption = _cancelOption;
		noOption = _noOption;
	}

}