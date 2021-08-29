function scr_drawBackArrow() {
	var backArrowX = sprite_get_width(spr_backArrow) / 2;
	var backArrowY = sprite_get_height(spr_backArrow) / 2;

	draw_sprite_ext(spr_backArrow, 0, backArrowX, backArrowY, 1, 1, 0, c_white, 1);

	var backArrowRectX1 = backArrowX - sprite_get_width(spr_backArrow) / 2;
	var backArrowRectY1 = backArrowY - sprite_get_height(spr_backArrow) / 2;
	var backArrowRectX2 = backArrowRectX1 + sprite_get_width(spr_backArrow);
	var backArrowRectY2 = backArrowRectY1 + sprite_get_height(spr_backArrow);
	
	var triggerBackArrow = false;

	if (point_in_rectangle(mouse_x, mouse_y, backArrowRectX1, backArrowRectY1, backArrowRectX2, backArrowRectY2)) {
	
		draw_set_color(global.colorThemeBorders);
		draw_set_alpha(1);
		draw_rectangle(backArrowRectX1, backArrowRectY1, backArrowRectX2, backArrowRectY2, true);
	
		if (mouse_check_button_released(mb_left)) {
			triggerBackArrow = true;
		}
	}
	
	if (keyboard_check_released(vk_escape)) {
		triggerBackArrow = true;
	}
	
	if (triggerBackArrow) {
		global.newProject = false;
		global.openProject = false;
		global.neworOpen = true;
		if (instance_exists(obj_openingScreen)) {
			with (obj_openingScreen) {
				documentationButtonActive = false;
				alarm[3] = 3;
			}
		}
		
		if (room == rm_importScreen) {
			show_debug_message("Going to openingScreen, scr_drawBackArrow");
			room_goto(rm_openingScreen)
		}
	}


}
