// Determine whether or not to show the speaker name at the beginning
// of the Main Screen

var unitGridHeight = ds_grid_height(obj_control.unitGrid);
var foundParticipant = false;
for (var i = 0; i < unitGridHeight; i++) {
	
	var currentParticipantName = string(ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colParticipantName, i));
	if (currentParticipantName != ""
	&& currentParticipantName != "undefined"
	&& currentParticipantName != "0"
	&& !is_undefined(currentParticipantName)) {
		foundParticipant = true;
		break;
	}
}

// if we have not found any actual speaker name in the unitGrid, we
// hide the speaker names
if (!foundParticipant) {
	scr_hideSpeakerName();
}