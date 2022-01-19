

function scr_toolButtonOptions(optionSelected){
	
	var newMode = obj_toolPane.modeRead;
	if (optionSelected == "menu_read") {
		newMode = obj_toolPane.modeRez;
	}
	else if (optionSelected == "menu_resonance") {
		obj_wordTip.wordTipDisplay = false;
		newMode = obj_toolPane.modeRez;
	}
	else if (optionSelected == "menu_track") {
		obj_wordTip.wordTipDisplay = false;
		newMode = obj_toolPane.modeTrack;
	}
	if (newMode != obj_toolPane.modeTrack && newMode != obj_toolPane.modeRez) {
		obj_wordTip.wordTipDisplay = true;
	}
	
	with (obj_toolPane) currentMode = newMode;

}