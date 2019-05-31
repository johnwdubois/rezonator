var gridArrayIndex = argument0;

scr_drawGridViewerGridTabs(gridArrayIndex);

var scrollBarWidth = 20;
var gridColWidth = windowWidth[gridArrayIndex] / ds_grid_width(grid[gridArrayIndex]);
var textY = 0;
var colNameHeight = 16;

var windowX1 = windowX[gridArrayIndex];
var windowY1 = windowY[gridArrayIndex];
var windowX2 = windowX1 + windowWidth[gridArrayIndex];
var windowY2 = windowY1 + windowHeight[gridArrayIndex];


draw_set_color(global.colorThemeBG);
draw_rectangle(windowX1 - scrollBarWidth, windowY1, windowX1, windowY2, false);
draw_set_font(fnt_debug);

var currentItemString = " ";
var mouseoverItemString = " ";
var mouseoverRow = -1;
var mouseoverCol = -1;

for (var gridLoopCol = 0; gridLoopCol < ds_grid_width(grid[gridArrayIndex]); gridLoopCol++) {
	var colRectX1 = windowX[gridArrayIndex] + (gridLoopCol * gridColWidth);
	var colRectY1 = windowY[gridArrayIndex];
	var colRectX2 = colRectX1 + gridColWidth;//windowWidth[gridArrayIndex];
	var colRectY2 = colRectY1 + windowHeight[gridArrayIndex];
		
	draw_set_color(global.colorThemeBG);
	draw_rectangle(colRectX1, colRectY1, colRectX2, colRectY2, false);
	draw_set_color(global.colorThemeBorders);
	draw_rectangle(colRectX1, colRectY1, colRectX2, colRectY2, true);
	
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	
	var colName = scr_getColNameString(grid[gridArrayIndex], gridLoopCol);
	draw_text(colRectX1, colRectY1 + (colNameHeight / 2), colName);
	
	textY = colRectY1 + colNameHeight;
	
	for (var gridLoopRow = gridCurrentTopViewRow[gridArrayIndex]; gridLoopRow < (gridCurrentTopViewRow[gridArrayIndex] + scrollRange[gridArrayIndex]); gridLoopRow++) {
		if (gridLoopRow < 0 or gridLoopRow >= ds_grid_height(grid[gridArrayIndex])) {
			continue;
		}
		
		currentItemString = scr_drawGridViewerGetItemString(grid[gridArrayIndex], gridLoopCol, gridLoopRow);

		if (currentItemString == "undefined") {
			continue;
		}
		
		
		var textX = windowX[gridArrayIndex] + (gridLoopCol * gridColWidth);
		textY += string_height(currentItemString);
		
		var currentCellRectX1 = colRectX1;
		var currentCellRectY1 = textY - (string_height(currentItemString) / 2);
		var currentCellRectX2 = colRectX2;
		var currentCellRectY2 = currentCellRectY1 + string_height(currentItemString);
		
		if (gridLoopRow == mouseoverRelativeRow[gridArrayIndex]) {
			draw_set_color(global.colorThemeSelected1);
			draw_rectangle(currentCellRectX1, currentCellRectY1, currentCellRectX2, currentCellRectY2, false);
		}
		
		if (point_in_rectangle(mouse_x, mouse_y, currentCellRectX1, currentCellRectY1, currentCellRectX2, currentCellRectY2)) {
			mouseoverRow = gridLoopRow;
			mouseoverCol = gridLoopCol;
			mouseoverItemString = currentItemString;
			mouseoverRelativeRow[gridArrayIndex] = gridLoopRow;
			draw_set_color(global.colorThemeSelected2);
			draw_rectangle(currentCellRectX1, currentCellRectY1, currentCellRectX2, currentCellRectY2, true);
		}

		
		draw_set_color(global.colorThemeText);
		draw_text(textX, textY, currentItemString);
	}
}