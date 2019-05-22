draw_set_color(c_white);
draw_rectangle(x, y, x + windowWidth, y + windowHeight, false);
draw_set_color(c_black);
draw_rectangle(x, y, x + windowWidth, y + windowHeight, true);


draw_set_font(font);
var strHeight = string_height("0");

draw_set_font(fnt_size1);
draw_text(10, 10, "windowHeight: " + string(windowHeight));
draw_text(10, 30, "strHeight: " + string(strHeight));
draw_text(10, 50, "listSize: " + string(ds_list_size(valueList)));
draw_text(10, 70, "scrollPlusY: " + string(scrollPlusY));
draw_text(10, 90, "scrollPlusYDest: " + string(scrollPlusYDest));
draw_text(10, 110, "scrollBarPlusY: " + string(scrollBarPlusY));
draw_text(10, 130, "scrollBarHeight: " + string(scrollBarHeight));
draw_text(10, 150, "y: " + string(y));
draw_text(10, 170, "mouse_y: " + string(mouse_y));
draw_text(10, 190, "(y + scrollBarWidth - mouse_y): " + string(y + scrollBarWidth - mouse_y));



if (keyboard_check_pressed(ord("W"))) {
	ds_list_add(valueList, "blah " + string(ds_list_size(valueList)));
}
if (keyboard_check_pressed(ord("D"))) {
	for (var i = 0; i < 10; i++) {
		ds_list_add(valueList, "blah " + string(ds_list_size(valueList)));
	}
}
if (keyboard_check_pressed(ord("S"))) {
	ds_list_delete(valueList, ds_list_size(valueList) - 1);
}
if (keyboard_check_pressed(ord("A"))) {
	for (var i = 0; i < 10; i++) {
		ds_list_delete(valueList, ds_list_size(valueList) - 1);
	}
}



if (keyboard_check_pressed(vk_numpad1)) {
	font = fnt_size1;
}
if (keyboard_check_pressed(vk_numpad2)) {
	font = fnt_size2;
}
if (keyboard_check_pressed(vk_numpad3)) {
	font = fnt_size3;
}



scr_resizeWindow();

scr_surfaceStart();

scr_drawItems(valueList, 32);
scr_scrollBar(ds_list_size(valueList), strHeight, 32, c_ltgray, c_dkgray, c_blue, c_red);

scr_surfaceEnd();