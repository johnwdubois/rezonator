/// @description Insert description here
// You can write your code in this editor
if (obj_control.dialogueBoxActive) {
	scr_drawDialogueBox();
}

else if(questionWindowActive) {
	scr_drawQuestionBox();
}
else if(elmoActive) {
	scr_drawElmoScreen();	
}
		//draw_text(camera_get_view_width(view_camera[0]) -700 , 810, "can press right: " + string(canPressRight));