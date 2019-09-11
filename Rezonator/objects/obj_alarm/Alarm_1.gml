with (obj_control) {
	if (global.fontSize == 0) {
		if (ds_grid_height(global.fileLineRipGrid) < 2) {
			ds_list_set(speakerLabelColXList, 2, 100);
		}
	}
}