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
var plusY = 20;

draw_set_alpha(1);
draw_set_halign(fa_left);
draw_set_valign(fa_middle);
draw_set_font(fnt_main);
draw_set_color(global.colorThemeText);

draw_text(x + 20, y + plusY, "Select discourse");
plusY += 30;

draw_set_color(c_purple);

discoSelectionActive = true;

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
	
	draw_set_color(c_purple);
	if (i == functionGoToLine_selectedDisco) {
		draw_rectangle(selectedRectX1, selectedRectY1, selectedRectX2, selectedRectY2, false);
		with (obj_panelPane) {
			selectedDiscoID = currentDiscoID;
		}
	}
	else {
		draw_rectangle(selectedRectX1, selectedRectY1, selectedRectX2, selectedRectY2, true);
	}
	
	draw_set_color(global.colorThemeText);
	draw_text(selectedRectX2 + 20, mean(selectedRectY1, selectedRectY2), string(currentDiscoID));
	
	plusY += 20;
}

var specifyLineRectX1 = x + 10;
var specifyLineRectY1 = y + plusY + 10;
var specifyLineRectX2 = x + windowWidth - 20;
var specifyLineRectY2 = specifyLineRectY1 + 20;

if (point_in_rectangle(mouse_x, mouse_y, specifyLineRectX1, specifyLineRectY1, specifyLineRectX2, specifyLineRectY2)) {
	draw_set_color(global.colorThemeSelected1);
	
	if (mouse_check_button_pressed(mb_left)) {
		discoIDSelected = true;
		discoSelectionActive = false;
		obj_control.dialogueBoxActive = true;
		instance_destroy();
	}
}
else {
	draw_set_color(global.colorThemePaneBG);
}
draw_rectangle(specifyLineRectX1, specifyLineRectY1, specifyLineRectX2, specifyLineRectY2, false);
draw_set_color(global.colorThemeBorders);
draw_rectangle(specifyLineRectX1, specifyLineRectY1, specifyLineRectX2, specifyLineRectY2, true);

draw_set_color(global.colorThemeText);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text(mean(specifyLineRectX1, specifyLineRectX2), mean(specifyLineRectY1, specifyLineRectY2), "Specify Line...");

windowHeight = plusY + 40;




x = camera_get_view_x(view_camera[0]) + (camera_get_view_width(view_camera[0]) / 2) - (windowWidth / 2);
y = camera_get_view_y(view_camera[0]) + (camera_get_view_height(view_camera[0]) / 2) - (windowHeight / 2);