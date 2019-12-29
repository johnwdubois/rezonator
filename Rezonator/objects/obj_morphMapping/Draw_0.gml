scr_windowCameraAdjust();

draw_set_color(global.colorThemeText);
draw_set_alpha(1);

var camWidth = camera_get_view_width(view_camera[0]);
var camHeight = camera_get_view_height(view_camera[0]);
var leftMargin = 200;
var topMargin = 150;

draw_set_font(fnt_main);
draw_set_halign(fa_left);
/*
for (var i = 0; i < ds_grid_height(global.importMapGrid); i++) {
	
	var currentRezData = ds_grid_get(global.importMapGrid, global.importMapGrid_colRezData, i);
	draw_text(leftMargin + (i * 100), camHeight / 2, currentRezData);
}

for (var i = 0; i < ds_grid_width(global.importToolboxGrid); i++) {
	
	var currentImportGridCol = global.importToolboxGridColName[i];
	draw_text(leftMargin + (i * 100), (camHeight / 2) + 100, currentImportGridCol);
}
*/

var pickwhipColorNormal = c_blue;
var pickwhipColorRequired = c_red;

var cellRectBuffer = 5;

var mouseoverRow = -1;

draw_set_font(fnt_main);
draw_set_halign(fa_right);
draw_set_valign(fa_middle);
for (var i = 0; i < ds_grid_width(global.importMapGrid); i++) {
	for (var j = 0; j < ds_grid_height(global.importMapGrid); j++) {
		
		draw_set_halign(fa_left);
		
		var currentCell = string(ds_grid_get(global.importMapGrid, i, j));
		
		if (i == global.importMapGrid_colRezData and currentCell == 0) {
			continue;
		}
		
		var cellRectX1 = leftMargin + (200 * i) - cellRectBuffer;
		var cellRectY1 = topMargin + (j * (string_height("0") * 1.4)) - (string_height(currentCell) / 2) - cellRectBuffer;
		var cellRectX2 = cellRectX1 + string_width(currentCell) + (cellRectBuffer * 2);
		var cellRectY2 = cellRectY1 + string_height(currentCell) + (cellRectBuffer * 2);
		
		var currentImportGridCol = ds_grid_get(global.importMapGrid, global.importMapGrid_colImportGridCol, j);
		
		
		if (point_in_rectangle(mouse_x, mouse_y, cellRectX1, cellRectY1, cellRectX2, cellRectY2) and mouseoverRow < 0) {
			mouseoverRow = j;
			draw_set_color(global.colorThemeBorders);
			draw_rectangle(cellRectX1, cellRectY1, cellRectX2, cellRectY2, true);
			
			if (mouse_check_button_released(mb_left)) {
				if (i == global.importMapGrid_colRezData) {
					pickwhippedRow = j;
				}
				
				if (i == global.importMapGrid_colSourceData and pickwhippedRow >= 0) {
					ds_grid_set(global.importMapGrid, global.importMapGrid_colImportGridCol, pickwhippedRow, j);
					pickwhippedRow = -1;
				}
			}
		}
		
		if (i == global.importMapGrid_colRezData and pickwhippedRow == j) {
			draw_set_color(pickwhipColorNormal);
			draw_rectangle(cellRectX1, cellRectY1, cellRectX2, cellRectY2, true);
			draw_line_width(cellRectX2, mean(cellRectY1, cellRectY2), mouse_x, mouse_y, 2);	
		}
		
		if (i == global.importMapGrid_colRezData and currentImportGridCol >= 0) {
			draw_set_color(pickwhipColorNormal);
			draw_rectangle(cellRectX1, cellRectY1, cellRectX2, cellRectY2, true);
			
			var otherCell = ds_grid_get(global.importMapGrid, global.importMapGrid_colSourceData, currentImportGridCol);
			var otherCellRectX1 = leftMargin + (200 * global.importMapGrid_colSourceData) - cellRectBuffer;
			var otherCellRectY1 = topMargin + (currentImportGridCol * (string_height("0") * 1.4)) - (string_height(otherCell) / 2) - cellRectBuffer;
			var otherCellRectX2 = otherCellRectX1 + string_width(otherCell) + (cellRectBuffer * 2);
			var otherCellRectY2 = otherCellRectY1 + string_height(otherCell) + (cellRectBuffer * 2);
			
			draw_rectangle(otherCellRectX1, otherCellRectY1, otherCellRectX2, otherCellRectY2, true);
			draw_line_width(cellRectX2, mean(cellRectY1, cellRectY2), otherCellRectX1, mean(otherCellRectY1, otherCellRectY2), 2);	
		}
		
		
		draw_set_color(global.colorThemeText);
		draw_text(cellRectX1, mean(cellRectY1, cellRectY2), currentCell);
	}
}

if (keyboard_check_pressed(vk_escape)) {
	pickwhippedRow = -1;
}


//debug
draw_set_font(fnt_debug);
draw_set_color(global.colorThemeText);
draw_text(10, 10, "pickwhippedRow: " + string(pickwhippedRow));