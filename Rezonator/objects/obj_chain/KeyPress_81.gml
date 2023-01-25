///@description End Chain Use
// End chain adding/use
if (global.ctrlHold) {
	if (obj_chain.showTrackArrows and obj_chain.showRezArrows) {
		obj_chain.showTrackArrows = false;
		obj_chain.showRezArrows = false;
		exit;
	}
	else if (!obj_chain.showTrackArrows and !obj_chain.showRezArrows) {
		obj_chain.showTrackArrows = true;
		obj_chain.showRezArrows = true;	
		exit;
	}
	else{
		obj_chain.showTrackArrows = false;
		obj_chain.showRezArrows = false;
		exit;
	}
}
else {
	if (!obj_control.dialogueBoxActive) {
		scr_chainDeselect();
	}
}