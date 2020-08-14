if (obj_control.splitWord) {
	scr_splitWord(obj_control.inputText);
}
else{
	if (obj_control.inputText == "") {
		obj_control.inputText = "NULL";
	}
	if(obj_control.fromDropDown){
		scr_replaceWord(obj_control.rightClickWordID, obj_control.inputText);
	}
	else{
		scr_replaceWord(obj_control.newWordHoverWordID, obj_control.inputText);
	}
}