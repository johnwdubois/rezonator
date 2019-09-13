var colX3 = real(scr_getValueFromString(global.iniFileString, "SpeakerLabelX3:", ","));
var colX4 = real(scr_getValueFromString(global.iniFileString, "SpeakerLabelX4:", ","));


ds_list_set(obj_control.speakerLabelColXList, 2, colX3);
ds_list_set(obj_control.speakerLabelColXList, 3, colX4);

with (obj_control) {
	wordLeftMargin = ds_list_find_value(obj_control.speakerLabelColXList, ds_list_size(obj_control.speakerLabelColXList) - 1) + 20;
	wordLeftMarginDest = wordLeftMargin;
}