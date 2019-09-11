with (obj_control) {
	if (global.fontSize == 0) {
		if (ds_grid_height(global.fileLineRipGrid) < 2) {
			ds_list_set(speakerLabelColXList, 2, 100);
		}
	}
	wordLeftMargin = ds_list_find_value(obj_control.speakerLabelColXList, ds_list_size(obj_control.speakerLabelColXList) - 1) + 20;
	wordLeftMarginDest = wordLeftMargin;
}