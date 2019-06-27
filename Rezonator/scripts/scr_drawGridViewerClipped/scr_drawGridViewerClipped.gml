/*
	scr_drawGridViewer(gridArrayIndex);
	
	Last Updated: 2019-02-05
	
	Called from: obj_gridViewer
	
	Purpose: display Rezonator's backend grids for debugging and research purposes
	
	Mechanism: loop through the selected grid and draw a string version of every cell value
	
	Author: Terry DuBois
*/

scr_drawGridViewerGridTabs();

scr_surfaceStart();

var scrollBarWidth = 20;
var gridColWidth = windowWidth / ds_grid_width(grid);
var textY = 0;
var textPlusY = 0;
var colNameHeight = 16;

var windowX1 = windowX;
var windowY1 = windowY;
var windowX2 = windowX1 + windowWidth;
var windowY2 = windowY1 + windowHeight;


draw_set_color(global.colorThemeBG);
draw_rectangle(windowX1 - scrollBarWidth - clipX, windowY1 - clipY, windowX1 - clipX, windowY2 - clipY, false);
draw_set_font(global.fontGridView);
var strHeight = string_height("0");

var currentItemString = " ";
var mouseoverItemString = " ";
var mouseoverCol = -1;

for (var gridLoopCol = 0; gridLoopCol < ds_grid_width(grid); gridLoopCol++) {
	var colRectX1 = windowX + (gridLoopCol * gridColWidth);
	var colRectY1 = windowY;
	var colRectX2 = colRectX1 + gridColWidth;//windowWidth;
	var colRectY2 = colRectY1 + windowHeight;
		
	draw_set_color(global.colorThemeBG);
	draw_rectangle(colRectX1 - clipX, colRectY1 - clipY, colRectX2 - clipX, colRectY2 - clipY, false);
	draw_set_color(global.colorThemeBorders);
	//draw_rectangle(colRectX1 - clipX, colRectY1 - clipY, colRectX2 - clipX, colRectY2 - clipY, true);
	
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	

	textPlusY = 0;
	
	for (var gridLoopRow = 0; gridLoopRow < ds_grid_height(grid); gridLoopRow++) {
		
		
		if (windowY1 + colNameHeight + scrollPlusY + textPlusY < windowY1 - strHeight) {
			textPlusY += strHeight;
			continue;
		}
		if (windowY1 + colNameHeight + scrollPlusY + textPlusY > windowY1 + windowHeight + strHeight) {
			textPlusY += strHeight;
			break;
		}
		
		
		
		currentItemString = scr_drawGridViewerGetItemString(grid, gridLoopCol, gridLoopRow);

		if (currentItemString == "undefined") {
			continue;
		}
		
		
		var textX = windowX + (gridLoopCol * gridColWidth);
		//textY += strHeight;
		
		textY = windowY1 + colNameHeight + scrollPlusY + textPlusY;
		
		var currentCellRectX1 = colRectX1;
		var currentCellRectY1 = textY - (strHeight / 2);
		var currentCellRectX2 = colRectX2;
		var currentCellRectY2 = currentCellRectY1 + strHeight;
		
		if (gridLoopRow == mouseoverRow) {
			draw_set_color(global.colorThemeSelected1);
			draw_rectangle(currentCellRectX1 - clipX, currentCellRectY1 - clipY, currentCellRectX2 - clipX, currentCellRectY2 - clipY, false);
		}
		
		if (point_in_rectangle(mouse_x, mouse_y, currentCellRectX1, currentCellRectY1, currentCellRectX2, currentCellRectY2)) {
			mouseoverRow = gridLoopRow;
			mouseoverCol = gridLoopCol;
			mouseoverItemString = currentItemString;
			draw_set_color(global.colorThemeSelected2);
			draw_rectangle(currentCellRectX1 - clipX, currentCellRectY1 - clipY, currentCellRectX2 - clipX, currentCellRectY2 - clipY, true);
		}
		
		
		
		draw_set_color(global.colorThemeText);
		draw_text(textX - clipX, textY - clipY, currentItemString);
		
		if (gridLoopCol == ds_grid_width(grid) - 1) {
			draw_set_color(global.colorThemeSelected1);
			draw_line(windowX1 - clipX, currentCellRectY2 - clipY, windowX2 - clipX, currentCellRectY2 - clipY);
		}
		
		
		textPlusY += strHeight;
		

	}
}

draw_set_color(global.colorThemeBG);
draw_rectangle(windowX1 - clipX, windowY1 - clipY, windowX2 - clipX, windowY1 + colNameHeight - clipY, false);
draw_set_color(global.colorThemeBorders);
draw_rectangle(windowX1 - clipX, windowY1 - clipY, windowX2 - clipX, windowY1 + colNameHeight - clipY, true);

scr_scrollBar(ds_grid_height(grid), -1, strHeight, colNameHeight,
	global.colorThemeSelected1, global.colorThemeSelected2,
	global.colorThemeSelected1, global.colorThemeBG, spr_ascend, windowWidth, windowHeight);

scr_surfaceEnd();

for (var gridLoopCol = 0; gridLoopCol < ds_grid_width(grid); gridLoopCol++) {
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	draw_set_color(global.colorThemeText);
	
	var colName = scr_getColNameString(grid, gridLoopCol);
	draw_text(windowX1 + (gridLoopCol * gridColWidth), windowY1 + (colNameHeight / 2), colName);
}

for (var j = 0; j < 5; j++) {
	draw_set_color(global.colorThemeBorders);
	draw_rectangle(windowX1 - scrollBarWidth - j, windowY1 - j, windowX2 + j, windowY2 + j, true);
}

// draw the current mouseover item
draw_set_font(global.fontMain);
draw_text(windowX1 + 10, windowY2 + strHeight + 20, "(" + string(floor(mouseoverCol)) + ", " + string(floor(mouseoverRow)) + "): " + mouseoverItemString);

draw_text(windowX1, windowY2 + strHeight + 20 + string_height("0"), "fps: " + string(fps));



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
if (keyboard_check(vk_control) && keyboard_check_pressed(vk_up)) {
	scrollPlusYDest = 100;
}
if (keyboard_check(vk_control) && keyboard_check_pressed(vk_down)) {
	scrollPlusYDest = -999999999999;
}
	
// PAGEUP and PAGEDOWN
if (keyboard_check_pressed(vk_pageup)) {
	scrollPlusYDest += (windowHeight);
}
if (keyboard_check_pressed(vk_pagedown)) {
	scrollPlusYDest -= (windowHeight);
}