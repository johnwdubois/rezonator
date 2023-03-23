/// @description next input box
if (windowFocused && canSwitchToNext && instance_exists(obj_dialogueBox)) {
	
	with (obj_inputBox) {
		canSwitchToNext = false;
		alarm[2] = 1;
	}
	
	var _inputBoxList = obj_dialogueBox.inputBoxList;
	if (scr_isNumericAndExists(_inputBoxList, ds_type_list)) {
		if (ds_list_size(_inputBoxList) >= 2) {
			var myIndex = ds_list_find_index(_inputBoxList, self.id);
			var nextIndex = myIndex + 1 >= ds_list_size(_inputBoxList) ? 0 : myIndex + 1;
			var nextInputBox = _inputBoxList[| nextIndex];
			if (instance_exists(nextInputBox)) {
				with (nextInputBox) windowFocused = true;
			}
		}
		windowFocused = false;
	}
}