var camWidth = camera_get_view_width(view_camera[0]);
x = camWidth - windowWidth;
y = obj_toolPane.y + obj_toolPane.windowHeight;

var mouseover = false;
if (point_in_rectangle(mouse_x, mouse_y, x, y, x + windowWidth, y + windowHeight)) {
	mouseover = true;
}

if (mouseover and mouse_check_button_pressed(mb_left)) {
	functionHelp_collapsed = !functionHelp_collapsed;
}

draw_set_alpha(1);
draw_set_font(fnt_mainBold);
draw_set_color(c_black);
draw_set_halign(fa_left);
draw_set_valign(fa_middle);

if (functionHelp_collapsed) {
	draw_set_color(c_black);
	draw_text(x + 10, y + (windowHeight / 2), "Help");
	
	if (functionHelp_plusX < functionHelp_windowWidth) {
		functionHelp_plusX += abs(functionHelp_plusX - functionHelp_windowWidth) / 6;
	}
}
else {
	draw_set_color(c_black);
	draw_rectangle(x, y, x + windowWidth, y + windowHeight, false);
	draw_set_color(c_white);
	draw_text(x + 10, y + (windowHeight / 2), "Help");

	if (functionHelp_plusX > functionHelp_windowWidth) {
		functionHelp_plusX -= abs(functionHelp_plusX - functionHelp_windowWidth) / 6;
	}
}

if (functionHelp_plusX < functionHelp_windowWidth) {
	draw_set_color(c_ltgray);
	var helpWindowX1 = camWidth - functionHelp_windowWidth;
	var helpWindowY1 = obj_toolPane.y + obj_toolPane.windowHeight + windowHeight;
	var helpWindowX2 = camWidth;
	var helpWindowY2 = camera_get_view_height(view_camera[0]) - helpWindowY1;
	draw_rectangle(helpWindowX1, helpWindowY1, helpWindowX2, helpWindowY2, false);
	draw_set_color(c_black);
	draw_rectangle(helpWindowX1, helpWindowY1, helpWindowX2, helpWindowY2, true);
}