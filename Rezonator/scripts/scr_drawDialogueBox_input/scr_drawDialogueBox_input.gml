// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_drawDialogueBox_input(){
	
	// draw title text
	if(!instance_exists(obj_inputBox)){
		instance_create_layer(0,0,"InstancesInput", obj_inputBox);
	}
	with(obj_inputBox){
		x =  floor(obj_dialogueBox.boxRectX1 + (obj_dialogueBox.boxWidth * 0.1));
		y = floor(obj_dialogueBox.boxRectY1 + (obj_dialogueBox.boxHeight * 0.35));
		windowWidth = obj_dialogueBox.boxWidth * 0.8;
		
	}
	obj_control.inputText = obj_inputBox.str;

}