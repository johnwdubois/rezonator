if (instance_exists(obj_customTagPane)) {
	x = obj_customTagPane.x + (obj_customTagPane.windowWidth / 2) + (obj_customTagPane.subPaneBufferX / 2);
	y = obj_customTagPane.y + obj_customTagPane.subPaneBufferY;
	windowWidth = (obj_customTagPane.windowWidth / 2) - (obj_customTagPane.subPaneBufferX);
	windowHeight = obj_customTagPane.windowHeight - (obj_customTagPane.subPaneBufferY * 1.5);
}
else {
	instance_destroy();
}

draw_set_alpha(1);
draw_set_color(global.colorThemeBG);
draw_rectangle(x, y, x + windowWidth, y + windowHeight, false);

draw_set_alpha(1);
draw_set_color(global.colorThemeBorders);
draw_rectangle(x, y, x + windowWidth, y + windowHeight, true);