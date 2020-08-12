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


var strHeight = string_height("0");
var plusY = 0;
draw_set_alpha(1);
draw_set_font(global.fontMain);
draw_set_halign(fa_left);
draw_set_valign(fa_middle);
var customLabelGridHeight = ds_grid_height(global.customLabelGrid);
for (var i = 0; i < customLabelGridHeight; i++) {
	
	var currentLabel = ds_grid_get(global.customLabelGrid, global.customLabelGrid_colMarker, i);
	draw_set_alpha(1);
	if (instance_exists(obj_customTagPane)) {
		if (obj_customTagPane.selectedLabel == i) {
			draw_set_color(global.colorThemeSelected1);
			draw_rectangle(x - clipX, y + plusY - (strHeight / 2) + scrollPlusY - clipY, x + windowWidth - global.scrollBarWidth - clipX, y + plusY + (strHeight / 2) + scrollPlusY - clipY, false);
		}
	}
	if (point_in_rectangle(mouse_x, mouse_y, x, y + plusY - (strHeight / 2) + scrollPlusY, x + windowWidth - global.scrollBarWidth, y + plusY + (strHeight / 2) + scrollPlusY)
	&& mouse_check_button_released(mb_left)) {
		obj_customTagPane.selectedLabel = i;
	}
	
	draw_set_color(global.colorThemeText);
	draw_text(floor(x + 10) - clipX, floor(y + plusY) + scrollPlusY - clipY, string(currentLabel));
	
	plusY += strHeight;
}

scr_scrollBar(ds_grid_height(global.customLabelGrid), -1, strHeight, 0,
	global.colorThemeSelected1, global.colorThemeSelected2,
	global.colorThemeSelected1, global.colorThemeSelected2, spr_ascend, windowWidth, windowHeight);

draw_set_alpha(1);
draw_set_color(global.colorThemeBorders);
draw_rectangle(x, y, x + windowWidth, y + windowHeight, true);