if (!shortcutsEnabled) {
	exit;
}

if (ds_grid_height(global.fileLineRipGrid) < 2) {
	scr_jumpToLine("");
}
else {

	for (var i = 0; i < instance_number(obj_panelPane); i++) {
		var currentPane = instance_find(obj_panelPane, i);
		if (currentPane.currentFunction == obj_panelPane.functionGoToLine) {
			exit;
		}
	}

	var inst = instance_create_layer((room_width / 2) - 250, (room_height / 2) - 300, "InstancesDialogue", obj_panelPane);

	//x = 80;
	//y = 100;

	inst.windowWidth = 250;
	inst.windowHeight = 300;

	inst.currentFunction = 7;
	inst.scrollRange = 9;
}