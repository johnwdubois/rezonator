///@description Activate Search
if (!shortcutsEnabled || obj_panelPane.discoSelectionActive || mouseoverTagShortcut) {
	exit;
}

// Activates word searching using search grid
preSwitchDisplayRow = obj_control.scrollPlusYDest;
preSwitchLineGrid = currentActiveLineGrid;
preSwitchSearchDisplayRow = 0;

if (!obj_control.dialogueBoxActive) {
	keyboard_string = "";
	fPressed = true;
}


dialogueBoxActive = true;

if (!instance_exists(obj_dialogueBox)) {
	instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
}

//have the input be here?


//scr_searchForWord();