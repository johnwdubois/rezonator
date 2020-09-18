function scr_dialogueBoxNewTagCategory() {
	// Will instead input this string into a column in the Tag grid
	if (obj_panelPane.tokenContentsHeaderListSize == 4) {
		obj_control.dynamicWordGrid_colTag1Label = obj_control.inputText;
	}
	else if (obj_panelPane.tokenContentsHeaderListSize == 5) {
		obj_control.dynamicWordGrid_colTag2Label = obj_control.inputText;
	}
	else {
		obj_control.dynamicWordGrid_colTag3Label = obj_control.inputText;
	}


}
