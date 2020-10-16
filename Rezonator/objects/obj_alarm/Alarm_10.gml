var unitGridHeight = ds_grid_height(obj_control.unitGrid);
var foundParticipant = false;
for (var i = 0; i < unitGridHeight; i++) {
	
	var currentParticipantName = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colParticipantName, i);
	if (currentParticipantName != "" && currentParticipantName != undefined) {
		foundParticipant = true;
		break;
	}
}

if (!foundParticipant) {
	scr_hideSpeakerName();
}