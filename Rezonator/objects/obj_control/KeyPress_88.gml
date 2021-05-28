/// @description Insert description here
// You can write your code in this editor
if(!obj_control.dialogueBoxActive){
	if(obj_control.hoverTokenID != ""){
		var fillWord = "";
		if(obj_control.currentNewWordPre == 1){
			fillWord = "<0>";
		}
		else if(obj_control.currentNewWordPre == 2){
			fillWord = "<ZERO>";
		}
		else if(obj_control.currentNewWordPre == 3){
			fillWord = "<PRO>";
		}
		else if(obj_control.currentNewWordPre == 4){
			fillWord = obj_control.lastAddedWord;
		}
		else{
			fillWord = "<0>";
		}
		obj_control.before = false;
		scr_newToken(fillWord,obj_control.hoverTokenID);
	}
}