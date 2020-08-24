var colX3 = ds_list_find_value(obj_control.speakerLabelColXList,2);
var colX4 = ds_list_find_value(obj_control.speakerLabelColXList,2)

if (colX3 != "" and colX4 != "") {
	
	colX3 = real(colX3);
	colX4 = real(colX4);

	ds_list_set(obj_control.speakerLabelColXList, 2, colX3);
	ds_list_set(obj_control.speakerLabelColXList, 3, colX4);

	with (obj_control) {
		wordLeftMargin = ds_list_find_value(obj_control.speakerLabelColXList, ds_list_size(obj_control.speakerLabelColXList) - 1) + 20;
		wordLeftMarginDest = wordLeftMargin;
	}

}
