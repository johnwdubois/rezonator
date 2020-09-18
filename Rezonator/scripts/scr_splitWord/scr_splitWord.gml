function scr_splitWord(argument0) {
	/*
		scr_splitWord();
	
		Last Updated: 2019-08-14
	
		Called from: obj_dialogueBox
	
		Purpose: to turn one word into two words in the discourse
	
		Mechanism: calls replaceWord() and newWord() in one script to make two new user generated words
				
		Author: Brady Moore
	*/


	var stringList = argument0;

	var listOfWords = ds_list_create();

	listOfWords = scr_splitString(stringList, ",");

	if(ds_list_size(listOfWords) < 2){
		show_message("not enough words entered");
		exit;
	}
	//show_message(string(obj_control.newWordHoverWordSeq));
	if(obj_control.fromDropDown){
		var firstWord = ds_list_find_value(listOfWords, 0);
		if (firstWord == "") {
			firstWord = "NULL";
		}
		scr_replaceWord(obj_control.rightClickWordID,firstWord);
	}
	else{
		var newWord = ds_list_find_value(listOfWords, 0);
		if (newWord == "") {
			newWord = "NULL";
		}
		scr_replaceWord(obj_control.newWordHoverWordID, newWord);
	}


	//obj_toolPane.currentTool = obj_toolPane.toolNewWord;

	if(obj_control.fromDropDown){
		scr_newWord(obj_control.rightClickUnitID, obj_control.rightClickWordSeq,ds_list_find_value(listOfWords, 1));
	}
	else{
		scr_newWord(obj_control.newWordHoverUnitID, obj_control.newWordHoverWordSeq,ds_list_find_value(listOfWords, 1));
	}





}
