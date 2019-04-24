/*
	scr_panelPane_drawchainContentsLoop();
	
	Last Updated: 2018-07-12
	
	Called from: obj_panelPane
	
	Purpose: whatever chain is focused on in the chainList panelPane, draw information on the individual contents of that chain
	
	Mechanism: loop through the IDList of the focused chain and gather information from corresponding grids
	
	Author: Terry DuBois
*/

// Establish location of camera
var camWidth = camera_get_view_width(view_camera[0]);
x = camWidth - windowWidth;
y = obj_toolPane.y + obj_toolPane.windowHeight;

// Check for mouse location over "Help" button
var mouseover = false;
if (point_in_rectangle(mouse_x, mouse_y, x, y, x + windowWidth, y + windowHeight)) {
	mouseover = true;
}

// Toggle collapse if mouseClick
if (mouseover and mouse_check_button_pressed(mb_left)) {
	functionHelp_collapsed = !functionHelp_collapsed;
}

// Set style for button text
draw_set_alpha(1);
draw_set_font(fnt_mainBold);
draw_set_color(global.colorThemeText);
draw_set_halign(fa_left);
draw_set_valign(fa_middle);

// Draw either button & helpBox, or just button depending
if (functionHelp_collapsed) {
	draw_set_color(global.colorThemeText);
	draw_text(x + 10, y + (windowHeight / 2), "Help");
	
	if (functionHelp_plusX <= camWidth) {
		functionHelp_plusX += abs(functionHelp_plusX - camWidth) / 4 ;
	}

}
else {
	draw_set_color(global.colorThemeText);
	draw_rectangle(x, y, x + windowWidth, y + windowHeight, false);
	draw_set_color(global.colorThemeBG);
	draw_text(x + 10, y + (windowHeight / 2), "Help");

	if (functionHelp_plusX <= camWidth - functionHelp_windowWidth) {
		functionHelp_plusX += abs(functionHelp_plusX - (camWidth - functionHelp_windowWidth)) / 4;
	}
	if (functionHelp_plusX >= camWidth - functionHelp_windowWidth) {
		functionHelp_plusX -= abs(functionHelp_plusX - (camWidth - functionHelp_windowWidth)) / 4;
	}
}

