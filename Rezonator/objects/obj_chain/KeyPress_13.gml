///@description End Chain Use
// End chain adding/use
var shouldExit = false;
if (instance_exists(obj_dialogueBox)) {
	if (obj_dialogueBox.combineChains) {
		shouldExit = true;	
	}
}
if (instance_exists(obj_control)) {
	if (obj_control.deleteStack || obj_control.deleteRez || obj_control.deleteTrack) {
		shouldExit = true;
	}
}

if (shouldExit) exit;
scr_chainDeselect();