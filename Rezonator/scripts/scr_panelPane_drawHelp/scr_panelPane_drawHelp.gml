function scr_panelPane_drawHelp() {

	// Establish location of camera
	windowWidth = global.toolPaneWidth;
	var camWidth = camera_get_view_width(camera_get_active());
	var camHeight = camera_get_view_height(camera_get_active());
	x = camWidth - windowWidth;
	y = obj_toolPane.originalWindowHeight + obj_toolPane.windowHeight;

	// Check for mouse location over "Help" button
	var mouseoverHelp = false;
	var toggleButtonAmount = 2;
	var helpMenuGridHeight = ds_grid_height(functionHelp_menuGrid);
	var collapseButtonRad = string_height("A") * 0.5;



	// Set style for button text
	draw_set_alpha(1);
	draw_set_color(global.colorThemeText);
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	
	// set width of help window
	functionHelp_windowWidth = camWidth * 0.3;

	// set x position of help window
	var plusXDest = 0;
	if (functionHelp_collapsed) {
		plusXDest = functionHelp_windowWidth;
	}
	functionHelp_plusX = lerp(functionHelp_plusX, plusXDest, 0.3);


	obj_control.mouseoverHelpPane = false;

	// If helpBox is in view, draw the outline of the box and its contents
	var drawWindow = (abs(functionHelp_plusX - functionHelp_windowWidth) >= 0.1);
	if (drawWindow) {
	
		var helpWindowX2 = camWidth - global.toolPaneWidth + functionHelp_plusX;
		var helpWindowX1 = helpWindowX2 - functionHelp_windowWidth;
		var helpWindowY1 = obj_control.wordTopMargin;
		var helpWindowY2 = camHeight;
		draw_set_color(global.colorThemeBG);
		draw_rectangle(helpWindowX1, helpWindowY1, helpWindowX2, helpWindowY2, false);
		draw_set_color(global.colorThemeBorders);
		draw_rectangle(helpWindowX1, helpWindowY1, helpWindowX2, helpWindowY2, true);
		functionHelp_helpWindowRectX1 = helpWindowX1;
		functionHelp_helpWindowRectY1 = helpWindowY1;
		functionHelp_helpWindowRectX2 = helpWindowX2;
		functionHelp_helpWindowRectY2 = helpWindowY2;
	
		if (point_in_rectangle(mouse_x, mouse_y, helpWindowX1, helpWindowY1, helpWindowX2, helpWindowY2)) {
			if (!functionHelp_collapsed) {
				obj_control.mouseoverHelpPane = true;
			}
			if (mouse_wheel_up() or keyboard_check(vk_up)) {
				scrollPlusYDest += 12;
			}
			else if (mouse_wheel_down() or keyboard_check(vk_down)) {
				scrollPlusYDest -= 12;
			}
		}
	
		var itemSize = 0;
		scr_surfaceStartHelp(helpWindowX1, helpWindowY1, helpWindowX2 - helpWindowX1, helpWindowY2 - helpWindowY1);
	
		// Create and control "All" button
		var textBufferAll = 10;
		draw_set_halign(fa_left);
		draw_set_valign(fa_middle)
		var titleTextAllX = helpWindowX1 + textBufferAll;
		var titleTextAllY = helpWindowY1 + (textBufferAll * 2) + functionHelp_plusY + scrollPlusY;
		draw_set_color(global.colorThemeText);
		var titleTextAllStr = scr_get_translation("menu_all");
		scr_adaptFont(titleTextAllStr, "M");
		draw_text(titleTextAllX - clipX, titleTextAllY - clipY, titleTextAllStr);
		var gridCollapseButtonAllX = titleTextAllX + string_width(titleTextAllStr) + (textBufferAll * 3);
		var gridCollapseButtonAllY = titleTextAllY;
	

	
	
	
		// Draw the mouseoverHelp circles around arrows
		if (point_distance(mouse_x, mouse_y, gridCollapseButtonAllX, gridCollapseButtonAllY) < collapseButtonRad) {
			draw_set_color(global.colorThemeSelected1);
			draw_set_alpha(1);
			draw_circle(gridCollapseButtonAllX - clipX, gridCollapseButtonAllY - clipY, collapseButtonRad, false);
			if (device_mouse_check_button_released(0, mb_left)) {
			
				for(var i = 0; i < helpMenuGridHeight; i++) {
					// Skip past sections already changed
					if((obj_panelPane.functionHelp_allCollapsed and not ds_grid_get(functionHelp_menuGrid, functionHelp_menuGrid_colCollapsed, i)) or (not obj_panelPane.functionHelp_allCollapsed and ds_grid_get(functionHelp_menuGrid, functionHelp_menuGrid_colCollapsed, i))) {
						continue;	
					}
					// Set this section to open/close
					if(not ds_grid_get(functionHelp_menuGrid, functionHelp_menuGrid_colHide, i)) {
						ds_grid_set(functionHelp_menuGrid, functionHelp_menuGrid_colCollapsed, i, not ds_grid_get(functionHelp_menuGrid, functionHelp_menuGrid_colCollapsed, i));
					}
				}
				obj_panelPane.functionHelp_allCollapsed = !obj_panelPane.functionHelp_allCollapsed;
			}
		}
		draw_set_color(global.colorThemeText);
		if (obj_panelPane.functionHelp_allCollapsed) {
			draw_sprite_ext(spr_ascend, 0, gridCollapseButtonAllX - clipX, gridCollapseButtonAllY - clipY, 1, 1, 270, global.colorThemeText, 1);
		}
		else {
			draw_sprite_ext(spr_ascend, 0, gridCollapseButtonAllX - clipX, gridCollapseButtonAllY - clipY, 1, 1, 180, global.colorThemeText, 1);
		}
	
		var cellHeight = string_height("M") + 10;
		var cellPlusY = string_height("M") + 10;
	
	


		
		// Loop through the separate grids to draw titles, and if selected their contents
		for (var i = 0; i < helpMenuGridHeight; i++) {
		
			itemSize++;
			// Check to see if section should be hidden or not
			if (not ds_grid_get(functionHelp_menuGrid, functionHelp_menuGrid_colHide, i)) {
				// Space the sections evenly
				if(i != 0) {
					cellPlusY += string_height("M");
				}
				// Draw the function title text
				var textBuffer = 10;
				draw_set_halign(fa_left);
				draw_set_valign(fa_middle)
				var titleTextX = helpWindowX1 + textBuffer;
				var titleTextY = helpWindowY1 + (textBuffer * 2) + functionHelp_plusY + cellPlusY + scrollPlusY;
				draw_set_color(global.colorThemeText);
				var titleTextStr = ds_grid_get(functionHelp_menuGrid, functionHelp_menuGrid_colName, i);
				scr_adaptFont(scr_get_translation(titleTextStr), "S");
				draw_text(titleTextX - clipX, titleTextY - clipY, scr_get_translation(titleTextStr));
				var gridCollapseButtonX = titleTextX + string_width(scr_get_translation(titleTextStr)) + (textBuffer * 3);
				var gridCollapseButtonY = titleTextY;
	
				// draw the toggle arrows
				draw_set_alpha(1);
			
				// Draw the mouseoverHelp circles around arrows
				if (point_distance(mouse_x, mouse_y, gridCollapseButtonX, gridCollapseButtonY) < collapseButtonRad) {
					//draw_set_color(global.colorThemeText);
					//draw_set_alpha(0.5);
					draw_set_color(global.colorThemeSelected1);
					draw_circle(gridCollapseButtonX - clipX, gridCollapseButtonY - clipY, collapseButtonRad, false);
					if (device_mouse_check_button_released(0, mb_left)) {
						ds_grid_set(functionHelp_menuGrid, functionHelp_menuGrid_colCollapsed, i, not ds_grid_get(functionHelp_menuGrid, functionHelp_menuGrid_colCollapsed, i));
					}
				}
				draw_set_color(global.colorThemeText);
			
				// draw the toggle arrows
				if (ds_grid_get(functionHelp_menuGrid, functionHelp_menuGrid_colCollapsed, i)) {
					draw_sprite_ext(spr_ascend, 0, gridCollapseButtonX - clipX, gridCollapseButtonY - clipY, 1, 1, 270, global.colorThemeText, 1);
				}
				else {
					draw_sprite_ext(spr_ascend, 0, gridCollapseButtonX - clipX, gridCollapseButtonY - clipY, 1, 1, 180, global.colorThemeText, 1);
				}
				draw_set_alpha(1);
	
				cellPlusY += string_height("M");	
			
				// If section is not collapsed, loop through and draw the contents
				if (not ds_grid_get(functionHelp_menuGrid, functionHelp_menuGrid_colCollapsed, i)) {
					var currentHelpGrid  = ds_grid_get(functionHelp_menuGrid, functionHelp_menuGrid_colGrid, i)
					var currentHelpGridHeight = ds_grid_height(currentHelpGrid);
					for (var j = 0; j < currentHelpGridHeight; j++) {
					
						itemSize++;
					
						// Do not draw hidden contents
						if(not ds_grid_get(currentHelpGrid, functionHelp_helpGrid_colHide, j)) {
				
							var cellRectX1 = helpWindowX1 + textBuffer;
							var cellRectY1 = helpWindowY1 + (textBuffer * 2) + functionHelp_plusY + cellPlusY + scrollPlusY;
							var cellRectX2 = helpWindowX2 - textBuffer;
							var cellRectY2 = cellRectY1 + cellHeight;
		
							//Alternate grey and white for drawing text backgrounds
							if (j mod 2) {
								draw_set_color(global.colorThemeBG);
							}
							else {
								draw_set_alpha(0.4);
								draw_set_color(global.colorThemeSelected1);
							}
							draw_rectangle(cellRectX1 - clipX, cellRectY1 - clipY, cellRectX2 - clipX, cellRectY2 - clipY, false);
							draw_set_alpha(1);
							draw_set_color(global.colorThemeText);
							
							draw_set_halign(fa_left);
							draw_set_valign(fa_middle);
						
							// Collect contents infor from selected grid
							var currentStrKey = ds_grid_get(currentHelpGrid, functionHelp_helpGrid_colKey, j);
							var currentStrFunc = ds_grid_get(currentHelpGrid, functionHelp_helpGrid_colFunc, j);
							var currentStrDesc = ds_grid_get(currentHelpGrid, functionHelp_helpGrid_colDesc, j);
							scr_adaptFont(scr_get_translation(currentStrKey), "S");
							draw_text(floor(cellRectX1 + textBuffer - clipX), floor(mean(cellRectY1, cellRectY2) - clipY), scr_get_translation(currentStrKey));
							if(currentStrFunc == "help_label_download" || currentStrFunc == "help_label_about") {
								draw_set_color(c_blue);
							}
							draw_text(floor(mean(cellRectX1, cellRectX2) + textBuffer - clipX), floor(mean(cellRectY1, cellRectY2) - clipY), scr_get_translation(currentStrFunc));
							draw_set_color(global.colorThemeText);
						
							// Check for mouseoverHelp over content, if so, then show extra content
							if(point_in_rectangle(mouse_x, mouse_y, cellRectX1, cellRectY1, cellRectX2, cellRectY2)) {
								draw_rectangle(cellRectX1 - clipX, cellRectY1 - clipY, cellRectX2 - clipX, cellRectY2 + cellHeight - 1 - clipY, true);
								if (j mod 2) {
									draw_set_color(global.colorThemeBG);
								}
								else {
									draw_set_alpha(0.4);
									draw_set_color(global.colorThemeSelected1);
								}
								draw_rectangle(cellRectX1 + 1 - clipX, cellRectY1 + cellHeight - clipY, cellRectX2 - 1 - clipX, cellRectY2 + cellHeight - 2 - clipY, false);
								draw_set_alpha(1);
								draw_set_color(global.colorThemeText);
								draw_text(floor(cellRectX1 + textBuffer - clipX), floor(mean(cellRectY1 + cellHeight, cellRectY2 + cellHeight) - clipY), scr_get_translation(currentStrDesc));
								cellPlusY += (2 * cellHeight);
							
								if(device_mouse_check_button_released(0, mb_left)) { // Clicking the About sections will open the user's browser to one of these two URL's
									if(currentStrFunc == "help_label_download") {
										url_open("https://rezonator.com/download/");
									}
									else if (currentStrFunc == "help_label_about"){
										url_open("https://rezonator.com/");
									}
								}
							}
							else {
								cellPlusY += cellHeight;
							}
						}
					}
				}
			}
		}
	
		scr_scrollBarHelp(itemSize, -1, cellHeight, 0, 
		global.colorThemeSelected1, global.colorThemeSelected2,
		global.colorThemeSelected1, global.colorThemeSelected2, spr_ascend, (helpWindowX2 - helpWindowX1), helpWindowY2 - helpWindowY1,
		helpWindowX1, helpWindowY1);
	
		scr_surfaceEnd();
	}

	var displayString = "";

	for (var i = 0; i < toggleButtonAmount; i++) {
		//draw tooltips
		if(obj_panelPane.hoverTime[i] == obj_toolPane.hoverTimeLimit){
			obj_toolPane.ToolTipPosX = mouse_x;
			obj_toolPane.ToolTipPosY = mouse_y;
		}
		else if(obj_panelPane.hoverTime[i] > obj_toolPane.hoverTimeLimit){
			/*if (i == 0) {
				if(obj_control.wordTokenView){
					displayString = "Token View"
				}
				else{
					displayString = "Transcript View"
				}
				scr_drawToolTip(obj_toolPane.ToolTipPosX, obj_toolPane.ToolTipPosY, displayString , "top");
			}*/
			if (i == 0) {
				if (obj_control.shape == obj_control.shapeBlock) {
					displayString = "Column View"
				}
				else{
					displayString = "Justified View"

				}
				//scr_drawToolTip(obj_toolPane.ToolTipPosX, obj_toolPane.ToolTipPosY, displayString, "top" );
			}
			else if (i == 1) {
				if (obj_control.gridView) {
					displayString = "Grid View"
				}
				else{
					displayString = "Text View"
				}
				//scr_drawToolTip(obj_toolPane.ToolTipPosX, obj_toolPane.ToolTipPosY, displayString , "top");
			}
			else if (i == 2) {
				//scr_drawToolTip(obj_toolPane.ToolTipPosX, obj_toolPane.ToolTipPosY, "Help", "top");
			}
		}
	}

scr_adaptFont(scr_get_translation(displayString), "M");


}
