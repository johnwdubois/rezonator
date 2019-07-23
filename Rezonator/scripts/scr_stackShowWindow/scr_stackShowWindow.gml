
/*
	scr_stackShowWindow();
	
	Last Updated: 2019-06-25
	
	Called from: obj_control
	
	Purpose: draw custom search box for multiple options
	
	Mechanism: draws multiple rectangles and text to represent options to the user when they search,
	this includes booleans for a case sensitive search, transcript search, and a search within a chain
				
	Author: Brady Moore
*/


	var verticleBuffer = 250;
	var horizontalBuffer = 200;
	var buttonXOffset = 50;
	var buttonYOffset = 25;


if (obj_control.stackShowWindowActive) {
	obj_control.mouseoverPanelPane = true;
	obj_control.quickLinkAllowed = false;
	

	draw_set_halign(fa_left);
	draw_set_colour(global.colorThemeBG);
	draw_rectangle(camera_get_view_width(view_camera[0]) /2 - horizontalBuffer, camera_get_view_height(view_camera[0])/2 - verticleBuffer, camera_get_view_width(view_camera[0]) /2 + horizontalBuffer, camera_get_view_height(view_camera[0])/2 + verticleBuffer, false);
	draw_set_colour(global.colorThemePaneBG);
	if (global.colorTheme ==0) {
	draw_set_colour(c_ltgray);
	}
	// draw background UI
	draw_rectangle(camera_get_view_width(view_camera[0]) /2 - horizontalBuffer, camera_get_view_height(view_camera[0])/2 - verticleBuffer + 30, camera_get_view_width(view_camera[0]) /2 + horizontalBuffer, camera_get_view_height(view_camera[0])/2 + verticleBuffer, false);
	draw_set_colour(global.colorThemeBorders);
	draw_rectangle(camera_get_view_width(view_camera[0]) /2 - horizontalBuffer, camera_get_view_height(view_camera[0])/2 - verticleBuffer + 30, camera_get_view_width(view_camera[0]) /2 + horizontalBuffer, camera_get_view_height(view_camera[0])/2 + verticleBuffer, true);
	draw_rectangle(camera_get_view_width(view_camera[0]) /2 - horizontalBuffer, camera_get_view_height(view_camera[0])/2 - verticleBuffer, camera_get_view_width(view_camera[0]) /2 + horizontalBuffer, camera_get_view_height(view_camera[0])/2 + verticleBuffer, true);
	draw_set_colour(global.colorThemeText);
	
	draw_set_font(fnt_mainBold);
	draw_text(camera_get_view_width(view_camera[0])/2 - horizontalBuffer + 15, camera_get_view_height(view_camera[0])/2 - verticleBuffer + 15, string(game_display_name));
	
	draw_set_font(fnt_mainLarge1);

	// draw buttons for OK and Cancel
	draw_set_colour(global.colorThemeBG);
	draw_rectangle(camera_get_view_width(view_camera[0]) /2 + 40 - buttonXOffset, camera_get_view_height(view_camera[0])/2 + 75 - buttonYOffset, camera_get_view_width(view_camera[0]) /2 + 50 + buttonXOffset,camera_get_view_height(view_camera[0])/2 + 75 + buttonYOffset, false);
	draw_set_colour(global.colorThemeBorders);
	draw_rectangle(camera_get_view_width(view_camera[0]) /2 + 40 - buttonXOffset, camera_get_view_height(view_camera[0])/2 + 75 - buttonYOffset, camera_get_view_width(view_camera[0]) /2 + 50 + buttonXOffset,camera_get_view_height(view_camera[0])/2 + 75 + buttonYOffset, true);
	draw_set_colour(global.colorThemeBG);
	draw_rectangle(camera_get_view_width(view_camera[0]) /2 + 180 - buttonXOffset, camera_get_view_height(view_camera[0])/2 + 75 - buttonYOffset, camera_get_view_width(view_camera[0]) /2 + 175 + buttonXOffset,camera_get_view_height(view_camera[0])/2 + 75 + buttonYOffset, false);
	draw_set_colour(global.colorThemeBorders);
	draw_rectangle(camera_get_view_width(view_camera[0]) /2 + 180 - buttonXOffset, camera_get_view_height(view_camera[0])/2 + 75 - buttonYOffset, camera_get_view_width(view_camera[0]) /2 + 175 + buttonXOffset,camera_get_view_height(view_camera[0])/2 + 75 + buttonYOffset, true);
	draw_set_colour(global.colorThemeText);
	draw_set_font(fnt_mainLarge1);
	
	// draw button text
	draw_text(camera_get_view_width(view_camera[0]) /2 + 30, camera_get_view_height(view_camera[0])/2 + 75, "OK");
	draw_text(camera_get_view_width(view_camera[0]) /2 + 150, camera_get_view_height(view_camera[0])/2 + 75, "Cancel");
	

}



// ok button check
if (point_in_rectangle(mouse_x, mouse_y, camera_get_view_width(view_camera[0]) /2 + 50 - buttonXOffset, camera_get_view_height(view_camera[0])/2 + 75 - buttonYOffset, camera_get_view_width(view_camera[0]) /2 + 50 + buttonXOffset, camera_get_view_height(view_camera[0])/2 + 75 + buttonYOffset) && obj_control.stackShowWindowActive){
		if (mouse_check_button_pressed(mb_left)) {
			alarm[11] = 60;
			
			obj_control.stackShowWindowActive = false;
		}
		
}

// cancel button check
if (point_in_rectangle(mouse_x, mouse_y, camera_get_view_width(view_camera[0]) /2 + 175 - buttonXOffset, camera_get_view_height(view_camera[0])/2 + 75 - buttonYOffset, camera_get_view_width(view_camera[0]) /2 + 175 + buttonXOffset, camera_get_view_height(view_camera[0])/2 + 75 + buttonYOffset) && obj_control.stackShowWindowActive){
	if (mouse_check_button_pressed(mb_left)) {
		alarm[11] = 60;

		obj_control.stackShowWindowActive = false;
	}
		
}


// enter check
if ( keyboard_check_pressed(vk_enter) && obj_control.stackShowWindowActive) {
	alarm[11] = 60;

	obj_control.stackShowWindowActive = false;
}