// If helpBox is in view, draw the outline of the box and its contents
if !(abs(functionHelp_plusX - camWidth) < 0.1) {
	var helpWindowX1 = functionHelp_plusX;
	var helpWindowY1 = obj_toolPane.y + obj_toolPane.windowHeight + windowHeight;
	var helpWindowX2 = helpWindowX1 + functionHelp_windowWidth;
	var helpWindowY2 = camera_get_view_height(view_camera[0]);
	draw_set_color(global.colorThemeBG);
	draw_rectangle(helpWindowX1, helpWindowY1, helpWindowX2, helpWindowY2, false);
	draw_set_color(global.colorThemeBorders);
	draw_rectangle(helpWindowX1, helpWindowY1, helpWindowX2, helpWindowY2, true);
	functionHelp_helpWindowRectX1 = helpWindowX1;
	functionHelp_helpWindowRectY1 = helpWindowY1;
	functionHelp_helpWindowRectX2 = helpWindowX2;
	functionHelp_helpWindowRectY2 = helpWindowY2;
	
	// Create and control "All" button
	var textBufferAll = 10;
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle)
	draw_set_font(fnt_mainBold);
	var titleTextAllX = helpWindowX1 + textBufferAll;
	var titleTextAllY = helpWindowY1 + (textBufferAll * 2) + functionHelp_plusY; 
	draw_set_color(global.colorThemeText);
	var titleTextAllStr = "All";
	draw_text(titleTextAllX, titleTextAllY, titleTextAllStr);
	var gridCollapseButtonAllX = titleTextAllX + string_width(titleTextAllStr) + (textBufferAll * 2);
	var gridCollapseButtonAllY = titleTextAllY;
	
	if (obj_panelPane.functionHelp_allCollapsed) {
		draw_sprite_ext(spr_ascend, 0, gridCollapseButtonAllX, gridCollapseButtonAllY, 1, 1, 270, c_white, 1);
	}
	else {
		draw_sprite_ext(spr_ascend, 0, gridCollapseButtonAllX, gridCollapseButtonAllY, 1, 1, 180, c_white, 1);
	}
	
	// Draw the mouseover circles around arrows
	if (point_distance(mouse_x, mouse_y, gridCollapseButtonAllX, gridCollapseButtonAllY) < 10) {
		draw_set_color(global.colorThemeText);
		draw_set_alpha(1);
		draw_circle(gridCollapseButtonAllX, gridCollapseButtonAllY, 10, true);
		if (mouse_check_button_pressed(mb_left)) {
			for(var i = 0; i < ds_grid_height(functionHelp_menuGrid); i++) {
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
	
	var cellHeight = 14;
	var cellPlusY = 20;

	// Loop through the separate grids to draw titles, and if selected their contents
	for(var i = 0; i < ds_grid_height(functionHelp_menuGrid); i++) {
		// Check to see if section should be hidden or not
		if(not ds_grid_get(functionHelp_menuGrid, functionHelp_menuGrid_colHide, i)) {
			// Space the sections evenly
			if(i != 0) {
				cellPlusY += 16;
			}
			// Draw the function title text
			var textBuffer = 10;
			draw_set_halign(fa_left);
			draw_set_valign(fa_middle)
			draw_set_font(fnt_mainBold);
			var titleTextX = helpWindowX1 + textBuffer;
			var titleTextY = helpWindowY1 + (textBuffer * 2) + functionHelp_plusY + cellPlusY; 
			draw_set_color(global.colorThemeText);
			var titleTextStr = ds_grid_get(functionHelp_menuGrid, functionHelp_menuGrid_colName, i);
			draw_text(titleTextX, titleTextY, titleTextStr);
			var gridCollapseButtonX = titleTextX + string_width(titleTextStr) + (textBuffer * 2);
			var gridCollapseButtonY = titleTextY;
	
			// draw the toggle arrows
			if (ds_grid_get(functionHelp_menuGrid, functionHelp_menuGrid_colCollapsed, i)) {
				draw_sprite_ext(spr_ascend, 0, gridCollapseButtonX, gridCollapseButtonY, 1, 1, 270, c_white, 1);
			}
			else {
				draw_sprite_ext(spr_ascend, 0, gridCollapseButtonX, gridCollapseButtonY, 1, 1, 180, c_white, 1);
			}
	
			// Draw the mouseover circles around arrows
			if (point_distance(mouse_x, mouse_y, gridCollapseButtonX, gridCollapseButtonY) < 10) {
				draw_set_color(global.colorThemeText);
				draw_set_alpha(1);
				draw_circle(gridCollapseButtonX, gridCollapseButtonY, 10, true);
				if (mouse_check_button_pressed(mb_left)) {
					ds_grid_set(functionHelp_menuGrid, functionHelp_menuGrid_colCollapsed, i, not ds_grid_get(functionHelp_menuGrid, functionHelp_menuGrid_colCollapsed, i));
				}
			}
	
			cellPlusY += 16;	
			
			// If section is not collapsed, loop through and draw the contents
			if (not ds_grid_get(functionHelp_menuGrid, functionHelp_menuGrid_colCollapsed, i)) {
				var currentHelpGrid  = ds_grid_get(functionHelp_menuGrid, functionHelp_menuGrid_colGrid, i)
				for (var j = 0; j < ds_grid_height(currentHelpGrid); j++) {
					// Do not draw hidden contents
					if(not ds_grid_get(currentHelpGrid, functionHelp_helpGrid_colHide, j)) {
				
						var cellRectX1 = helpWindowX1 + textBuffer;
						var cellRectY1 = helpWindowY1 + (textBuffer * 2) + functionHelp_plusY + cellPlusY;
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
						draw_rectangle(cellRectX1, cellRectY1, cellRectX2, cellRectY2, false);
						draw_set_alpha(1);
						draw_set_color(global.colorThemeText);
						draw_set_font(fnt_chainContents);
						draw_set_halign(fa_left);
						draw_set_valign(fa_middle);
						
						// Collect contents infor from selected grid
						var currentStrKey = ds_grid_get(currentHelpGrid, functionHelp_helpGrid_colKey, j);
						var currentStrFunc = ds_grid_get(currentHelpGrid, functionHelp_helpGrid_colFunc, j);
						var currentStrDesc = ds_grid_get(currentHelpGrid, functionHelp_helpGrid_colDesc, j);
						draw_text(cellRectX1 + textBuffer, mean(cellRectY1, cellRectY2), currentStrKey);
						draw_text(mean(cellRectX1, cellRectX2) + textBuffer, mean(cellRectY1, cellRectY2), currentStrFunc);
						
						// Check for mouseover over content, if so, then show extra content
						if(point_in_rectangle(mouse_x, mouse_y, cellRectX1, cellRectY1, cellRectX2, cellRectY2)) {
							draw_rectangle(cellRectX1, cellRectY1, cellRectX2, cellRectY2 + cellHeight - 1, true);
							if (j mod 2) {
								draw_set_color(global.colorThemeBG);
							}
							else {
								draw_set_alpha(0.4);
								draw_set_color(global.colorThemeSelected1);
							}
							draw_rectangle(cellRectX1 + 1, cellRectY1 + cellHeight, cellRectX2 - 1, cellRectY2 + cellHeight-2, false);
							draw_set_alpha(1);
							draw_set_color(global.colorThemeText);
							draw_text(cellRectX1 + textBuffer, mean(cellRectY1 + cellHeight, cellRectY2 + cellHeight), currentStrDesc);
							cellPlusY += (2 * cellHeight);
						}
						else {
						cellPlusY += cellHeight;
						}
					}
				}
			}
		}
	}
//}
	/*
	
	var textBuffer = 10;
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle)
	draw_set_font(fnt_mainBold);
	var titleTextX = helpWindowX1 + textBuffer;
	var titleTextY = helpWindowY1 + (textBuffer * 2) + functionHelp_plusY;
	draw_set_color(global.colorThemeText);
	var titleTextStr = "Rezonator Functions";
	draw_text(titleTextX, titleTextY, titleTextStr);
	var gridCollapseButtonX = titleTextX + string_width(titleTextStr) + (textBuffer * 2);
	var gridCollapseButtonY = titleTextY;
	
	if (functionHelp_rezCollapsed) {
		draw_sprite_ext(spr_ascend, 0, gridCollapseButtonX, gridCollapseButtonY, 1, 1, 270, c_white, 1);
	}
	else {
		draw_sprite_ext(spr_ascend, 0, gridCollapseButtonX, gridCollapseButtonY, 1, 1, 180, c_white, 1);
	}
	
	if (point_distance(mouse_x, mouse_y, gridCollapseButtonX, gridCollapseButtonY) < 10) {
		draw_set_color(global.colorThemeText);
		draw_set_alpha(1);
		draw_circle(gridCollapseButtonX, gridCollapseButtonY, 10, true);
		if (mouse_check_button_pressed(mb_left)) {
			functionHelp_rezCollapsed = !functionHelp_rezCollapsed;
		}
	}
	
	var cellHeight = 14;
	var cellPlusY = 16;
	
	if (!functionHelp_rezCollapsed) {
		for (var i = 0; i < ds_grid_height(functionHelp_helpGridRez); i++) {
			var cellRectX1 = helpWindowX1 + textBuffer;
			var cellRectY1 = helpWindowY1 + (textBuffer * 2) + functionHelp_plusY + cellPlusY;
			var cellRectX2 = helpWindowX2 - textBuffer;
			var cellRectY2 = cellRectY1 + cellHeight;
		
			if (i mod 2) {
				draw_set_color(global.colorThemeBG);
			}
			else {
				draw_set_alpha(0.4);
				draw_set_color(global.colorThemeSelected1);
			}
			draw_rectangle(cellRectX1, cellRectY1, cellRectX2, cellRectY2, false);
			draw_set_alpha(1);
			draw_set_color(global.colorThemeText);
			draw_set_font(fnt_chainContents);
			draw_set_halign(fa_left);
			draw_set_valign(fa_middle);
			var currentStrKey = ds_grid_get(functionHelp_helpGridRez, functionHelp_helpGrid_colKey, i);
			var currentStrFunc = ds_grid_get(functionHelp_helpGridRez, functionHelp_helpGrid_colFunc, i);
			var currentStrDesc = ds_grid_get(functionHelp_helpGridRez, functionHelp_helpGrid_colDesc, i);
			draw_text(cellRectX1 + textBuffer, mean(cellRectY1, cellRectY2), currentStrKey);
			draw_text(mean(cellRectX1, cellRectX2) + textBuffer, mean(cellRectY1, cellRectY2), currentStrFunc);
			if(point_in_rectangle(mouse_x, mouse_y, cellRectX1, cellRectY1, cellRectX2, cellRectY2)) {
				draw_rectangle(cellRectX1, cellRectY1, cellRectX2, cellRectY2 + cellHeight - 1, true);
				if (i mod 2) {
					draw_set_color(global.colorThemeBG);
				}
				else {
					draw_set_alpha(0.4);
					draw_set_color(global.colorThemeSelected1);
				}
				draw_rectangle(cellRectX1 + 1, cellRectY1 + cellHeight, cellRectX2 - 1, cellRectY2 + cellHeight-2, false);
				draw_set_alpha(1);
				draw_set_color(global.colorThemeText);
				draw_text(cellRectX1 + textBuffer, mean(cellRectY1 + cellHeight, cellRectY2 + cellHeight), currentStrDesc);
				cellPlusY += (2 * cellHeight);
			}
			else {
			cellPlusY += cellHeight;
			}
		}
	}
	
	cellPlusY += 16;
	draw_set_font(fnt_mainBold);
	titleTextX = helpWindowX1 + textBuffer;
	titleTextY = helpWindowY1 + (textBuffer * 2) + functionHelp_plusY + cellPlusY;
	titleTextStr = "Navigator Functions";
	draw_set_color(global.colorThemeText);
	draw_text(titleTextX, titleTextY, titleTextStr);
	var gridCollapseButtonX = titleTextX + string_width(titleTextStr) + (textBuffer * 2);
	var gridCollapseButtonY = titleTextY;
	if (functionHelp_navCollapsed) {
		draw_sprite_ext(spr_ascend, 0, gridCollapseButtonX, gridCollapseButtonY, 1, 1, 270, c_white, 1);
	}
	else {
		draw_sprite_ext(spr_ascend, 0, gridCollapseButtonX, gridCollapseButtonY, 1, 1, 180, c_white, 1);
	}
	
	if (point_distance(mouse_x, mouse_y, gridCollapseButtonX, gridCollapseButtonY) < 10) {
		draw_set_color(global.colorThemeText);
		draw_set_alpha(1);
		draw_circle(gridCollapseButtonX, gridCollapseButtonY, 10, true);
		if (mouse_check_button_pressed(mb_left)) {
			functionHelp_navCollapsed = !functionHelp_navCollapsed;
		}
	}
	
	cellPlusY += 16;
	
	if (!functionHelp_navCollapsed) {
		for (var i = 0; i < ds_grid_height(functionHelp_helpGridNav); i++) {
			var cellRectX1 = helpWindowX1 + textBuffer;
			var cellRectY1 = helpWindowY1 + (textBuffer * 2) + functionHelp_plusY + cellPlusY;
			var cellRectX2 = helpWindowX2 - textBuffer;
			var cellRectY2 = cellRectY1 + cellHeight;
		
			if (i mod 2) {
				draw_set_color(global.colorThemeBG);
			}
			else {
				draw_set_alpha(0.4);
				draw_set_color(global.colorThemeSelected1);
			}
			draw_rectangle(cellRectX1, cellRectY1, cellRectX2, cellRectY2, false);
			draw_set_alpha(1);
			draw_set_color(global.colorThemeText);
			draw_set_font(fnt_chainContents);
			draw_set_halign(fa_left);
			draw_set_valign(fa_middle);
			var currentStrKey = ds_grid_get(functionHelp_helpGridNav, functionHelp_helpGrid_colKey, i);
			var currentStrFunc = ds_grid_get(functionHelp_helpGridNav, functionHelp_helpGrid_colFunc, i);
			var currentStrDesc = ds_grid_get(functionHelp_helpGridNav, functionHelp_helpGrid_colDesc, i);
			draw_text(cellRectX1 + textBuffer, mean(cellRectY1, cellRectY2), currentStrKey);
			draw_text(mean(cellRectX1, cellRectX2) + textBuffer, mean(cellRectY1, cellRectY2), currentStrFunc);
			if(point_in_rectangle(mouse_x, mouse_y, cellRectX1, cellRectY1, cellRectX2, cellRectY2)) {
				draw_rectangle(cellRectX1, cellRectY1, cellRectX2, cellRectY2 + cellHeight - 1, true);
				if (i mod 2) {
					draw_set_color(global.colorThemeBG);
				}
				else {
					draw_set_alpha(0.4);
					draw_set_color(global.colorThemeSelected1);
				}
				draw_rectangle(cellRectX1 + 1, cellRectY1 + cellHeight, cellRectX2 - 1, cellRectY2 + cellHeight-2, false);
				draw_set_alpha(1);
				draw_set_color(global.colorThemeText);
				draw_text(cellRectX1 + textBuffer, mean(cellRectY1 + cellHeight, cellRectY2 + cellHeight), currentStrDesc);
				cellPlusY += (2 * cellHeight);
			}
			else {
			cellPlusY += cellHeight;
			}
		}
	}*/

}