/*
	scr_jumpToLineCalled();
	
	Last Updated: 2019-12-27
	
	Called from: obj_control
	
	Purpose: Activate the jumpToLine dialog box
	
	Mechanism: open the keyboard string to user input and create ann instance of the dialog box
	
	Author: Brady Moore
*/

if (!obj_control.shortcutsEnabled || obj_control.dialogueBoxActive || obj_panelPane.discoSelectionActive) {
	exit;
}

// if there already is a GoToLine pane, destroy it
var shouldExit = false;
with (obj_panelPane) {
	if (currentFunction == functionGoToLine) {
		shouldExit = true;
		instance_destroy();
	}
}
if (shouldExit) {
	exit;
}


if (!obj_control.dialogueBoxActive) {
	keyboard_string = "";
	obj_control.gPressed = true;
}


if (ds_grid_height(global.fileLineRipGrid) < 2) {
	

	obj_control.dialogueBoxActive =true;
	if (!instance_exists(obj_dialogueBox)) {
		instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
	}
	obj_control.moveCounter++;
}
else {

	for (var i = 0; i < instance_number(obj_panelPane); i++) {
		var currentPane = instance_find(obj_panelPane, i);
		if (currentPane.currentFunction == obj_panelPane.functionGoToLine) {
			exit;
		}
	}
	
	var paneWidth = 250;
	var paneHeight = 300;
	var paneX = camera_get_view_x(view_camera[0]) + (camera_get_view_width(view_camera[0]) / 2) - (paneWidth / 2);
	var paneY = camera_get_view_y(view_camera[0]) + (camera_get_view_height(view_camera[0]) / 2) - (paneHeight / 2);
	
	//show_message(paneY);
	
	var inst = instance_create_layer(paneX, paneY, "InstancesDialogue", obj_panelPane);

	inst.windowWidth = paneWidth;
	inst.windowHeight = paneHeight;

	inst.currentFunction = 7;
	inst.scrollRange = 9;
	
}