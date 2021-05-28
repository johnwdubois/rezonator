function scr_exceptionsWindow() {
	// draw all exception lines
	draw_set_color(global.colorThemeText);
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	var plusY = string_height("0");
	var exceptionStringListSize = ds_list_size(exceptionStringList);
	for (var i = 0; i < exceptionStringListSize; i++) {
		var currentExceptionString = ds_list_find_value(exceptionStringList, i);
		scr_adaptFont(string(currentExceptionString), "S");
		draw_text(floor(fileInfoWindowRectX1 + 20) - clipX, floor(fileInfoWindowRectY1 + plusY + scrollPlusY) - clipY, string(currentExceptionString));
		plusY += string_height("0");
	}
	
	
	// mousewheel input
	if (point_in_rectangle(mouse_x, mouse_y, x, y, x + windowWidth, y + windowHeight)) {
		if (mouse_wheel_up()) {
			scrollPlusYDest += 16;
		}
		if (mouse_wheel_down()) {
			scrollPlusYDest -= 16;
		}
	}

	scr_scrollBar(ds_list_size(exceptionStringList) + 1, -1, string_height("0"), 0,
		global.colorThemeSelected1, global.colorThemeSelected2,
		global.colorThemeSelected1, global.colorThemeSelected2, spr_ascend, windowWidth, windowHeight);
	
	scrollPlusY = min(scrollPlusY, 0);

}
