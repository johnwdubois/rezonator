var camWidth = camera_get_view_width(view_camera[0]);
var camHeight = camera_get_view_height(view_camera[0]);

var rowHeight = string_height("A") * 1.3;



// Tag Info window
var tagInfoWindowRectX1 = 40;
var tagInfoWindowRectY1 = (camHeight / 2) - 100;
var tagInfoWindowRectX2 = (camWidth / 2) - 50;
var tagInfoWindowRectY2 = camHeight - 150;
// Rez Info window
var rezInfoWindowRectX1 = (camWidth / 2) + 50;
var rezInfoWindowRectY1 = (camHeight / 2) - 100;
var rezInfoWindowRectX2 = camWidth - 40;
var rezInfoWindowRectY2 = camHeight - 150;



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

for (var i = 0; i <= obj_importMapping.tagInfoGrid_colConsistency; i++) {
	var colX = tagInfoWindowRectX1 + ((windowWidth / (obj_importMapping.tagInfoGrid_colConsistency + 1)) * i);
	
	var plusY = tagInfoWindowRectY1 + rowHeight;
	
	var tagInfoGridHeight = ds_grid_height(obj_importMapping.tagInfoGrid);
	for (var j = 0; j < tagInfoGridHeight; j++) {
		
		var cellRectX1 = colX;
		var cellRectY1 = plusY + scrollPlusY;
		var cellRectX2 = (i == 0) ? tagInfoWindowRectX1 + ((tagInfoWindowRectX2 - tagInfoWindowRectX1) / 3) : tagInfoWindowRectX2 - scrollBarWidth;
		//var cellRectX2 = cellRectX1 + (windowWidth / obj_importMapping.tagInfoGrid_colOneTokenPerGroup);
		var cellRectY2 = plusY + rowHeight;
		
		// draw BG stripes
		draw_set_color(global.colorThemeBG);
		if (obj_importMapping.tagInfoGridSelectedRow == j
		or ds_grid_get(obj_importMapping.tagInfoGrid, obj_importMapping.tagInfoGrid_colMapped, j)) {
			draw_set_color(ds_grid_get(obj_importMapping.tagInfoGrid, obj_importMapping.tagInfoGrid_colColor, j));
		}
		draw_rectangle(cellRectX1 - clipX, cellRectY1 - clipY, cellRectX2 - clipX, cellRectY2 - clipY, false);
		
		if (scr_pointInRectangleClippedWindow(mouse_x, mouse_y, cellRectX1, cellRectY1, cellRectX2, cellRectY2)) {
			mouseoverRow = j;
		}
		
		var currentCell = ds_grid_get(obj_importMapping.tagInfoGrid, i, j);
		
		if (i == obj_importMapping.tagInfoGrid_colConsistency) {
			currentCell = string(max(round(currentCell), 1)) + "%";
		}
		else if (i == obj_importMapping.tagInfoGrid_colOneTokenPerGroup) {
			currentCell = (currentCell) ? "Yes" : "";
		}
		
		draw_set_color(global.colorThemeText);
		draw_set_font(fnt_main);
		draw_text(floor(colX + 5 - clipX), floor(plusY + (rowHeight / 2) + scrollPlusY - clipY), string(currentCell));
		
		plusY += rowHeight;
	}
}

if (mouseoverRow >= 0) {
	if (mouse_check_button_pressed(mb_left)) {
		/*
		if (obj_importMapping.rezInfoGridSelectedRow >= 0) {
			
			var oldTag = ds_grid_get(global.rezInfoGrid, global.rezInfoGrid_colAssignedTag, obj_importMapping.rezInfoGridSelectedRow);
			if (oldTag != 0) {
				var oldTagRow = ds_grid_value_y(obj_importMapping.tagInfoGrid, obj_importMapping.tagInfoGrid_colLabel, 0, obj_importMapping.tagInfoGrid_colLabel, ds_grid_height(obj_importMapping.tagInfoGrid), oldTag);
				
				var occurences = 0;
				for (var i = 0; i < ds_grid_height(obj_importMapping.tagInfoGrid); i++) {
					occurences += (ds_grid_get(global.rezInfoGrid, global.rezInfoGrid_colAssignedTag, i) == oldTag) ? 1 : 0;
				}
				
				if (occurences < 2) {
					ds_grid_set(obj_importMapping.tagInfoGrid, obj_importMapping.tagInfoGrid_colMapped, oldTagRow, false);
				}
			}
			
			obj_importMapping.tagInfoGridSelectedRow = mouseoverRow;
			var tag = ds_grid_get(obj_importMapping.tagInfoGrid, obj_importMapping.tagInfoGrid_colLabel, mouseoverRow);
			ds_grid_set(global.rezInfoGrid, global.rezInfoGrid_colAssignedTag, obj_importMapping.rezInfoGridSelectedRow, tag);
			ds_grid_set(global.rezInfoGrid, global.rezInfoGrid_colAssignedCol, obj_importMapping.rezInfoGridSelectedRow, mouseoverRow);
			ds_grid_set(obj_importMapping.tagInfoGrid, obj_importMapping.tagInfoGrid_colMapped, mouseoverRow, true);
		}
		*/
		obj_importMapping.tagInfoGridSelectedRow = mouseoverRow;
	}
}


