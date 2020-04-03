if (instance_exists(obj_customTagPane)) {
	x = obj_customTagPane.x + (obj_customTagPane.subPaneBufferX / 2);
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


var plusY = 0;
var strHeight = string_height("0");
draw_set_alpha(1);
draw_set_halign(fa_left);
draw_set_valign(fa_middle);
for (var i = 0; i < ds_grid_height(global.customLabelGrid); i++) {
	
	var currentLabel = ds_grid_get(global.customLabelGrid, global.customLabelGrid_colLabel, i);
	draw_set_alpha(1);
	if (instance_exists(obj_customTagPane)) {
		if (obj_customTagPane.selectedLabel == i) {
			draw_set_color(global.colorThemeSelected1);
			draw_rectangle(x, y + plusY - (strHeight / 2), x + windowWidth - scrollBarWidth, y + plusY + strHeight, false);
		}
	}
	draw_set_color(global.colorThemeText);
	draw_text(floor(x + 10), floor(y + plusY), string(currentLabel));
}