function scr_dialogueBoxReplace() {
	if (obj_control.splitWord) {
		scr_splitWord(obj_control.inputText);
	}
	else{
		if (obj_control.inputText == "") {
			obj_control.inputText = "NULL";
		}
	}


}
