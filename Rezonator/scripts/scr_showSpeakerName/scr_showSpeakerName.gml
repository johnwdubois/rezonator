function scr_showSpeakerName(boolean) {
	
	obj_control.showParticipantName = boolean;

	if (!obj_control.showParticipantName) {
		var newColX = ds_list_find_value(obj_control.speakerLabelColXList, 2);
		ds_list_set(obj_control.speakerLabelColXList, 3, newColX);	
	}

	obj_control.wordLeftMargin = ds_list_find_value(obj_control.speakerLabelColXList, ds_list_size(obj_control.speakerLabelColXList) - 1) + 20;
	obj_control.wordLeftMarginDest = obj_control.wordLeftMargin;
	
	show_debug_message("scr_showSpeakerName() ... obj_control.showParticipantName: " + string(obj_control.showParticipantName));

}
