if (instance_exists(obj_input_text)) {
	exit;
}

var inst = instance_create_layer((room_width / 2) - 250, (room_height / 2) - 300, "InstancesDialogue", obj_panelPane);

//x = 80;
//y = 100;

inst.windowWidth = 250;
inst.windowHeight = 300;

inst.currentFunction = 7;
inst.scrollRange = 9;

scr_jumpToLine();