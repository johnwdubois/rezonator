function scr_drawGridViewerClipped() {
	/*
		Purpose: display Rezonator's backend grids for debugging and research purposes
	*/
	
	var camWidth = camera_get_view_width(view_get_camera(0));
	var camHeight = camera_get_view_height(view_get_camera(0));

	windowX = x;
	windowY = y;


	// press TAB or ALT+TAB to switch grids
	if (keyboard_check_pressed(vk_tab)) {
		var gridIndex = ds_list_find_index(gridList, grid);
	
		if (gridIndex > -1) {
			gridIndex += (global.ctrlHold) ? -1 : 1;
			if (gridIndex < 0) {
				gridIndex = ds_list_size(gridList) - 1;
			}
			else if (gridIndex >= ds_list_size(gridList)) {
				gridIndex = 0;
			}
			grid = ds_list_find_value(gridList, gridIndex);
			obj_gridListWindow.currentGrid = grid;
		}
	}


	windowWidth = (camWidth - windowX - 40);		
	windowHeight = (camHeight - (windowY*1.5));
	
	

	
	


	scr_surfaceStart();
	


	clipWidth = windowWidth;
	clipHeight = windowHeight;

	// I suppose this is the variable to make dynamic
	//var gridColWidthDefault = windowWidth / ds_grid_width(grid);
	var textY = 0;
	var textPlusY = 0;
	var strHeight = string_height("0");
	var colNameHeight = strHeight;


	windowX1 = windowX;
	windowY1 = windowY;
	windowX2 = windowX1 + windowWidth;
	windowY2 = windowY1 + windowHeight;
	var gridWidth = ds_grid_width(grid);
	var gridHeight = ds_grid_height(grid);

	draw_set_color(global.colorThemeBG);
	draw_rectangle(windowX1 - clipX, windowY1 - clipY, windowX1 - clipX, windowY2 - clipY, false);
	


	var currentItemString = " ";
	var mouseoverItemString = " ";
	var mouseoverCol = -1;


	var gridColXList = ds_map_find_value(gridViewColXListMap, scr_getGridNameString(grid));
	if (!scr_isNumericAndExists(gridColXList, ds_type_list)) {
		exit;
	}
	var gridColXListSize = ds_list_size(gridColXList);
	


	
	
	
	
	
	
	
	if (gridColXListSize < gridWidth) {
		scr_gridViewerDynamicWidth(grid);
	}
	

	for (var gridLoopCol = 0; gridLoopCol < gridWidth; gridLoopCol++) {
	
		var colRectX1 = x;
		if (gridLoopCol < ds_list_size(gridColXList)) {
			colRectX1 = ds_list_find_value(gridColXList, gridLoopCol);
		}
		var colRectY1 = windowY1;
		var colRectX2 = windowX2;
		if (gridLoopCol + 1 < ds_list_size(gridColXList)) {
			colRectX2 = ds_list_find_value(gridColXList, gridLoopCol + 1);
			if (gridLoopCol == gridWidth - 1) {
				colRectX2 = windowX2;
			}
		}
		var colRectY2 = colRectY1 + windowHeight;
	
	

	
	
		
		draw_set_color(global.colorThemeBG);
		draw_rectangle(colRectX1 - clipX, colRectY1 - clipY, windowX2 - clipX, colRectY2 - clipY, false);
	
		draw_set_halign(fa_left);
		draw_set_valign(fa_middle);
	

		textPlusY = 0;
	
		for (var gridLoopRow = 0; gridLoopRow < gridHeight; gridLoopRow++) {
		
		
			if (windowY1 + colNameHeight + scrollPlusY + textPlusY < windowY1 - strHeight) {
				textPlusY += strHeight;
				continue;
			}
			if (windowY1 + colNameHeight + scrollPlusY + textPlusY > windowY1 + windowHeight  - global.scrollBarWidth + strHeight) {
				textPlusY += strHeight;
				break;
			}
		
		
		
			currentItemString = scr_drawGridViewerGetItemString(grid, gridLoopCol, gridLoopRow);

			if (currentItemString == "undefined") {
				//continue;
			}
		
		
			var textX = colRectX1;
			textY = windowY1 + colNameHeight + scrollPlusY + textPlusY;
		
			var currentCellRectX1 = colRectX1;
			var currentCellRectY1 = textY - (strHeight / 2);
			var currentCellRectX2 = colRectX2;
			var currentCellRectY2 = currentCellRectY1 + strHeight;
		
			if (gridLoopRow == mouseoverRow and gridViewColXHolding == -1 and not windowResizeXHolding
			and point_in_rectangle(mouse_x, mouse_y, windowX1, windowY1, windowX2, windowY2)) {
				draw_set_color(global.colorThemeSelected1);
				draw_rectangle(currentCellRectX1 - clipX, currentCellRectY1 - clipY, currentCellRectX2 - clipX, currentCellRectY2 - clipY, false);
			}
		
			if (point_in_rectangle(mouse_x, mouse_y, currentCellRectX1, currentCellRectY1, currentCellRectX2, currentCellRectY2) and gridViewColXHolding == -1) {
				mouseoverRow = gridLoopRow;
				mouseoverCol = gridLoopCol;
				mouseoverItemString = currentItemString;
				draw_set_color(global.colorThemeSelected2);
				draw_rectangle(currentCellRectX1 - clipX, currentCellRectY1 - clipY, currentCellRectX2 - clipX, currentCellRectY2 - clipY, true);
				// Here is where we can focus a specific column.
				if (device_mouse_check_button_released(0, mb_left) and window_get_cursor() != cr_size_we and not obj_panelPane.scrollBarClickLock) {
					focusedRow = gridLoopRow;
					focusedCol = gridLoopCol;	
					focusedItemString = currentItemString;
				}
			}
		
		
		
			draw_set_color(global.colorThemeText);
			currentItemString = scr_adaptFont(currentItemString, "S");
			draw_text(textX - clipX, textY - clipY, currentItemString);
		
			if (gridLoopCol == ds_grid_width(grid) - 1) {
				draw_set_color(global.colorThemeSelected1);
				draw_line(windowX1 - clipX, currentCellRectY2 - clipY, windowX2 - clipX, currentCellRectY2 - clipY);
			}
		
			if(focusedRow == gridLoopRow && focusedCol == gridLoopCol) {
				draw_set_color(c_yellow);
				draw_set_alpha(0.3);
				draw_rectangle(currentCellRectX1 - clipX, currentCellRectY1 - clipY, colRectX2, currentCellRectY2 - clipY, false);
				draw_set_alpha(1);
			}
		
			textPlusY += strHeight;
		

		}
	


	}

	draw_set_color(global.colorThemeBG);
	draw_rectangle(windowX1 - clipX, windowY1 - clipY, windowX2 - clipX, windowY1 + colNameHeight - clipY, false);
	draw_set_color(global.colorThemeBorders);
	draw_rectangle(windowX1 - clipX, windowY1 - clipY, windowX2 - clipX, windowY1 + colNameHeight - clipY, true);


	// draw column names
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	draw_set_color(global.colorThemeText);
	for (var i = 0; i < gridWidth; i++) {
		var colName = scr_getColNameString(grid, i);
		var colNameX = ds_list_find_value(gridColXList, i);
	
		if (!is_undefined(colNameX)) {
			draw_set_color(global.colorThemeBG);
			draw_rectangle(colNameX - clipX, windowY1 - clipY, windowX2 - clipX, windowY1 + colNameHeight - clipY, false);
	
			draw_set_color(global.colorThemeText);
			scr_adaptFont(colName, "S");
			draw_text(colNameX - clipX, windowY1 + (colNameHeight / 2) - clipY, colName);
		}
	}









	// Draw the scroll bar for the GridView

	scr_scrollBar(ds_grid_height(grid), -1, strHeight, colNameHeight,
		global.colorThemeSelected1, global.colorThemeSelected2,
		global.colorThemeSelected1, global.colorThemeSelected2, spr_ascend, windowWidth, windowHeight);



	scr_scrollBarGridViewer(global.colorThemeSelected1, global.colorThemeSelected2, global.colorThemeSelected1, global.colorThemeSelected2, spr_ascend, windowWidth, windowHeight);
	
		


	scr_surfaceEnd();

	for (var j = 0; j < 1; j++) {
		draw_set_color(global.colorThemeBorders);
		draw_rectangle(windowX1 - j, windowY1 - j, windowX2 + j, windowY2 + j, true);
	}
	draw_set_color(global.colorThemeBorders);
	draw_line(windowX1, windowY1 + colNameHeight, windowX2, windowY1 + colNameHeight);


	// spread button
	var spreadX2 = camWidth - 20;
	var spreadX1 = spreadX2 - string_width(" Spread ");
	var spreadY1 = obj_menuBar.menuHeight + 20;
	var spreadY2 = spreadY1 + string_height("0");
	var mouseoverSpread = point_in_rectangle(mouse_x, mouse_y, spreadX1, spreadY1, spreadX2, spreadY2);
	draw_set_color(mouseoverSpread ? global.colorThemeSelected1 : global.colorThemeBG);
	draw_rectangle(spreadX1, spreadY1, spreadX2, spreadY2, false);
	draw_set_color(global.colorThemeBorders);
	draw_rectangle(spreadX1, spreadY1, spreadX2, spreadY2, true);
	draw_set_color(global.colorThemeText);
	draw_set_halign(fa_center);
	draw_text(mean(spreadX1, spreadX2), mean(spreadY1, spreadY2), "Spread");
	var spreadHotkey = keyboard_check(vk_alt) && keyboard_check(vk_shift) && keyboard_check_released(ord("Z"));
	
	// spread the columns to be evenly spaced across the window width
	if (spreadHotkey || (mouseoverSpread && mouse_check_button_released(mb_left))) {
		for (var i = 0; i < gridColXListSize; i++) {
			var currentColX = windowX1 + (((windowWidth / gridColXListSize) + 1) * i);
			ds_list_set(gridColXList, i, currentColX);
		}
	}

	// debug
	if (obj_control.showDevVars) {
		
		draw_set_halign(fa_left);
		draw_set_valign(fa_middle);
		draw_text(windowX1 + 100, windowY2 + 45, "gridViewColPrevList: " + scr_getStringOfList(gridViewColPrevList));
		draw_text(windowX1 + 100, windowY2 + 70, "gridColXList: " + scr_getStringOfList(gridColXList));
		
		draw_text(windowX1 + 350, windowY1 - 100, "scrollHorPlusX: " + string(scrollHorPlusX));
		draw_text(windowX1 + 350, windowY1 - 75, "scrollHorPlusXDest: " + string(scrollHorPlusXDest));
		draw_text(windowX1 + 350, windowY1 - 50, "scrollHorPlusXDiff: " + string(scrollHorPlusXDiff));
		draw_text(windowX1 + 350, windowY1 - 25, "scrollHorPlusXPrev: " + string(scrollHorPlusXPrev));
		
		draw_text(windowX1 + 750, windowY1 - 100, "XDest: " + string(XDest));
		
		draw_set_halign(fa_right);
		draw_text(windowX2, windowY2 + 30, "gridViewColXHolding: " + string(gridViewColXHolding));
		draw_text(windowX2, windowY2 + 55, "gridViewColXHoldingPrev: " + string(gridViewColXHoldingPrev));
		draw_text(windowX2, windowY2 + 80, "gridViewColXHoldingDiff: " + string(gridViewColXHoldingDiff));
	}
	//draw_text(500,100,"Grid Viewer windowY1: " + string(windowY1));


	// Draw vertical column lines and make columns draggable
	if ((not mouse_check_button(mb_left)) or gridViewColXHolding >= ds_grid_width(grid)) {
		gridViewColXHolding = -1;
		gridViewColXHoldingPrev = 0;
		gridViewColXHoldingDiff = 0;
		ds_list_clear(gridViewColPrevList);
	}

	//window_set_cursor(cr_default);

	for (var i = 1; i < gridWidth; i++) {
	
		draw_set_color(global.colorThemeBorders);
		draw_set_alpha(0.15);
		var colX = ds_list_find_value(gridColXList, i);
		if (is_undefined(colX)) {
			continue;
		}
	
	
		if (point_in_rectangle(mouse_x, mouse_y, colX - 3, windowY1 + colNameHeight, colX + 3, windowY2 - global.scrollBarWidth)) {
			window_set_cursor(cr_size_we);
			draw_set_alpha(0.8);
		
			if (mouse_check_button_pressed(mb_left) and gridViewColXHolding == -1) {
				gridViewColXHoldingPrev = colX;
				gridViewColXHolding = i;
				ds_list_clear(gridViewColPrevList);
				ds_list_copy(gridViewColPrevList, gridColXList);
			}
		}
		
		
		
		
		
		
		
		
		
		
		
		if (scrollBarHorHolding or scrollBarLeftButtonHeld or scrollBarRightButtonHeld) {
			var colXList = ds_map_find_value(gridViewColXListMap, scr_getGridNameString(grid));
			var firstColX = ds_list_find_value(colXList, 0);
			var lastColX = ds_list_find_value(colXList, ds_list_size(colXList) - 1);
			var colXDifference = lastColX - firstColX;
			var minScrollHorPlusX = windowWidth - (colXDifference + windowWidth);
			
			scrollHorPlusXDiff = (scrollHorPlusX - scrollHorPlusXPrev);
			
			XDest = -colXDifference*(scrollHorPlusXDiff/minScrollHorPlusX);
			
			
			for (var i = 0; i < gridColXListSize; i++) {
				var currentNewColX = ds_list_find_value(gridViewColPrevList, i) + XDest;
				ds_list_set(gridColXList, i, currentNewColX);
			}
		}
		else {
			scrollHorPlusXDiff = 0;
		}
		
		
		
		
		
		
		
		
		
		
		
		
	
		if (gridViewColXHolding == i) {
			window_set_cursor(cr_size_we);
		
			draw_set_alpha(0.8);
		
			var newColX = mouse_x;
		
			// put limit on how small a column can be
			if (gridViewColXHolding > 0) {
				var prevColX = ds_list_find_value(gridColXList, i - 1);
				newColX = max(newColX, prevColX + 20);
			}
		
			ds_list_set(gridColXList, i, newColX);
			gridViewColXHoldingDiff = newColX - gridViewColXHoldingPrev;
		
			// set X positions for all following columns
			
			for (var j = i + 1; j < gridColXListSize; j++) {

				var currentNewColX = ds_list_find_value(gridViewColPrevList, j) + gridViewColXHoldingDiff;
				ds_list_set(gridColXList, j, currentNewColX);
			}
		}
	
		if (colX < windowX2 - global.scrollBarWidth and colX > windowX1) {
			draw_line_width(colX, windowY1 + colNameHeight, colX, windowY2 - global.scrollBarWidth, 3);
		}
	}
	draw_set_alpha(1);


	// draw the current mouseover item
	var highlightText = "Highlighted Cell: (" + string(floor(focusedCol)) + ", " + string(floor(focusedRow)) + "): ";
	var mouseOverText = "MouseOver Cell: (" + string(floor(mouseoverCol)) + ", " + string(floor(mouseoverRow)) + "): ";	
	scr_adaptFont(highlightText, "M");
	
	draw_set_alpha(0.3);
	draw_set_color(c_yellow);
	draw_rectangle(windowX1 - 5, windowY1 - strHeight - 40 - (string_height("0") /2), windowX1 + string_width(highlightText), windowY1 - strHeight - 40 + (string_height("0") /2), false);
	draw_set_color(global.colorThemeSelected2);
	draw_rectangle(windowX1 - 5, windowY1 - strHeight - 40 - (string_height("0") /2) - string_height("0"), windowX1 + string_width(mouseOverText), windowY1 - strHeight - 40 + (string_height("0") /2) - string_height("0"), false);
	draw_set_alpha(1);
	draw_set_color(global.colorThemeText);


	draw_text(windowX1, windowY1 - strHeight - 40, highlightText);
	draw_text(windowX1, windowY1 - strHeight - 40 - string_height("0"), mouseOverText);
	var textBuffer1 = string_width(highlightText);
	var textBuffer2 = string_width(mouseOverText);
	scr_adaptFont(string(focusedItemString),"S");
	draw_text(windowX1 + textBuffer1 + 5, windowY1 - strHeight - 40, string(focusedItemString));
	scr_adaptFont(string(mouseoverItemString),"S");
	draw_text(windowX1 + textBuffer2 + 5, windowY1 - strHeight - 40- string_height("0"), string(mouseoverItemString));
	scr_adaptFont(string(fps), "M");
	draw_text(windowX1, windowY1 - strHeight - 40 - (string_height("0") * 2), "fps: " + string(fps));


	if(point_in_rectangle(mouse_x,mouse_y, windowX1, windowY1 ,windowX2, windowY2)){

		if (not obj_control.mouseoverHelpPane and !instance_exists(obj_dropDown)) {
			// mousewheel input
			if (mouse_wheel_up()) {
				scrollPlusYDest += 8;
			}
			if (mouse_wheel_down()) {
				scrollPlusYDest -= 8;
			}

			// keyboard input for UP and DOWN
			if (keyboard_check(vk_up)) {
				scrollPlusYDest += 4;
			}
			if (keyboard_check(vk_down)) {
				scrollPlusYDest -= 4;
			}

			// CTRL+UP and CTRL+DOWN
			if (global.ctrlHold && keyboard_check_pressed(vk_up)) {
				scrollPlusYDest = 100;
			}
			if (global.ctrlHold && keyboard_check_pressed(vk_down)) {
				scrollPlusYDest = -999999999999;
			}
	
			// PAGEUP and PAGEDOWN
			if (keyboard_check_pressed(vk_pageup)) {
				scrollPlusYDest += (windowHeight);
			}
			if (keyboard_check_pressed(vk_pagedown)) {
				scrollPlusYDest -= (windowHeight);
			}
		}
	}

}
