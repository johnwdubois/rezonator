/*
	scr_panelPane_drawFilter();
	
	Last Updated: 2019-01-29
	
	Called from: obj_panelPane
	
	Purpose: Renders the filter in the main screen, and sets only selected chains to be filtered to appear in the chain list when filter is turned on Renders the filter in the main screen
	
	Mechanism: Loop through chain list to check for filtered chains, and check for mouse clicks to filter a certain chain
	
	Author: Terry DuBois, Georgio Klironomos
*/

// Set contraints for filter button
var filterButtonRadius = 8;

draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_font(fnt_chainContents);

var filterButtonX = x + (windowWidth / 2);
var filterButtonY = y + filterButtonRadius;

// Draw filter button, and check for coloring
if (obj_control.filterGridActive) {	
	draw_set_color(global.colorThemeText);
	draw_circle(filterButtonX, filterButtonY, filterButtonRadius, false);
	draw_set_color(global.colorThemeBG);
	draw_text(filterButtonX, filterButtonY, "F");
}
else {
	draw_set_color(global.colorThemeText);
	draw_circle(filterButtonX, filterButtonY, filterButtonRadius, true);
	draw_text(filterButtonX, filterButtonY, "F");
}

draw_set_halign(fa_center);

// Draw Next, Tween, and Previous buttons, and check for mouse clicks
for (var i = 0; i < 3; i++) {
	
	// Draw rectangles
	var peekButtonRectX1 = x;
	var peekButtonRectY1 = y + (filterButtonRadius * 2) + (i * ((windowHeight - (filterButtonRadius * 2)) / 3));
	var peekButtonRectX2 = peekButtonRectX1 + windowWidth;
	var peekButtonRectY2 = peekButtonRectY1 + ((windowHeight - (filterButtonRadius * 2)) / 3);
	
	// If mouse clicked in button, activate/deavtivate button's function
	if (point_in_rectangle(mouse_x, mouse_y, peekButtonRectX1, peekButtonRectY1, peekButtonRectX2, peekButtonRectY2)){
		if (device_mouse_check_button_released(0, mb_left)) {
			
			// Re/activate function
			with (obj_panelPane) {
				functionFilter_peek[i] = !functionFilter_peek[i];
			}

			// Rerender filter
			if (obj_control.filterGridActive) {
				with (obj_control) {
					scr_renderFilter();
				}
			}
		}
	}
	
	// Recolor slected buttons
	if (functionFilter_peek[i]) {
		draw_set_color(obj_control.c_ltblue);
		draw_rectangle(peekButtonRectX1, peekButtonRectY1, peekButtonRectX2, peekButtonRectY2, false);
	}
	
	// Draw icons in buttons
	draw_set_color(global.colorThemeText);
	draw_set_alpha(1);
	draw_sprite(spr_filterArrows, i, mean(peekButtonRectX1, peekButtonRectX2), mean(peekButtonRectY1, peekButtonRectY2));
	
	draw_rectangle(peekButtonRectX1, peekButtonRectY1, peekButtonRectX2, peekButtonRectY2, true);
}

// Check for mouse clicks on filter button, if we're out of the search grid
if(obj_control.currentActiveLineGrid != obj_control.searchGrid){
	if ((point_in_circle(mouse_x, mouse_y, filterButtonX, filterButtonY, filterButtonRadius) and device_mouse_check_button_released(0, mb_left))
	or (keyboard_check(vk_control) and keyboard_check_pressed(ord("P")))) {
		// If filter is active, deactivate it
		if (obj_control.filterGridActive) {
			if(obj_control.currentCenterDisplayRow >= 0 and obj_control.currentCenterDisplayRow < ds_grid_height(obj_control.filterGrid)) {
				//obj_control.currentStackShowListPosition = ds_list_size(obj_control.stackShowList);
				//obj_control.prevCenterDisplayRow = ds_grid_get(obj_control.filterGrid, obj_control.lineGrid_colUnitID, obj_control.currentCenterDisplayRow);
				obj_control.scrollPlusYDest = obj_control.prevCenterDisplayRow;
				// Keep the focus on previous currentCenterDisplayRow
				//with (obj_control) {
				//	alarm[5] = 1;
				//}
			}
			
			// Switch to active grid
			obj_control.filterGridActive = false;
			obj_control.currentActiveLineGrid = obj_control.lineGrid;
		}
		else {
			
			obj_control.prevCenterDisplayRow = obj_control.scrollPlusYDest;
			// If filter is unactive. activate it
			with (obj_control) {
				scr_renderFilter();
			}
		}
		// Add to moveCounter
		obj_control.moveCounter ++;
	}
	if (point_in_circle(mouse_x, mouse_y, filterButtonX, filterButtonY, filterButtonRadius)) {
		draw_set_colour(global.colorThemeBG);
		draw_rectangle(mouse_x + 110, mouse_y + 25, mouse_x + 250, mouse_y + 55, false);
		draw_set_colour(global.colorThemeBorders);
		draw_rectangle(mouse_x + 110, mouse_y + 25, mouse_x + 250, mouse_y + 55, true);
		draw_set_colour(global.colorThemeText);
		draw_set_font(fnt_mainBold);
		draw_text(mouse_x + 182, mouse_y + 40, "Activate Filter");	
		draw_set_font(global.fontChainList);
	}
}