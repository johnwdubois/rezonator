if (live_call()) return live_result;

var mouseoverWindow = point_in_rectangle(mouse_x, mouse_y, x, y, x + windowWidth, y + windowHeight);

// if clicking outside of window, destroy window
if (!mouseoverWindow) {
	if (mouse_check_button_released(mb_left)) {
		instance_destroy();
	}
}

// draw size window back
draw_set_color(global.colorThemeBG);
draw_roundrect(x, y, x + windowWidth, y + windowHeight, false);
draw_set_color(global.colorThemeSelected2);
draw_roundrect(x, y, x + windowWidth, y + windowHeight, true);

// font size slider
var sliderX1 = x + (windowWidth * 0.15);
var sliderX2 = x + (windowWidth * 0.85);
var sliderWidth = sliderX2 - sliderX1;
var sliderPickRad = windowWidth * 0.04;
var fontSliderY = y + (windowHeight * 0.3);
var fontSliderIndexes = 5;
draw_set_color(global.colorThemeSelected2);
draw_line_width(sliderX1, fontSliderY, sliderX2, fontSliderY, 3);
var sliderPickX = sliderX1 + (sliderWidth * (global.fontSize / fontSliderIndexes));
draw_set_color(global.colorThemeText);
draw_circle(sliderPickX, fontSliderY, sliderPickRad, false);