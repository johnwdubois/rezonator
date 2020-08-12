var camWidth = camera_get_view_width(view_camera[0]);
var camHeight = camera_get_view_height(view_camera[0]);

var rowHeight = string_height("A") * 1.3;



// Tag Info window
var tagInfoWindowRectX1 = 40;
var tagInfoWindowRectY1 = (camHeight / 2) - 100;
var tagInfoWindowRectX2 = camWidth - 40;
var tagInfoWindowRectY2 = camHeight - 150;




windowWidth = clamp(tagInfoWindowRectX2 - tagInfoWindowRectX1, 48, 2000);
windowHeight = clamp(tagInfoWindowRectY2 - tagInfoWindowRectY1, 48, 1500);
clipWidth = windowWidth;
clipHeight = windowHeight;
	
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



// Draw Tag Info window contents
draw_set_font(fnt_main);
draw_set_halign(fa_left);
draw_set_valign(fa_middle);
var mouseoverRow = -1;
var plainTextInfoGridHeight = ds_grid_height(global.plainTextInfoGrid);

for (var i = 0; i <= global.plainTextInfoGrid_colGroup; i++) {
	var colX = tagInfoWindowRectX1 + ((windowWidth / (global.plainTextInfoGrid_colGroup + 1)) * i);
	
	var plusY = tagInfoWindowRectY1 + rowHeight;
	
	for (var j = 0; j < plainTextInfoGridHeight; j++) {
		
		var cellRectX1 = colX;
		var cellRectY1 = plusY + scrollPlusY;
		var cellRectX2 = (i == 0) ? tagInfoWindowRectX1 + ((tagInfoWindowRectX2 - tagInfoWindowRectX1) / 3) : tagInfoWindowRectX2 - global.scrollBarWidth;
		//var cellRectX2 = cellRectX1 + (windowWidth / global.tagInfoGrid_colSingleTokenMarker);
		var cellRectY2 = plusY + rowHeight;
		
		// draw BG stripes
		draw_set_color(global.colorThemeBG);
		draw_rectangle(cellRectX1 - clipX, cellRectY1 - clipY, cellRectX2 - clipX, cellRectY2 - clipY, false);
		
		if (scr_pointInRectangleClippedWindow(mouse_x, mouse_y, cellRectX1, cellRectY1, cellRectX2, cellRectY2)) {
			mouseoverRow = j;
		}
		
		var currentCell = ds_grid_get(global.plainTextInfoGrid, i, j);
		
		/*
		if (i == global.tagInfoGrid_colMarkerPercent) {
			currentCell = string(currentCell) + "%";
		}
		else if (i == global.tagInfoGrid_colSingleTokenMarker) {
			currentCell = (currentCell) ? "X" : "";
		}
		*/
		
		draw_set_color(global.colorThemeText);
		draw_set_font(fnt_main);
		draw_text(colX + 5 - clipX, floor(plusY + (rowHeight / 2) + scrollPlusY) - clipY, string(currentCell));
		
		plusY += rowHeight;
	}
}



// draw header for column
draw_set_color(global.colorThemeBG);
draw_rectangle(tagInfoWindowRectX1 - clipX, tagInfoWindowRectY1 - clipY, tagInfoWindowRectX2 - clipX, tagInfoWindowRectY1 + rowHeight - clipY, false);
var plainTextInfoGridWidth = ds_grid_width(global.plainTextInfoGrid);
for (var i = 0; i < plainTextInfoGridWidth; i++) {
	var colX = tagInfoWindowRectX1 + ((windowWidth / (global.plainTextInfoGrid_colGroup + 1)) * i);
	
	var headerStr = "";
	switch (i) {
		case 0:
			headerStr = "Text";
			break;
		case 1:
			headerStr = "Group";
			break;
		default:
			break;
	}
	draw_set_font(fnt_mainBold);
	draw_set_color(global.colorThemeText);
	draw_text(colX + 5 - clipX, floor(tagInfoWindowRectY1 + (rowHeight / 2)) - clipY, headerStr);
	
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

scr_scrollBar(ds_grid_height(global.plainTextInfoGrid), -1, rowHeight, rowHeight,
	global.colorThemeSelected1, global.colorThemeSelected2,
	global.colorThemeSelected1, global.colorThemeSelected2, spr_ascend, (tagInfoWindowRectX2 - tagInfoWindowRectX1), (tagInfoWindowRectY2 - tagInfoWindowRectY1));
	
scrollPlusY = min(scrollPlusY, 0);



scr_surfaceEnd();


draw_set_color(global.colorThemeText);
draw_set_font(fnt_mainBold);
draw_set_halign(fa_left);
draw_set_valign(fa_middle);
draw_text(tagInfoWindowRectX1, floor(tagInfoWindowRectY1 - string_height("0")), "Lines Found");


// draw Tag Info window border
draw_set_color(global.colorThemeBorders);
draw_set_alpha(1);
draw_rectangle(tagInfoWindowRectX1, tagInfoWindowRectY1, tagInfoWindowRectX2, tagInfoWindowRectY2, true);
if (obj_importMapping.rezInfoGridSelectedRow >= 0) {
	for (var i = 0; i < 5; i++) {
		draw_rectangle(tagInfoWindowRectX1 - i, tagInfoWindowRectY1 - i, tagInfoWindowRectX2 + i, tagInfoWindowRectY2 + i, true);
	}
}

