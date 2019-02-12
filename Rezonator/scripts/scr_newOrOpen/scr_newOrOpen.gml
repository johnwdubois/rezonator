draw_set_font(fnt_main);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

var buttonWidth = 200;
var buttonHeight = 60;

var newProjectButtonX1 = (camera_get_view_width(view_camera[0]) / 2) - (buttonWidth / 2);
var newProjectButtonY1 = (camera_get_view_height(view_camera[0]) * 0.6);
var newProjectButtonX2 = newProjectButtonX1 + buttonWidth;
var newProjectButtonY2 = newProjectButtonY1 + buttonHeight;

if (point_in_rectangle(mouse_x, mouse_y, newProjectButtonX1, newProjectButtonY1, newProjectButtonX2, newProjectButtonY2))
{
	draw_set_color(global.colorThemeSelected1);
	draw_rectangle(newProjectButtonX1, newProjectButtonY1, newProjectButtonX2, newProjectButtonY2, false);
	
	if (mouse_check_button_pressed(mb_left))
	{
		global.newProject = true;
		global.openProject = false;
	}
}

draw_set_color(global.colorThemeBorders);
draw_rectangle(newProjectButtonX1, newProjectButtonY1, newProjectButtonX2, newProjectButtonY2, true);
draw_set_color(global.colorThemeText);
draw_text(mean(newProjectButtonX1, newProjectButtonX2), mean(newProjectButtonY1, newProjectButtonY2), "New Project");




var openProjectButtonX1 = newProjectButtonX1
var openProjectButtonY1 = newProjectButtonY2 + 30;
var openProjectButtonX2 = newProjectButtonX2;
var openProjectButtonY2 = openProjectButtonY1 + buttonHeight;

if (point_in_rectangle(mouse_x, mouse_y, openProjectButtonX1, openProjectButtonY1, openProjectButtonX2, openProjectButtonY2))
{
	draw_set_color(global.colorThemeSelected1);
	draw_rectangle(openProjectButtonX1, openProjectButtonY1, openProjectButtonX2, openProjectButtonY2, false);
	
	if (mouse_check_button_pressed(mb_left))
	{
		global.newProject = false;
		global.openProject = true;
	}
}

draw_set_color(global.colorThemeBorders);
draw_rectangle(openProjectButtonX1, openProjectButtonY1, openProjectButtonX2, openProjectButtonY2, true);
draw_set_color(global.colorThemeText);
draw_text(mean(openProjectButtonX1, openProjectButtonX2), mean(openProjectButtonY1, openProjectButtonY2), "Open Project");

