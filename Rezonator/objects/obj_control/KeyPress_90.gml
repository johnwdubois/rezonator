/// @description Insert description here
// You can write your code in this editor
/// @description quick zero
// You can write your code in this editor

if(!obj_control.dialogueBoxActive){
	if(obj_control.hoverTokenID != ""){
		var fillWord = "";
		/*
		if(obj_control.currentNewWordPre == 1){
			fillWord = scr_get_translation("option_zero-0");
		}
		else if(obj_control.currentNewWordPre == 2){
			fillWord = scr_get_translation("option_zero");
		}
		else if(obj_control.currentNewWordPre == 3){
			fillWord = scr_get_translation("option_pronoun");
		}
		else if(obj_control.currentNewWordPre == 4){
			fillWord = obj_control.lastAddedWord;
		}
		else{
			*/
			fillWord = scr_get_translation("option_zero-0");
		//}
		obj_control.before = true;
		scr_newToken(fillWord,obj_control.hoverTokenID);
	}
}