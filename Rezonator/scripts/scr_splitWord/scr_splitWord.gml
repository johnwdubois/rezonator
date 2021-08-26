function scr_splitWord(stringList) {

	var listOfWords = ds_list_create();

	listOfWords = scr_splitString(stringList, ",");

	if(ds_list_size(listOfWords) < 2){
		show_message(scr_get_translation("msg_not-enough-words"));
		exit;
	}

	if(obj_control.fromDropDown){
		var firstWord = ds_list_find_value(listOfWords, 0);
		if (firstWord == "") {
			firstWord = "NULL";
		}
	}
	else{
		var newWord = ds_list_find_value(listOfWords, 0);
		if (newWord == "") {
			newWord = "NULL";
		}
	}


	if(obj_control.fromDropDown){
		scr_newToken(obj_control.rightClickUnitID, obj_control.rightClickWordSeq, ds_list_find_value(listOfWords, 1), obj_control.rightClickWordID+1);
	}
	else{
		scr_newToken(obj_control.newWordHoverUnitID, obj_control.newWordHoverWordSeq, ds_list_find_value(listOfWords, 1), obj_control.rightClickWordID+1);
	}





}
