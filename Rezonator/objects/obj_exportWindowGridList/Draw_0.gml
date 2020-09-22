

// this window should only exist if hideAll is true
if (!obj_control.hideAll) {
	instance_destroy();
}

// set width & height for this window
var camWidth = camera_get_view_width(camera_get_active());
var camHeight = camera_get_view_height(camera_get_active());
exportWindowWidth = camWidth * 0.75;
windowWidth = camWidth / 5;
windowHeight = camHeight * 0.75;

// set position for this window
x = (camWidth / 2) - (exportWindowWidth / 2);
y = (camHeight / 2) - (windowHeight / 2);


// draw base for this window
draw_set_color(global.colorThemeBG);
draw_rectangle(x, y, x + windowWidth, y + windowHeight, false);
draw_set_color(global.colorThemeBorders);
draw_rectangle(x, y, x + windowWidth, y + windowHeight, true);


// draw window title
draw_set_halign(fa_left);
draw_set_valign(fa_middle);
draw_set_font(global.fontMainBold);
draw_set_color(global.colorThemeText);
draw_text(x, y - string_height("0"), "Export");


if (!point_in_rectangle(mouse_x, mouse_y, x, y, x + windowWidth, y + windowHeight)) {
	mouseoverRow = -1;
}
scr_surfaceStart();

// loop through and draw a selectable list of grids
var cellHeight = string_height("0") * 2;
var exportGridListSize = ds_list_size(exportGridList);
for (var i = 0; i < exportGridListSize; i++) {
	
	var currentGrid = ds_list_find_value(exportGridList, i);
	var currentGridStr = scr_getGridNameString(currentGrid);

	var currentCellY1 = y + (i * cellHeight) + scrollPlusY;
	var currentCellY2 = currentCellY1 + cellHeight;
	var currentBGColor = (mouseoverRow == i) ? global.colorThemeSelected1 : global.colorThemeBG;
	if (scr_pointInRectangleClippedWindow(mouse_x, mouse_y, x, currentCellY1, x + windowWidth, currentCellY2 - scrollPlusY)) {
		mouseoverRow = i;
	}
	if (mouseoverRow == i && mouse_check_button_released(mb_left)) {
		selectedGrid = currentGrid;
	}
	
	
	draw_set_color(currentBGColor);
	draw_rectangle(x - clipX, currentCellY1 - clipY, x + windowWidth - clipX, currentCellY2 - clipY, false);
	draw_set_color(global.colorThemeBorders);
	draw_rectangle(x - clipX, currentCellY1 - clipY, x + windowWidth - clipX, currentCellY2 - clipY, true);
	
	draw_set_color(global.colorThemeText);
	draw_set_font(global.fontMain);
	draw_text(x + string_width("AA") - clipX, floor(mean(currentCellY1, currentCellY2)) - clipY, currentGridStr);
	
}


scr_scrollBar(exportGridListSize, -1, cellHeight, 0,
	global.colorThemeSelected1, global.colorThemeSelected2,
	global.colorThemeSelected1, global.colorThemeSelected2, spr_ascend, windowWidth, windowHeight);
	
scr_surfaceEnd();
