// Draw the mouse drag rectangle, and the record when the mouse is released
draw_set_color(global.colorThemeSelected1);
draw_set_alpha(0.5);

if (mouse_check_button_pressed(mb_left)) {
	boxHoldRectX1 = mouse_x;
	boxHoldRectY1 = mouse_y;
	boxHoldRectX2 = mouse_x;
	boxHoldRectY2 = mouse_y;
	boxRectReleased = false;
}
if (mouse_check_button(mb_left)) {
	boxHoldRectX2 = mouse_x;
	boxHoldRectY2 = mouse_y;
	// Check current text size to see if box is capturing a chunk or not
	/*if(ds_list_size(obj_control.inRectUnitIDList) != 1) {
		draw_rectangle(boxHoldRectX1, boxHoldRectY1, boxHoldRectX2, boxHoldRectY2, false);
		draw_set_alpha(1);
		draw_rectangle(boxHoldRectX1, boxHoldRectY1, boxHoldRectX2, boxHoldRectY2, true);
	}*/
}
if (mouse_check_button_released(mb_left)) {
	boxRectReleased = true;
	if (abs(boxHoldRectY1 - boxHoldRectY2) > 5 or abs(boxHoldRectX1 - boxHoldRectX2) > 5) {
		boxRectMade = true;
	}
}