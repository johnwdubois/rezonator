var mouseoverWindow = point_in_rectangle(mouse_x, mouse_y, x, y, x + windowWidth, y + windowHeight);

// if clicking outside of window, destroy window
if (!mouseoverWindow) {
	if (mouse_check_button_released(mb_left)) {
		instance_destroy();
	}
}

// draw size window back
scr_dropShadow(x, y, x + windowWidth, y + windowHeight);
draw_set_alpha(1);
draw_set_color(global.colorThemeBG);
draw_roundrect(x, y, x + windowWidth, y + windowHeight, false);
draw_set_color(global.colorThemeSelected2);
draw_roundrect(x, y, x + windowWidth, y + windowHeight, true);

// we don't want to change font size of this window while it is open
draw_set_font(sizeWindowFont);
var windowCenterX = x + (windowWidth * 0.5);
var strHeight = string_height("A");

// font size slider
var sliderX1 = x + (windowWidth * 0.15);
var sliderX2 = x + (windowWidth * 0.85);
var sliderWidth = sliderX2 - sliderX1;
var sliderPickRad = windowWidth * 0.04;
var fontSliderY = y + (strHeight * 2.5);
var fontSliderIndexes = global.fontSizeMax - 1;
draw_set_color(global.colorThemeSelected2);
draw_line_width(sliderX1, fontSliderY, sliderX2, fontSliderY, 3);
var fontSliderPickX = sliderX1 + (sliderWidth * (global.fontSize / fontSliderIndexes));
var mouseoverFontSlider = point_in_rectangle(mouse_x, mouse_y, sliderX1, fontSliderY - (sliderPickRad / 2), sliderX2, fontSliderY + (sliderPickRad / 2));
draw_set_color(mouseoverFontSlider || fontSliderHolding ? global.colorThemeSelected2 : global.colorThemeText);
draw_circle(fontSliderPickX, fontSliderY, sliderPickRad, false);
draw_set_color(global.colorThemeText);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text(windowCenterX, fontSliderY - strHeight, scr_get_translation("tag_text"));
if (mouseoverFontSlider && !fontSliderHolding) {
	if (mouse_check_button_pressed(mb_left)) {
		fontSliderHolding = true;
	}
}

// holding font slider
if (fontSliderHolding) {
	var closestIndexToMouse = -1;
	var closestDistToMouse = 99999;
	for (var i = 0; i <= fontSliderIndexes; i++) {
		var currentIndexX = sliderX1 + (sliderWidth * (i / fontSliderIndexes));
		var currentDistToMouse = point_distance(mouse_x, mouse_y, currentIndexX, fontSliderY);
		if (currentDistToMouse < closestDistToMouse) {
			closestDistToMouse = currentDistToMouse;
			closestIndexToMouse = i;
		}
	}
	if (closestIndexToMouse >= 0) {
		global.fontSize = closestIndexToMouse;
	}
}

