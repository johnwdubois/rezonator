// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_toolButtonOptions(optionSelected){
	
	var newMode = obj_toolPane.modeRead;
	if (optionSelected == "menu_read") {
		newMode = obj_toolPane.modeRead;
	}
	else if (optionSelected == "menu_resonance") {
		newMode = obj_toolPane.modeRez;
	}
	else if (optionSelected == "menu_track") {
		newMode = obj_toolPane.modeTrack;
	}
	
	with (obj_toolPane) currentMode = newMode;

}