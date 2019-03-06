/*
if (mouse_check_button(mb_right)) {
	x = mouse_x;
	y = mouse_y;
}
*/

/*
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
*/
draw_set_color(c_purple);
draw_set_alpha(1);
draw_set_halign(fa_left);
draw_set_valign(fa_middle);
draw_set_font(fnt_main);

var plusY = 20;

for (var i = 0; i < ds_grid_height(global.fileLineRipGrid); i++) {
	var currentDiscoID = ds_grid_get(global.fileLineRipGrid, global.fileLineRipGrid_colDiscoID, i);
	var selectedRectX1 = x + 20;
	var selectedRectY1 = y + plusY;
	var selectedRectX2 = selectedRectX1 + 8;
	var selectedRectY2 = selectedRectY1 + 8;
	
	if (point_in_rectangle(mouse_x, mouse_y, selectedRectX1, selectedRectY1, selectedRectX2, selectedRectY2)) {
		if (mouse_check_button_pressed(mb_left)) {
			if (i != functionGoToLine_selectedDisco) {
				functionGoToLine_selectedDisco = i;
			}
		}
	}
	
	
	if (i == functionGoToLine_selectedDisco) {
		draw_rectangle(selectedRectX1, selectedRectY1, selectedRectX2, selectedRectY2, false);
	}
	else {
		draw_rectangle(selectedRectX1, selectedRectY1, selectedRectX2, selectedRectY2, true);
	}
	
	draw_text(selectedRectX2 + 20, mean(selectedRectY1, selectedRectY2), string(currentDiscoID));
	
	plusY += 20;
}

windowHeight = plusY;