function scr_importDebugGridDraw() {
	
	if (live_call()) return live_result;
	
	var grid = obj_importMappingTagInfo.gridViewing;

	var camWidth = camera_get_view_width(camera_get_active());
	var camHeight = camera_get_view_height(camera_get_active());

	var colAmount = ds_grid_width(grid);

	scr_windowCameraAdjust();


	// window
	var tagInfoWindowRectX1 = 40;
	var tagInfoWindowRectY1 = (camHeight / 2) - 100;
	var tagInfoWindowRectX2 = (camWidth) - 50;
	var tagInfoWindowRectY2 = camHeight - 150;

	windowWidth = max(tagInfoWindowRectX2 - tagInfoWindowRectX1, 48);
	windowHeight = max(tagInfoWindowRectY2 - tagInfoWindowRectY1, 48);
	clipWidth = windowWidth;
	clipHeight = windowHeight;

	var rowHeight = string_height("A") * 1.3;
	var colWidth = windowWidth / colAmount;
	
	windowX = x;
	windowY = y;
	clipX = x;
	clipY = y;

	if (!surface_exists(clipSurface)) {
	    clipSurface = surface_create(clipWidth, clipHeight);
	}

	scr_windowCameraAdjust();

	surface_set_target(clipSurface);
	draw_clear_alpha(c_black, 0);




	x = tagInfoWindowRectX1;
	y = tagInfoWindowRectY1;


	if ((!point_in_rectangle(mouse_x, mouse_y, tagInfoWindowRectX1, tagInfoWindowRectY1, tagInfoWindowRectX2 - global.scrollBarWidth, tagInfoWindowRectY2) && !instance_exists(obj_dropDown))
	|| scrollBarHolding) {
		obj_importMapping.mouseoverRow = -1;
	}


	var timesHit = 0;
	var buttonRectSize = rowHeight - 10;



	// Draw Tag Info window contents
	draw_set_font(global.fontMain);
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);

	for (var i = 0; i < colAmount; i++) {
		var prevColX = tagInfoWindowRectX1 + ((windowWidth / (colAmount)) * 2);
		var colX = tagInfoWindowRectX1 + ((windowWidth / (colAmount)) * i);
		var nextColX = tagInfoWindowRectX1 + ((windowWidth / (colAmount)) * 3);
		var plusY = tagInfoWindowRectY1 + rowHeight;
	
	
		var realNextColX = tagInfoWindowRectX1 + ((windowWidth / (colAmount)) * (i + 1));
		draw_set_color(global.colorThemeBG);
		draw_rectangle(colX - clipX, tagInfoWindowRectY1 - clipY, realNextColX - clipX, tagInfoWindowRectY2 - clipY, false);
	
	
		var gridHeight = ds_grid_height(grid);
	
		for (var j = 0; j < gridHeight; j++) {
		
			draw_set_halign(fa_left);
		
			var cellRectX1 = colX;
			var cellRectY1 = plusY + scrollPlusY;
			var cellRectX2 = cellRectX1 + (windowWidth / colAmount);
			var cellRectY2 = cellRectY1 + rowHeight;

		
			if (point_in_rectangle(mouse_x, mouse_y, cellRectX1, cellRectY1, cellRectX2, cellRectY2) and point_in_rectangle(mouse_x, mouse_y, x, y, x + windowWidth - global.scrollBarWidth, y + windowHeight)
			&& !instance_exists(obj_dropDown)) {
				if (!scrollBarHolding) {
					obj_importMapping.mouseoverRow = j;
					timesHit++;
				}
			}
			if (obj_importMapping.mouseoverRow == j) {
				draw_set_color(global.colorThemeSelected1);
				draw_rectangle(cellRectX1 - clipX, cellRectY1 - clipY, cellRectX2 - clipX, cellRectY2 - clipY, false);
			}
		
		
			var currentCell = ds_grid_get(grid, i, j);
			
			var currentCellStr = string(currentCell);
			if (grid == global.blockTypeGrid && i == global.blockTypeGrid_colFieldList) {
				currentCellStr = scr_getStringOfList(currentCell);
			}
			else if (grid == global.blockGrid && i == global.blockGrid_colLineList) {
				currentCellStr = scr_getStringOfList(currentCell);
			}
			else if (grid == global.blockGrid && i == global.blockGrid_colTokenCountList) {
				currentCellStr = scr_getStringOfList(currentCell);
			}
			else if (grid == global.fieldRelationGrid && i == global.fieldRelationGrid_colEncounteredFields) {
				currentCellStr = scr_getStringOfList(currentCell);
			}
			else if (grid == global.fieldRelationGrid && i == global.fieldRelationGrid_colOneToOneFieldList) {
				currentCellStr = scr_getStringOfList(currentCell);
			}
		
		
			draw_set_color(global.colorThemeText);
			draw_set_font(global.fontMain);
			draw_text(floor(colX + 5 - clipX), floor(plusY + (rowHeight / 2) + scrollPlusY - clipY), currentCellStr);

			plusY += rowHeight;
		}
	}

	draw_set_halign(fa_left);



	// draw header for column
	draw_set_color(global.colorThemeBG);
	draw_rectangle(tagInfoWindowRectX1 - clipX, tagInfoWindowRectY1 - clipY, tagInfoWindowRectX2 - clipX, tagInfoWindowRectY1 + rowHeight - clipY, false);
	for (var i = 0; i < colAmount; i++) {
		var colX = tagInfoWindowRectX1 + ((windowWidth / (colAmount)) * i);
		var headerStr = "";
		if (grid == global.importTXTLineGrid) {
			if (i == global.importTXTLineGrid_colLine) {
				headerStr = "line";
			}
			else if (i == global.importTXTLineGrid_colException) {
				headerStr = "exception";
			}
		}
		else if (grid == global.blockTypeGrid) {
			if (i == global.blockTypeGrid_colDefault) {
				headerStr ="default";
			}
			else if (i == global.blockTypeGrid_colBlockCategory) {
				headerStr ="block category";
			}
			else if (i == global.blockTypeGrid_colBlockType) {
				headerStr ="block type";
			}
			else if (i == global.blockTypeGrid_colBlockCount) {
				headerStr ="block count";
			}
			else if (i == global.blockTypeGrid_colLinesPerBlock) {
				headerStr ="lines per block";
			}
			else if (i == global.blockTypeGrid_colFieldList) {
				headerStr ="field list";
			}
		}
		else if (grid == global.blockGrid) {
			if (i == global.blockGrid_colBlockID) {
				headerStr ="blockID";
			}
			else if (i == global.blockGrid_colBlockType) {
				headerStr ="block type";
			}
			else if (i == global.blockGrid_colLineList) {
				headerStr ="line list";
			}
			else if (i == global.blockGrid_colTokenCountList) {
				headerStr ="token count list";
			}
		}
		else if (grid == global.fieldRelationGrid) {
			if (i == global.fieldRelationGrid_colField) {
				headerStr ="field";
			}
			else if (i == global.fieldRelationGrid_colEncounteredFields) {
				headerStr ="encountered fields";
			}
			else if (i == global.fieldRelationGrid_colOneToOneFieldList) {
				headerStr ="1-to-1 field list";
			}
		}

		draw_set_font(global.fontMainBold);
		draw_set_color(global.colorThemeText);
		draw_text(floor(colX + 5 - clipX), floor(tagInfoWindowRectY1 + (rowHeight / 2) - clipY), headerStr);
	
		// draw column lines
		draw_set_color(global.colorThemeBorders);
		draw_line(colX - clipX, tagInfoWindowRectY1 - clipY, colX - clipX, tagInfoWindowRectY2 - clipY);
	}
	draw_set_color(global.colorThemeBorders);
	draw_rectangle(tagInfoWindowRectX1 - clipX, tagInfoWindowRectY1 - clipY, tagInfoWindowRectX2 - clipX, tagInfoWindowRectY1 + rowHeight - clipY, true);








	// mousewheel input
	if (point_in_rectangle(mouse_x, mouse_y, x, y, x + windowWidth, y + windowHeight)) {
		if (mouse_wheel_up()) {
			scrollPlusYDest += 8;
		}
		if (mouse_wheel_down()) {
			scrollPlusYDest -= 8;
		}
	}

	scr_scrollBar(ds_grid_height(grid), -1, rowHeight, rowHeight,
	global.colorThemeSelected1, global.colorThemeSelected2,
	global.colorThemeSelected1, global.colorThemeSelected2, spr_ascend, (tagInfoWindowRectX2 - tagInfoWindowRectX1), (tagInfoWindowRectY2 - tagInfoWindowRectY1));
	scrollPlusY = min(scrollPlusY, 0);



	scr_surfaceEnd();





	// draw Tag Info window border
	draw_set_color(global.colorThemeBorders);
	draw_set_alpha(1);
	draw_rectangle(tagInfoWindowRectX1, tagInfoWindowRectY1, tagInfoWindowRectX2, tagInfoWindowRectY2, true);


}
