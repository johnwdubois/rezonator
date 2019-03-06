if (mouse_check_button(mb_right)) {
	x = mouse_x;
	y = mouse_y;
}

if (instance_number(obj_input_text) < 1) {
	var inst = input_text_create_singleline(x + 10, y + 10, windowWidth - 20, fnt_main);
	inst.instTied = self.id;
	input_text_set_enabled(inst, true);
}
else {
	with (obj_input_text) {
		if (instTied == other.id) {
			x = other.x;
			y = other.y;
		}
	}
}