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
var fontSliderIndexes = 5;
draw_set_color(global.colorThemeSelected2);
draw_line_width(sliderX1, fontSliderY, sliderX2, fontSliderY, 3);
var sliderPickX = sliderX1 + (sliderWidth * (global.fontSize / fontSliderIndexes));
var mouseoverFontSlider = point_in_rectangle(mouse_x, mouse_y, sliderX1, fontSliderY - (sliderPickRad / 2), sliderX2, fontSliderY + (sliderPickRad / 2));
draw_set_color(mouseoverFontSlider || fontSliderHolding ? global.colorThemeSelected2 : global.colorThemeText);
draw_circle(sliderPickX, fontSliderY, sliderPickRad, false);
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

// release all sliders
if (!mouse_check_button(mb_left)) {
	fontSliderHolding = false;
}

// column size slider
var colSliderY = y + (strHeight * 2.5);
var colSliderIndexes = 5;
draw_set_color(global.colorThemeSelected2);
draw_line_width(sliderX1, colSliderY, sliderX2, colSliderY, 3);
var sliderPickX = sliderX1 + (sliderWidth * (global.fontSize / colSliderIndexes));
var mouseoverColSlider = point_in_rectangle(mouse_x, mouse_y, sliderX1, colSliderY - (sliderPickRad / 2), sliderX2, colSliderY + (sliderPickRad / 2));
draw_set_color(mouseoverColSlider || colSliderHolding ? global.colorThemeSelected2 : global.colorThemeText);
draw_circle(sliderPickX, colSliderY, sliderPickRad, false);
draw_set_color(global.colorThemeText);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text(windowCenterX, colSliderY - strHeight, scr_get_translation("tag_text"));
if (mouseoverFontSlider && !fontSliderHolding) {
	if (mouse_check_button_pressed(mb_left)) {
		fontSliderHolding = true;
	}
}