if (instance_exists(obj_control)) {

	// prose width slider
	var proseSliderY = fontSliderY + (strHeight * 2.5);
	var proseWidthRange = obj_control.proseSpaceHorizontalMax - obj_control.proseSpaceHorizontalMin;
	draw_set_color(global.colorThemeSelected2);
	draw_line_width(sliderX1, proseSliderY, sliderX2, proseSliderY, 3);
	var proseSliderPickX = sliderX1 + (sliderWidth * ((obj_control.proseSpaceHorizontal - obj_control.proseSpaceHorizontalMin) / proseWidthRange));
	var mouseoverProseSlider = point_in_rectangle(mouse_x, mouse_y, sliderX1, proseSliderY - (sliderPickRad / 2), sliderX2, proseSliderY + (sliderPickRad / 2));
	draw_set_color(mouseoverProseSlider || proseWidthSliderHolding ? global.colorThemeSelected2 : global.colorThemeText);
	draw_circle(proseSliderPickX, proseSliderY, sliderPickRad, false);
	draw_set_color(global.colorThemeText);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_text(windowCenterX, proseSliderY - strHeight, scr_get_translation("option_prose-width"));
	if (mouseoverProseSlider && !proseWidthSliderHolding) {
		if (mouse_check_button_pressed(mb_left)) {
			proseWidthSliderHolding = true;
		}
	}

	// holding prose width slider
	if (proseWidthSliderHolding) {
		var closestIndexToMouse = -1;
		var closestDistToMouse = 99999;
		var proseSliderIndexes = proseWidthRange / 20;
		for (var i = 0; i <= proseSliderIndexes; i++) {
			var currentIndexX = sliderX1 + (sliderWidth * (i / proseSliderIndexes));
			var currentDistToMouse = point_distance(mouse_x, mouse_y, currentIndexX, proseSliderY);
			if (currentDistToMouse < closestDistToMouse) {
				closestDistToMouse = currentDistToMouse;
				closestIndexToMouse = i;
			}
		}
		if (closestIndexToMouse >= 0) {
			with (obj_control) proseSpaceHorizontal = proseSpaceHorizontalMin + (20 * closestIndexToMouse);
		}
	}

	// column width slider
	var colSliderY = proseSliderY + (strHeight * 2.5);
	var colWidthRange = obj_control.gridSpaceHorizontalMax - obj_control.gridSpaceHorizontalMin;
	draw_set_color(global.colorThemeSelected2);
	draw_line_width(sliderX1, colSliderY, sliderX2, colSliderY, 3);
	var colWidthSliderPickX = sliderX1 + (sliderWidth * ((obj_control.gridSpaceHorizontal - obj_control.gridSpaceHorizontalMin) / colWidthRange));
	var mouseoverColSlider = point_in_rectangle(mouse_x, mouse_y, sliderX1, colSliderY - (sliderPickRad / 2), sliderX2, colSliderY + (sliderPickRad / 2));
	draw_set_color(mouseoverColSlider || colWidthSliderHolding ? global.colorThemeSelected2 : global.colorThemeText);
	draw_circle(colWidthSliderPickX, colSliderY, sliderPickRad, false);
	draw_set_color(global.colorThemeText);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_text(windowCenterX, colSliderY - strHeight, scr_get_translation("option_column-width"));
	if (mouseoverColSlider && !colWidthSliderHolding) {
		if (mouse_check_button_pressed(mb_left)) {
			colWidthSliderHolding = true;
		}
	}

	// holding column width slider
	if (colWidthSliderHolding) {
		var closestIndexToMouse = -1;
		var closestDistToMouse = 99999;
		var colSliderIndexes = colWidthRange / 20;
		for (var i = 0; i <= colSliderIndexes; i++) {
			var currentIndexX = sliderX1 + (sliderWidth * (i / colSliderIndexes));
			var currentDistToMouse = point_distance(mouse_x, mouse_y, currentIndexX, fontSliderY);
			if (currentDistToMouse < closestDistToMouse) {
				closestDistToMouse = currentDistToMouse;
				closestIndexToMouse = i;
			}
		}
		if (closestIndexToMouse >= 0) {
			with (obj_control) gridSpaceHorizontal = gridSpaceHorizontalMin + (20 * closestIndexToMouse);
		}
	}

	// row height slider
	var rowSliderY = colSliderY + (strHeight * 2.5);
	var rowHeightRange = obj_control.gridSpaceVerticalMax - obj_control.gridSpaceVerticalMin;
	draw_set_color(global.colorThemeSelected2);
	draw_line_width(sliderX1, rowSliderY, sliderX2, rowSliderY, 3);
	var rowHeightSliderPickX = sliderX1 + (sliderWidth * ((obj_control.gridSpaceVertical - obj_control.gridSpaceVerticalMin) / rowHeightRange));
	var mouseoverRowSlider = point_in_rectangle(mouse_x, mouse_y, sliderX1, rowSliderY - (sliderPickRad / 2), sliderX2, rowSliderY + (sliderPickRad / 2));
	draw_set_color(mouseoverRowSlider || rowHeightSliderHolding ? global.colorThemeSelected2 : global.colorThemeText);
	draw_circle(rowHeightSliderPickX, rowSliderY, sliderPickRad, false);
	draw_set_color(global.colorThemeText);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_text(windowCenterX, rowSliderY - strHeight, scr_get_translation("option_row-height"));
	if (mouseoverRowSlider && !rowHeightSliderHolding) {
		if (mouse_check_button_pressed(mb_left)) {
			rowHeightSliderHolding = true;
		}
	}

	// holding row height slider
	if (rowHeightSliderHolding) {
		var closestIndexToMouse = -1;
		var closestDistToMouse = 99999;
		var rowSliderIndexes = rowHeightRange / 10;
		for (var i = 0; i <= rowSliderIndexes; i++) {
			var currentIndexX = sliderX1 + (sliderWidth * (i / rowSliderIndexes));
			var currentDistToMouse = point_distance(mouse_x, mouse_y, currentIndexX, rowSliderY);
			if (currentDistToMouse < closestDistToMouse) {
				closestDistToMouse = currentDistToMouse;
				closestIndexToMouse = i;
			}
		}
		if (closestIndexToMouse >= 0) {
			var prevGridSpaceVertical = obj_control.gridSpaceVertical;
			with (obj_control) gridSpaceVertical = gridSpaceVerticalMin + (10 * closestIndexToMouse);
			if (obj_control.gridSpaceVertical != prevGridSpaceVertical) {
				obj_control.prevCenterDisplayRow = scr_currentTopLine();
				scr_jumpToUnitTop(obj_control.prevCenterDisplayRow);
			}
		}
	}

}

// release all sliders
if (!mouse_check_button(mb_left)) {
	fontSliderHolding = false;
	proseWidthSliderHolding = false;
	colWidthSliderHolding = false;
	rowHeightSliderHolding = false;
}