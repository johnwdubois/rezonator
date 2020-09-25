with (obj_control) {
	if (currentActiveLineGrid != searchGrid) {
		wordLeftMargin = ds_list_find_value(obj_control.speakerLabelColXList, ds_list_size(obj_control.speakerLabelColXList) - 1) + 20;
		wordLeftMarginDest = wordLeftMargin;
	}
}