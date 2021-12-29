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
	
	// Set vraibles for checking mouse click
	var backArrowRectX1 = backArrowX - spriteWidth / 2;
	var backArrowRectY1 = backArrowY - spriteHeight / 2;
	var backArrowRectX2 = backArrowRectX1 + spriteWidth;
	var backArrowRectY2 = backArrowRectY1 + spriteHeight;
	
	// Check for mouse hover over
	var mouseover = point_in_circle(mouse_x, mouse_y, backArrowX, backArrowY, spriteWidth / 2);
	if (mouseover) {
	
		draw_set_color(global.colorThemeSelected2);
		draw_set_alpha(0.35);
		draw_circle(backArrowX, backArrowY, spriteWidth / 2, false);
		draw_set_alpha(1);
		obj_control.mouseoverPanelPane = true;
		
		// Check for mouse click
		if (mouse_check_button_released(mb_left)) {
			if (obj_control.gridView) {
				obj_control.gridView = false;
			}
			
			if (obj_control.currentView != obj_control.mainView) {
				scr_disableFilter();
			}
		}
		
		var tooltipText = "";
		if (obj_control.gridView) tooltipText = scr_get_translation("label_back");
		else tooltipText = scr_get_translation("menu_clear");
		scr_createTooltip(backArrowRectX2, mean(backArrowRectY1, backArrowRectY2), tooltipText, obj_tooltip.arrowFaceLeft);
	}
	
	// Draw the arrow sprite
	if(global.colorTheme == 0){
		draw_sprite_ext(spr_backArrow, 0, backArrowX, backArrowY, spriteSize, spriteSize, 0, global.colorThemeBorders, 1);
	}else if(global.colorTheme == 1){      // dark mode, create a white back arrow
		draw_sprite_ext(spr_backArrowWhite, 0, backArrowX, backArrowY, spriteSize, spriteSize, 0, global.colorThemeBorders, 1);
	}


}
