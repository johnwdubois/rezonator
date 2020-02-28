obj_control.showParticipantName = !obj_control.showParticipantName;

if (!obj_control.showParticipantName) {
	var newColX = ds_list_find_value(obj_control.speakerLabelColXList, 2);
	ds_list_set(obj_control.speakerLabelColXList, 3, newColX);	
}

obj_control.wordLeftMargin = ds_list_find_value(obj_control.speakerLabelColXList, ds_list_size(obj_control.speakerLabelColXList) - 1) + 20;
obj_control.wordLeftMarginDest = obj_control.wordLeftMargin;