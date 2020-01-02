var camWidth = camera_get_view_width(view_camera[0]);
var camHeight = camera_get_view_height(view_camera[0]);


// Import Screen Title
draw_set_color(global.colorThemeText);
draw_set_font(fnt_mainBold);
draw_set_alpha(1);
draw_set_halign(fa_left);
draw_set_valign(fa_middle);
draw_text(20, 20, "Import File Mapping");



// File window
var fileInfoWindowRectX1 = 40;
var fileInfoWindowRectY1 = 80 + string_height("0");
var fileInfoWindowRectX2 = (camWidth / 3) - 20;
var fileInfoWindowRectY2 = (camHeight / 2) - 180;

draw_set_color(global.colorThemeBorders);
draw_set_alpha(1);
draw_rectangle(fileInfoWindowRectX1, fileInfoWindowRectY1, fileInfoWindowRectX2, fileInfoWindowRectY2, true);
draw_set_color(global.colorThemeText);
draw_set_font(fnt_mainBold);
draw_set_halign(fa_left);
draw_set_valign(fa_middle);
draw_text(fileInfoWindowRectX1, fileInfoWindowRectY1 - string_height("0"), "File");




// Summary window
var summaryInfoWindowRectX1 = (camWidth / 3) + 20;
var summaryInfoWindowRectY1 = 80 + string_height("0");
var summaryInfoWindowRectX2 = camWidth - 40;
var summaryInfoWindowRectY2 = (camHeight / 2) - 180;

draw_set_color(global.colorThemeBorders);
draw_set_alpha(1);
draw_rectangle(summaryInfoWindowRectX1, summaryInfoWindowRectY1, summaryInfoWindowRectX2, summaryInfoWindowRectY2, true);
draw_set_color(global.colorThemeText);
draw_set_font(fnt_mainBold);
draw_set_halign(fa_left);
draw_set_valign(fa_middle);
draw_text(summaryInfoWindowRectX1, summaryInfoWindowRectY1 - string_height("0"), "Summary");













// Rez Info window
var rezInfoWindowRectX1 = 40;
var rezInfoWindowRectY1 = (camHeight / 2) - 100;
var rezInfoWindowRectX2 = (camWidth / 2) - 50;
var rezInfoWindowRectY2 = camHeight - 150;

draw_set_color(global.colorThemeBorders);
draw_set_alpha(1);
draw_rectangle(rezInfoWindowRectX1, rezInfoWindowRectY1, rezInfoWindowRectX2, rezInfoWindowRectY2, true);
draw_set_color(global.colorThemeText);
draw_set_font(fnt_mainBold);
draw_set_halign(fa_left);
draw_set_valign(fa_middle);
draw_text(rezInfoWindowRectX1, rezInfoWindowRectY1 - string_height("0"), "Rez Info");




// Draw Rez Info window contents
draw_set_font(fnt_main);
draw_set_halign(fa_left);
draw_set_valign(fa_middle);
var mouseoverRow = -1;
var rowHeight = string_height("A") * 1.3;
for (var i = 0; i < ds_grid_width(rezInfoGrid); i++) {
	
	var colX = 0;
	if (i == 0) {
		colX = rezInfoWindowRectX1;
	}
	else {
		colX = (rezInfoWindowRectX1 + 30) + (((rezInfoWindowRectX2 - (rezInfoWindowRectX1 + 30)) / 3) * (i - 1));
	}
	
	draw_set_color(global.colorThemeBG);
	draw_rectangle(colX, rezInfoWindowRectY1, rezInfoWindowRectX2, rezInfoWindowRectY2, false);
	draw_set_color(global.colorThemeBorders);
	draw_rectangle(colX, rezInfoWindowRectY1, rezInfoWindowRectX2, rezInfoWindowRectY2, true);
	
	
	// draw header for column
	var headerStr = "";
	switch (i) {
		case 0:
			headerStr = "#";
			break;
		case 1:
			headerStr = "Level";
			break;
		case 2:
			headerStr = "Tier";
			break;
		case 3:
			headerStr = "Assigned Tag";
			break;
		default:
			break;
	}
	draw_set_font(fnt_mainBold);
	draw_set_color(global.colorThemeText);
	draw_text(colX + 5, rezInfoWindowRectY1 + (rowHeight / 2), headerStr);
	
	var plusY = rezInfoWindowRectY1 + rowHeight;
	
	for (var j = 0; j < ds_grid_height(rezInfoGrid); j++) {
		
		var cellRectX1 = colX;
		var cellRectY1 = plusY;
		var cellRectX2 = (rezInfoWindowRectX1 + 30) + (((rezInfoWindowRectX2 - (rezInfoWindowRectX1 + 30)) / 3) * (i));
		var cellRectY2 = plusY + rowHeight;
		
		if (point_in_rectangle(mouse_x, mouse_y, cellRectX1, cellRectY1, cellRectX2, cellRectY2)) {
			mouseoverRow = j + 1;
		}
		
		
		var currentCell = ds_grid_get(rezInfoGrid, i, j);
		draw_set_color(global.colorThemeText);
		draw_set_font(fnt_main);
		draw_text(colX + 5, floor(plusY + (rowHeight / 2)), string(currentCell));
		
		plusY += rowHeight;
	}
}

if (mouseoverRow >= 0) {
	draw_set_color(c_red);
	var mouseoverRowY1 = rezInfoWindowRectY1 + (rowHeight * mouseoverRow);
	var mouseoverRowY2 = mouseoverRowY1 + rowHeight;
	draw_rectangle(rezInfoWindowRectX1, mouseoverRowY1,rezInfoWindowRectX2, mouseoverRowY2, true);
}









// Tag Info window
var tagInfoWindowRectX1 = (camWidth / 2) + 50;
var tagInfoWindowRectY1 = (camHeight / 2) - 100;
var tagInfoWindowRectX2 = camWidth - 40;
var tagInfoWindowRectY2 = camHeight - 150;

draw_set_color(global.colorThemeBorders);
draw_set_alpha(1);
draw_rectangle(tagInfoWindowRectX1, tagInfoWindowRectY1, tagInfoWindowRectX2, tagInfoWindowRectY2, true);
draw_set_color(global.colorThemeText);
draw_set_font(fnt_mainBold);
draw_set_halign(fa_left);
draw_set_valign(fa_middle);
draw_text(tagInfoWindowRectX1, tagInfoWindowRectY1 - string_height("0"), "Tag Info");