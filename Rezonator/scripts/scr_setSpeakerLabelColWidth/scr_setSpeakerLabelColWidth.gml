var minSpeakerLabelWidth = 150;
var maxSpeakerLabelWidth = 220;

draw_set_font(global.fontMain);

// get width of the widest particant name and widest discourse name
var maxDiscoIDWidth = 0;
var maxParticipantStrWidth = 0;
for (var i = 0; i < ds_grid_height(global.fileLineRipGrid); i++) {
	var currentDiscoID = ds_grid_get(global.fileLineRipGrid, global.fileLineRipGrid_colDiscoID, i);
	var currentParticipantList = ds_grid_get(global.fileLineRipGrid, global.fileLineRipGrid_colParticipantList, i);
	
	maxDiscoIDWidth = max(maxDiscoIDWidth, string_width(currentDiscoID) + 10);
	for (var j = 0; j < ds_list_size(currentParticipantList); j++) {
		var currentParticipantStr = ds_list_find_value(currentParticipantList, j);
		
		maxParticipantStrWidth = max(maxParticipantStrWidth, string_width(currentParticipantStr) + 10);
	}
}

// col 0 is discourse column
// if there are less than 2 discourses loaded, there is no need to show this column
if (ds_grid_height(global.fileLineRipGrid) < 2) {
	obj_control.speakerLabelColWidth[0] = 0;
}
else {
	obj_control.speakerLabelColWidth[0] = maxDiscoIDWidth;
}



// col 1 is line number column
// 8888 is used because it is presumably the widest string of 4 digit numbers
obj_control.speakerLabelColWidth[1] = string_width("8888");



// col 2 is participant name column
// we search for the longest particpant name in the discourse and set the width of the column to that
obj_control.speakerLabelColWidth[2] = maxParticipantStrWidth;

var speakerLabelWidthFull = obj_control.speakerLabelColWidth[0] + obj_control.speakerLabelColWidth[1] + obj_control.speakerLabelColWidth[2];
if (speakerLabelWidthFull < minSpeakerLabelWidth) {
	obj_control.speakerLabelColWidth[2] = minSpeakerLabelWidth - obj_control.speakerLabelColWidth[0] - obj_control.speakerLabelColWidth[1];
}
else if (speakerLabelWidthFull > maxSpeakerLabelWidth) {
	obj_control.speakerLabelColWidth[2] = maxSpeakerLabelWidth - obj_control.speakerLabelColWidth[0] - obj_control.speakerLabelColWidth[1];
}



speakerLabelWidthFull = obj_control.speakerLabelColWidth[0] + obj_control.speakerLabelColWidth[1] + obj_control.speakerLabelColWidth[2];
obj_control.speakerLabelMargin = speakerLabelWidthFull;

obj_control.wordLeftMarginDest = obj_control.speakerLabelMargin + obj_control.speakerLabelMarginBuffer;