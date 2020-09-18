function scr_drawExportGridViewer(argument0) {
	var grid = argument0;
	var gridWidth = ds_grid_width(grid);
	var gridHeight = ds_grid_height(grid);

	scr_surfaceStart();

	var textY = 0;
	var textPlusY = 0;
	draw_set_font(global.fontGridView);
	var strWidth = string_width("A");
	var strHeight = string_height("0");

	var windowX1 = windowX + (strWidth * 2);
	var windowY1 = windowY + (strHeight * 2);
	var windowX2 = windowX + windowWidth - (strWidth * 2);
	var windowY2 = windowY + windowHeight - (strHeight * 2);

	var colWidth = (windowWidth) / gridWidth;
	var colHeaderHeight = strHeight;

	draw_set_color(global.colorThemeBG);
	draw_rectangle(windowX1 - clipX, windowY1 - clipY, windowX2 - clipX, windowY2 - clipY, false);

	var currentItemString = " ";

	// main draw loop for mini grid view
	for (var i = 0; i < gridWidth; i++) {
	
		var colRectX1 = windowX1 + (i * colWidth);
		var colRectY1 = windowY1;
		var colRectX2 = colRectX1 + colWidth;
		var colRectY2 = windowY2;
	
		draw_set_color(global.colorThemeBG);
		draw_rectangle(colRectX1 - clipX, colRectY1 - clipY, colRectX2 - clipX, colRectY2 - clipY, false);
	
		draw_set_halign(fa_left);
		draw_set_valign(fa_middle);
	
		textPlusY = 0;
	
		for (var j = 0; j < gridHeight; j++) {
		
			if (windowY1 + colHeaderHeight + scrollPlusY + textPlusY < windowY1 - strHeight) {
				textPlusY += strHeight;
				continue;
			}
			if (windowY1 + colHeaderHeight + scrollPlusY + textPlusY > windowY1 + windowHeight + strHeight) {
				textPlusY += strHeight;
				break;
			}
		
			currentItemString = scr_drawGridViewerGetItemString(grid, i, j);
			if (currentItemString == "undefined") {
				continue;
			}
		
			var textX = colRectX1;
			textY = windowY1 + colHeaderHeight + scrollPlusY + textPlusY;
			var currentCellRectX1 = colRectX1;
			var currentCellRectY1 = textY - (strHeight / 2);
			var currentCellRectX2 = colRectX2;
			var currentCellRectY2 = currentCellRectY1 + strHeight;
		
			draw_set_color(global.colorThemeText);
			draw_text(textX - clipX, textY - clipY, currentItemString);
		
			textPlusY += strHeight;
		}
	}


	// column headers
	for (var i = 0; i < gridWidth; i++) {
	
		var colHeaderX = windowX1 + (i * colWidth);
		var colHeaderY = windowY1 + (strHeight / 2);
	
		draw_set_color(global.colorThemeBG);
		draw_rectangle(colHeaderX - clipX, windowY1 - clipY, colHeaderX + colWidth - clipX, windowY1 + colHeaderHeight - clipY, false);
	
		draw_set_color(global.colorThemeSelected1);
		draw_line(colHeaderX - clipX, windowY1 - clipY, colHeaderX - clipX, windowY2 - clipY);
	
		draw_set_halign(fa_left);
		draw_set_valign(fa_middle);
		draw_set_color(global.colorThemeText);
		draw_text(colHeaderX - clipX, colHeaderY - clipY, scr_getColNameString(grid, i));
	}
	draw_set_color(global.colorThemeGrid_colBorders);
	draw_line(windowX1 - clipX, windowY1 + colHeaderHeight - clipY, windowX2 - clipX, windowY1 + colHeaderHeight - clipY);

	draw_set_color(global.colorThemeBorders);
	draw_rectangle(windowX1 - clipX, windowY1 - clipY, windowX2 - clipX, windowY2 - clipY, true);

	scr_surfaceEnd();


}
