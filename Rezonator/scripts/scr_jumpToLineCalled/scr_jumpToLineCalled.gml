function scr_jumpToLineCalled() {
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
	
		var paneWidth = 250;
		var paneHeight = 300;
		var paneX = camera_get_view_x(camera_get_active()) + (camera_get_view_width(camera_get_active()) / 2) - (paneWidth / 2);
		var paneY = camera_get_view_y(camera_get_active()) + (camera_get_view_height(camera_get_active()) / 2) - (paneHeight / 2);

	
		var inst = instance_create_layer(paneX, paneY, "InstancesDialogue", obj_panelPane);

		inst.windowWidth = paneWidth;
		inst.windowHeight = paneHeight;

		inst.currentFunction = 7;
		inst.scrollRange = 9;
	
	}


}
