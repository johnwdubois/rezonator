function scr_showSpeakerName(boolean) {
	
	obj_control.showSpeakerName = boolean;
	
	show_debug_message("showSpeakerName: " + string(boolean) + "speakerLabelColXList: " + scr_getStringOfList(obj_control.speakerLabelColXList));
	
	

}
