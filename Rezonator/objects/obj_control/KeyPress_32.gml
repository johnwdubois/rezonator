/// @description Experimental show stack toggle
// You can write your code in this editor
if (showDevVars) {
	if (keyboard_check(vk_control)) {
		obj_stacker.alarm[2] = 1;	
	}
	else {
		obj_stacker.alarm[3] = 1;		
	}
}
