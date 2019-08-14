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

scr_replaceWord(obj_control.newWordHoverWordID,ds_list_find_value(listOfWords, 0));

//obj_toolPane.currentTool = obj_toolPane.toolNewWord;
scr_newWord(obj_control.newWordHoverUnitID, obj_control.newWordHoverWordSeq,ds_list_find_value(listOfWords, 1));

