/*
	scr_panelPane_drawchainContentsLoop();
	
	Last Updated: 2018-07-12
	
	Called from: obj_panelPane
	
	Purpose: whatever chain is focused on in the chainList panelPane, draw information on the individual contents of that chain
	
	Mechanism: loop through the IDList of the focused chain and gather information from corresponding grids
	
	Author: Terry DuBois
*/

var camWidth = camera_get_view_width(view_camera[0]);
x = camWidth - windowWidth;
y = obj_toolPane.y + obj_toolPane.windowHeight;

var mouseover = false;
if (point_in_rectangle(mouse_x, mouse_y, x, y, x + windowWidth, y + windowHeight)) {
	mouseover = true;
}

if (mouseover and mouse_check_button_pressed(mb_left)) {
	functionHelp_collapsed = !functionHelp_collapsed;
}

draw_set_alpha(1);
draw_set_font(fnt_mainBold);
draw_set_color(c_black);
draw_set_halign(fa_left);
draw_set_valign(fa_middle);

if (functionHelp_collapsed) {
	draw_set_color(c_black);
	draw_text(x + 10, y + (windowHeight / 2), "Help");
	
	if (functionHelp_plusX <= camWidth) {
		functionHelp_plusX += abs(functionHelp_plusX - camWidth) / 4 ;
	}

}
else {
	draw_set_color(c_black);
	draw_rectangle(x, y, x + windowWidth, y + windowHeight, false);
	draw_set_color(c_white);
	draw_text(x + 10, y + (windowHeight / 2), "Help");

	if (functionHelp_plusX <= camWidth - functionHelp_windowWidth) {
		functionHelp_plusX += abs(functionHelp_plusX - (camWidth - functionHelp_windowWidth)) / 4;
	}
	if (functionHelp_plusX >= camWidth - functionHelp_windowWidth) {
		functionHelp_plusX -= abs(functionHelp_plusX - (camWidth - functionHelp_windowWidth)) / 4;
	}
}

if !(abs(functionHelp_plusX - camWidth) < 0.1) {
	draw_set_color(c_white);
	var helpWindowX1 = functionHelp_plusX;
	var helpWindowY1 = obj_toolPane.y + obj_toolPane.windowHeight + windowHeight;
	var helpWindowX2 = helpWindowX1 + functionHelp_windowWidth;
	var helpWindowY2 = camera_get_view_height(view_camera[0]);
	draw_rectangle(helpWindowX1, helpWindowY1, helpWindowX2, helpWindowY2, false);
	draw_set_color(c_black);
	draw_rectangle(helpWindowX1, helpWindowY1, helpWindowX2, helpWindowY2, true);
	
	var textBuffer = 10;
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle)
	draw_set_font(fnt_mainBold);
	draw_text(helpWindowX1 + textBuffer, helpWindowY1 + (textBuffer * 2) + functionHelp_plusY, "Rezonator Functions");
	
	var cellHeight = 14;
	var cellPlusY = 16;
	for (var i = 0; i < ds_grid_height(functionHelp_helpGridRez); i++) {
		var cellRectX1 = helpWindowX1 + textBuffer;
		var cellRectY1 = helpWindowY1 + (textBuffer * 2) + functionHelp_plusY + cellPlusY;
		var cellRectX2 = helpWindowX2 - textBuffer;
		var cellRectY2 = cellRectY1 + cellHeight;
		
		if (i mod 2) {
			draw_set_color(c_white);
		}
		else {
			draw_set_color(c_ltgray);
		}
		draw_rectangle(cellRectX1, cellRectY1, cellRectX2, cellRectY2, false);
		draw_set_color(c_black);
		draw_set_font(fnt_chainContents);
		draw_set_halign(fa_left);
		draw_set_valign(fa_middle);
		var currentStrKey = ds_grid_get(functionHelp_helpGridRez, functionHelp_helpGrid_colKey, i);
		var currentStrDesc = ds_grid_get(functionHelp_helpGridRez, functionHelp_helpGrid_colDesc, i);
		draw_text(cellRectX1 + textBuffer, mean(cellRectY1, cellRectY2), currentStrKey);
		draw_text(mean(cellRectX1, cellRectX2) + textBuffer, mean(cellRectY1, cellRectY2), currentStrDesc);
		
		cellPlusY += cellHeight;
	}
	
	cellPlusY += 16;
	draw_set_font(fnt_mainBold);
	draw_text(helpWindowX1 + textBuffer, helpWindowY1 + (textBuffer * 2) + functionHelp_plusY + cellPlusY, "Navigator Functions");
	cellPlusY += 16;
	
	for (var i = 0; i < ds_grid_height(functionHelp_helpGridNav); i++) {
		var cellRectX1 = helpWindowX1 + textBuffer;
		var cellRectY1 = helpWindowY1 + (textBuffer * 2) + functionHelp_plusY + cellPlusY;
		var cellRectX2 = helpWindowX2 - textBuffer;
		var cellRectY2 = cellRectY1 + cellHeight;
		
		if (i mod 2) {
			draw_set_color(c_white);
		}
		else {
			draw_set_color(c_ltgray);
		}
		draw_rectangle(cellRectX1, cellRectY1, cellRectX2, cellRectY2, false);
		draw_set_color(c_black);
		draw_set_font(fnt_chainContents);
		draw_set_halign(fa_left);
		draw_set_valign(fa_middle);
		var currentStrKey = ds_grid_get(functionHelp_helpGridNav, functionHelp_helpGrid_colKey, i);
		var currentStrDesc = ds_grid_get(functionHelp_helpGridNav, functionHelp_helpGrid_colDesc, i);
		draw_text(cellRectX1 + textBuffer, mean(cellRectY1, cellRectY2), currentStrKey);
		draw_text(mean(cellRectX1, cellRectX2) + textBuffer, mean(cellRectY1, cellRectY2), currentStrDesc);
		
		cellPlusY += cellHeight;
	}
}