function scr_panelPane_drawFilter() {
	/*
		scr_panelPane_drawFilter();
	
		Last Updated: 2019-01-29
	
		Called from: obj_panelPane
	
		Purpose: Renders the filter in the main screen, and sets only selected chains to be filtered to appear in the chain list when filter is turned on Renders the filter in the main screen
	
		Mechanism: Loop through chain list to check for filtered chains, and check for mouse clicks to filter a certain chain
	
		Author: Terry DuBois, Georgio Klironomos
	*/

	// Set contraints for filter button

	windowWidth = functionTabs_tabHeight;

	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);

	var filterButtonX1 = x;
	var filterButtonY1 = y;
	var filterButtonX2 = x + windowWidth;
	var filterButtonY2 = y + functionTabs_tabHeight +1;

	// Draw filter button, and check for coloring
	draw_sprite_ext(spr_filterIcons, obj_control.filterGridActive, mean(filterButtonX1, filterButtonX2), mean(filterButtonY1, filterButtonY2), 1, 1, 0, c_white, 1);

	var filterButtonSize = filterButtonY2 - filterButtonY1;



	// Draw Next, Tween, and Previous buttons, and check for mouse clicks
	for (var i = 0; i < 3; i++) {
	
		// Draw rectangles
		var peekButtonRectX1 = x;
		var peekButtonRectY1 = filterButtonY2 + (i * ((windowHeight - (filterButtonSize)) / 3));
		var peekButtonRectX2 = peekButtonRectX1 + windowWidth;
		var peekButtonRectY2 = peekButtonRectY1 + ((windowHeight - (filterButtonSize)) / 3);
	
		// If mouse clicked in button, activate/deavtivate button's function
		if (point_in_rectangle(mouse_x, mouse_y, peekButtonRectX1, peekButtonRectY1, peekButtonRectX2, peekButtonRectY2)) {
			var tooltipText = "";
			if (i == 0) {
				tooltipText = "Context above";
			}
			else if (i == 1) {
				tooltipText = "Context between";
			}
			else if (i == 2) {
				tooltipText = "Context below";
			}
			scr_createTooltip(peekButtonRectX2, mean(peekButtonRectY1, peekButtonRectY2), tooltipText, obj_tooltip.arrowFaceLeft);
			
			obj_control.hoverTime[i]++;
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
		else{
			obj_control.hoverTime[i] = 0;
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
	/*
	for (var i = 0; i < 3; i++) {
		//draw tooltips
		if(obj_control.hoverTime[i] == obj_toolPane.hoverTimeLimit){
			obj_toolPane.ToolTipPosX = mouse_x;
			obj_toolPane.ToolTipPosY = mouse_y;
		}
		else if(obj_control.hoverTime[i] > obj_toolPane.hoverTimeLimit){
			if (i == 0) {
				scr_drawToolTip(obj_toolPane.ToolTipPosX, obj_toolPane.ToolTipPosY, "Context Above", "left");
			}
			else if (i == 1) {
				scr_drawToolTip(obj_toolPane.ToolTipPosX, obj_toolPane.ToolTipPosY, "Context Between", "left");
			}
			else if (i == 2) {
				scr_drawToolTip(obj_toolPane.ToolTipPosX, obj_toolPane.ToolTipPosY, "Context below", "left");

			}
		}
	}
	*/


	// Check for mouse clicks on filter button, if we're out of the search grid
	if(obj_control.currentActiveLineGrid != obj_control.searchGrid){
		var filterButtonClicked = (point_in_rectangle(mouse_x, mouse_y, filterButtonX1, filterButtonY1, filterButtonX2, filterButtonY2) and device_mouse_check_button_released(0, mb_left));
		var filterShortcut = (keyboard_check(vk_control) and (keyboard_check_pressed(ord("P"))));
		if ((filterButtonClicked || filterShortcut) and !instance_exists(obj_dialogueBox) and !instance_exists(obj_dropDown) and obj_control.mouseoverTagShortcut == "") {
			
			if(obj_control.quickFilterGridActive){
				obj_control.quickFilterGridActive = false;
			}
			
			// If filter is active, deactivate it
			if (obj_control.filterGridActive) {
				if(obj_control.currentCenterDisplayRow >= 0 and obj_control.currentCenterDisplayRow < ds_grid_height(obj_control.filterGrid)) {
					//obj_control.currentStackShowListPosition = ds_list_size(obj_control.stackShowList);
					//obj_control.prevCenterYDest = ds_grid_get(obj_control.filterGrid, obj_control.lineGrid_colUnitID, obj_control.currentCenterDisplayRow);
					obj_control.scrollPlusYDest = obj_control.prevCenterYDest;
					// Keep the focus on previous currentCenterDisplayRow
				}
			
				// Switch to active grid
				obj_control.filterGridActive = false;
				obj_control.currentActiveLineGrid = obj_control.lineGrid;
			}
			else {
				
				obj_control.prevCenterYDest = obj_control.scrollPlusYDest;
				// If filter is unactive. activate it
				with (obj_control) {
					scr_renderFilter();
				}
			}
			// Add to moveCounter
			obj_control.moveCounter ++;
		}
	
		if (point_in_rectangle(mouse_x, mouse_y, filterButtonX1, filterButtonY1, filterButtonX2, filterButtonY2)) {
			scr_createTooltip(filterButtonX2, mean(filterButtonY1, filterButtonY2), (obj_control.filterGridActive) ? "Deactivate filter" : "Activate filter", obj_tooltip.arrowFaceLeft);
		}
	}


}
