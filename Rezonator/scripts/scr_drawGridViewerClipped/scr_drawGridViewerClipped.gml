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
// I suppose this is the variable to make dynamic
//var gridColWidthDefault = windowWidth / ds_grid_width(grid);
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

var gridColXList = ds_map_find_value(gridViewColXListMap, grid);
if (gridColXList == -1 or is_undefined(gridColXList)) {
	exit;
}

for (var gridLoopCol = 0; gridLoopCol < ds_grid_width(grid); gridLoopCol++) {
	
	var colRectX1 = scrollBarWidth;
	if (gridLoopCol < ds_list_size(gridColXList)) {
		colRectX1 = ds_list_find_value(gridColXList, gridLoopCol);
	}
	var colRectY1 = windowY1;
	var colRectX2 = windowX2;
	if (gridLoopCol + 1 < ds_list_size(gridColXList)) {
		colRectX2 = ds_list_find_value(gridColXList, gridLoopCol + 1);
	}
	var colRectY2 = colRectY1 + windowHeight;
	
	

	
	
		
	draw_set_color(global.colorThemeBG);
	draw_rectangle(colRectX1 - clipX, colRectY1 - clipY, windowX2 - clipX, colRectY2 - clipY, false);
	
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
		
		
		var textX = colRectX1;
		textY = windowY1 + colNameHeight + scrollPlusY + textPlusY;
		
		var currentCellRectX1 = colRectX1;
		var currentCellRectY1 = textY - (strHeight / 2);
		var currentCellRectX2 = colRectX2;
		var currentCellRectY2 = currentCellRectY1 + strHeight;
		
		if (gridLoopRow == mouseoverRow and gridViewColXHolding == -1 and not windowResizeXHolding) {
			draw_set_color(global.colorThemeSelected1);
			draw_rectangle(currentCellRectX1 - clipX, currentCellRectY1 - clipY, currentCellRectX2 - clipX, currentCellRectY2 - clipY, false);
		}
		
		if (point_in_rectangle(mouse_x, mouse_y, currentCellRectX1, currentCellRectY1, currentCellRectX2, currentCellRectY2) and gridViewColXHolding == -1) {
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


// draw column names
draw_set_halign(fa_left);
draw_set_valign(fa_middle);
draw_set_color(global.colorThemeText);
for (var i = 0; i < ds_grid_width(grid); i++) {
	var colName = scr_getColNameString(grid, i);
	var colNameX = ds_list_find_value(gridColXList, i);
	
	draw_set_color(global.colorThemeBG);
	draw_rectangle(colNameX - clipX, windowY1 - clipY, windowX2 - clipX, windowY1 + colNameHeight - clipY, false);
	
	draw_set_color(global.colorThemeText);
	draw_text(colNameX - clipX, windowY1 + (colNameHeight / 2) - clipY, colName);
}









// Draw the scroll bar for the GridView
scr_scrollBar(ds_grid_height(grid), -1, strHeight, colNameHeight,
	global.colorThemeSelected1, global.colorThemeSelected2,
	global.colorThemeSelected1, global.colorThemeBG, spr_ascend, windowWidth, windowHeight);

scr_surfaceEnd();

for (var j = 0; j < 5; j++) {
	draw_set_color(global.colorThemeBorders);
	draw_rectangle(windowX1 - scrollBarWidth - j, windowY1 - j, windowX2 + j, windowY2 + j, true);
}



// Draw vertical column lines and make columns draggable
if ((not mouse_check_button(mb_left)) or gridViewColXHolding >= ds_grid_width(grid)) {
	gridViewColXHolding = -1;
	gridViewColXHoldingPrev = 0;
	gridViewColXHoldingDiff = 0;
	ds_list_clear(gridViewColPrevList);
}

window_set_cursor(cr_default);
for (var i = 1; i < ds_grid_width(grid); i++) {
	
	draw_set_color(global.colorThemeBorders);
	draw_set_alpha(0.15);
	var colX = ds_list_find_value(gridColXList, i);
	
	
	if (point_in_rectangle(mouse_x, mouse_y, colX - 3, windowY1 + colNameHeight, colX + 3, windowY2)) {
		draw_set_alpha(0.8);
		window_set_cursor(cr_size_we);
		
		if (mouse_check_button_pressed(mb_left) and gridViewColXHolding == -1) {
			gridViewColXHoldingPrev = colX;
			gridViewColXHolding = i;
			ds_list_clear(gridViewColPrevList);
			ds_list_copy(gridViewColPrevList, gridColXList);
		}
	}
	
	if (gridViewColXHolding == i) {
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
		for (var j = i + 1; j < ds_list_size(gridColXList); j++) {

			var currentNewColX = ds_list_find_value(gridViewColPrevList, j) + gridViewColXHoldingDiff;
			ds_list_set(gridColXList, j, currentNewColX);
		}
	}
	
	if (colX < windowX2 - scrollBarWidth) {
		draw_line_width(colX, windowY1 + colNameHeight, colX, windowY2, 3);
	}
}
draw_set_alpha(1);



// draw the current mouseover item
draw_set_font(global.fontMain);
draw_text(windowX1 + 10, windowY2 + strHeight + 20, "(" + string(floor(mouseoverCol)) + ", " + string(floor(mouseoverRow)) + "): " + mouseoverItemString);

draw_text(windowX1, windowY2 + strHeight + 20 + string_height("0"), "fps: " + string(fps));


//draw_text(windowX1, windowY2 + strHeight + 60 + string_height("0"), "gridViewColXHolding: " + string(gridViewColXHolding));
//draw_text(windowX1, windowY2 + strHeight + 80 + string_height("0"), "gridViewColPrevList: " + scr_getStringOfList(gridViewColPrevList));
//draw_text(windowX1, windowY2 + strHeight + 100 + string_height("0"), "gridViewColXHoldingDiff: " + string(gridViewColXHoldingDiff));






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