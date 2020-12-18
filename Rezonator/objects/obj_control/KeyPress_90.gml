/// @description Insert description here
// You can write your code in this editor
/// @description quick zero
// You can write your code in this editor
/*
if(keyboard_check(vk_control)){
	with(obj_panelPane){
		showNav = not showNav;	
				
	}
	obj_toolPane.showTool = !obj_toolPane.showTool;
exit;
}
else
*/
if(!obj_control.dialogueBoxActive){
	if(obj_control.hoverWordID != -1){
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
		scr_newWord(obj_control.newWordHoverUnitID, max(-1,obj_control.newWordHoverWordSeq - 1), fillWord, obj_control.hoverWordID);
	}
}