showParticipantName = !showParticipantName;

if (!showParticipantName) {
	var newColX = ds_list_find_value(speakerLabelColXList, 2);
	ds_list_set(speakerLabelColXList, 3, newColX);	
}

wordLeftMargin = ds_list_find_value(obj_control.speakerLabelColXList, ds_list_size(obj_control.speakerLabelColXList) - 1) + 20;
wordLeftMarginDest = wordLeftMargin;