if (obj_importMapping.tagInfoGridSelectedRow < 0) {
	obj_importMapping.rezInfoGridSelectedRow = -1;
}








// draw mouseover/selected rectangles
if (mouseoverRow >= 0) {
	draw_set_color(global.colorThemeBorders);
	var mouseoverRowY1 = tagInfoWindowRectY1 + (rowHeight * (mouseoverRow + 1)) + scrollPlusY;
	var mouseoverRowY2 = mouseoverRowY1 + rowHeight;
	draw_rectangle(tagInfoWindowRectX1 - clipX, mouseoverRowY1 - clipY, tagInfoWindowRectX2 - clipX, mouseoverRowY2 - clipY, true);
}
if (obj_importMapping.tagInfoGridSelectedRow > -1) {
	if (keyboard_check_pressed(vk_escape)) {
		obj_importMapping.tagInfoGridSelectedRow = -1;
	}
	draw_set_color(global.colorThemeBorders);
	var selectedRowY1 = tagInfoWindowRectY1 + (rowHeight * (obj_importMapping.tagInfoGridSelectedRow + 1)) + scrollPlusY;
	var selectedRowY2 = selectedRowY1 + rowHeight;
	draw_rectangle(tagInfoWindowRectX1 - clipX, selectedRowY1 - clipY, tagInfoWindowRectX2 - clipX, selectedRowY2 - clipY, true);
}




// draw header for column
draw_set_color(global.colorThemeBG);
draw_rectangle(tagInfoWindowRectX1 - clipX, tagInfoWindowRectY1 - clipY, tagInfoWindowRectX2 - clipX, tagInfoWindowRectY1 + rowHeight - clipY, false);
for (var i = 0; i < obj_importMapping.tagInfoGrid_colConsistency + 1; i++) {
	var colX = tagInfoWindowRectX1 + ((windowWidth / (obj_importMapping.tagInfoGrid_colConsistency + 1)) * i);
	var headerStr = "";
	switch (i) {
		case obj_importMapping.tagInfoGrid_colLabel:
			headerStr = "Line Label";
			break;
		case obj_importMapping.tagInfoGrid_colExample:
			headerStr = "Example";
			break;
		case obj_importMapping.tagInfoGrid_colLevelEstimation:
			headerStr = "Level Estimate";
			break;
		case obj_importMapping.tagInfoGrid_colConsistency:
			headerStr = "% of Groups Labeled";
			break;
		case obj_importMapping.tagInfoGrid_colGroup:
			headerStr = "Group";
			break;
		case obj_importMapping.tagInfoGrid_colOneTokenPerGroup:
			headerStr = "1 Token Per Group";
			break;
		default:
			break;
	}
	draw_set_font(fnt_mainBold);
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

scr_scrollBar(ds_grid_height(obj_importMapping.tagInfoGrid), -1, rowHeight, rowHeight,
	global.colorThemeSelected1, global.colorThemeSelected2,
	global.colorThemeSelected1, global.colorThemeSelected2, spr_ascend, (tagInfoWindowRectX2 - tagInfoWindowRectX1), (tagInfoWindowRectY2 - tagInfoWindowRectY1));
	
scrollPlusY = min(scrollPlusY, 0);



scr_surfaceEnd();


draw_set_color(global.colorThemeText);
draw_set_font(fnt_mainBold);
draw_set_halign(fa_left);
draw_set_valign(fa_middle);
draw_text(floor(tagInfoWindowRectX1), floor(tagInfoWindowRectY1 - string_height("0")), "Import Fields");




// draw Tag Info window border
draw_set_color(global.colorThemeBorders);
draw_set_alpha(1);
draw_rectangle(tagInfoWindowRectX1, tagInfoWindowRectY1, tagInfoWindowRectX2, tagInfoWindowRectY2, true);