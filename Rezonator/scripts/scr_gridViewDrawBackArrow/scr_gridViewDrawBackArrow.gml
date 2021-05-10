/*
	Purpose: Allow for a UI element taking the user back to the main screen from the Grid View, Search Screen, and Filter View
*/
function scr_gridViewDrawBackArrow() {
	
	//Prevent drawing and clicking if a Dropdown is onscreen
	if(instance_exists(obj_dropDown)) {
		exit;
	}
	
	// Allow for text and arrow to resize based on user's textsize
	var standardHeight = 12;
	var largeHeight = 22;
	var spriteRatio = largeHeight/standardHeight;
	var spriteSize = 1;

	var spriteWidth = sprite_get_width(spr_backArrow) * spriteSize;
	var spriteHeight = sprite_get_height(spr_backArrow) * spriteSize;

	// Set the arrow in the bottom right column
	var backArrowX = spriteWidth;
	var backArrowY = camera_get_view_height(camera_get_active()) - spriteHeight;

	// Draw the arrow sprite
	draw_sprite_ext(spr_backArrow, 0, backArrowX, backArrowY, spriteSize, spriteSize, 0, global.colorThemeBorders, 1);

	// Set vraibles for checking mouse click
	var backArrowRectX1 = backArrowX - spriteWidth / 2;
	var backArrowRectY1 = backArrowY - spriteHeight / 2;
	var backArrowRectX2 = backArrowRectX1 + spriteWidth;
	var backArrowRectY2 = backArrowRectY1 + spriteHeight;

	// Draw text
	draw_set_colour(global.colorThemeBG);
	draw_set_halign(fa_center);
	//draw_text((backArrowRectX1 + backArrowRectX2)/2, (backArrowRectY1 + backArrowRectY2)/2, scr_get_translation("label_back"));

	// Check for mouse hover over
	if (point_in_rectangle(mouse_x, mouse_y, backArrowRectX1, backArrowRectY1, backArrowRectX2, backArrowRectY2)) {
	
		draw_set_color(global.colorThemeBorders);
		draw_set_alpha(1);
		draw_rectangle(backArrowRectX1, backArrowRectY1, backArrowRectX2, backArrowRectY2, true);
		obj_control.mouseoverPanelPane = true;
		
		// Check for mouse click
		if (mouse_check_button_released(mb_left)) {
			if (obj_control.gridView) {
				obj_control.gridView = false;
			}
			
			
			if(obj_control.filterGridActive) { 
				scr_disableFilter();
			}
			
		}
	}


}
