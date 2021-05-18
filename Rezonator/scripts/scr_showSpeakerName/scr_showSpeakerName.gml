function scr_showSpeakerName(boolean) {
	
	obj_control.showSpeakerName = boolean;
	
	show_debug_message("showSpeakerName: " + string(boolean) + "speakerLabelColXList: " + scr_getStringOfList(obj_control.speakerLabelColXList));
	
	
	if (boolean) {
		if (ds_list_size(obj_control.speakerLabelColXList) == 1) {
			var prevColX = obj_control.speakerLabelColXList[| 0];
			ds_list_add(obj_control.speakerLabelColXList, prevColX * 2);
		}
	}
	else {
		while (ds_list_size(obj_control.speakerLabelColXList) > 1) {
			ds_list_delete(obj_control.speakerLabelColXList, 1);
		}
	}
	

}
