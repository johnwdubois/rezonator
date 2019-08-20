/// @description Insert description here
// You can write your code in this editor
if (obj_control.dialogueBoxActive) {
	scr_drawDialogueBox();
}
else if(stackShowWindowActive) {
	scr_stackShowWindow();
}
else if(questionWindowActive) {
	scr_drawQuestionBox();
}
else if(elmoActive) {
	scr_drawElmoScreen();	
}
