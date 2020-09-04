if (live_call()) return live_result;

var camWidth = camera_get_view_width(view_camera[0]);
var camHeight = camera_get_view_height(view_camera[0]);

var colAmount = global.tagInfoGridWidth;

scr_windowCameraAdjust();


// Tag Info window
var tagInfoWindowRectX1 = 40;
var tagInfoWindowRectY1 = (camHeight / 2) - 100;
var tagInfoWindowRectX2 = (camWidth) - 50;
var tagInfoWindowRectY2 = camHeight - 150;

windowWidth = max(tagInfoWindowRectX2 - tagInfoWindowRectX1, 48);
windowHeight = max(tagInfoWindowRectY2 - tagInfoWindowRectY1, 48);
clipWidth = windowWidth;
clipHeight = windowHeight;

var rowHeight = string_height("A") * 1.3;
var colWidth = windowWidth / colAmount;
	
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


if ((!point_in_rectangle(mouse_x, mouse_y, tagInfoWindowRectX1, tagInfoWindowRectY1, tagInfoWindowRectX2 - global.scrollBarWidth, tagInfoWindowRectY2) && !instance_exists(obj_dropDown))
|| scrollBarHolding) {
	obj_importMapping.mouseoverRow = -1;
}


var timesHit = 0;
var buttonRectSize = rowHeight - 10;



// Draw Tag Info window contents
draw_set_font(global.fontMain);
draw_set_halign(fa_left);
draw_set_valign(fa_middle);

for (var i = 0; i < colAmount; i++) {
	var prevColX = tagInfoWindowRectX1 + ((windowWidth / (colAmount)) * 2);
	var colX = tagInfoWindowRectX1 + ((windowWidth / (colAmount)) * i);
	var nextColX = tagInfoWindowRectX1 + ((windowWidth / (colAmount)) * 3);
	var plusY = tagInfoWindowRectY1 + rowHeight;
	
	
	var realNextColX = tagInfoWindowRectX1 + ((windowWidth / (colAmount)) * (i + 1));
	draw_set_color(global.colorThemeBG);
	draw_rectangle(colX - clipX, tagInfoWindowRectY1 - clipY, realNextColX - clipX, tagInfoWindowRectY2 - clipY, false);
	
	
	var tagInfoGridHeight = ds_grid_height(global.tagInfoGrid);
	
	for (var j = 0; j < tagInfoGridHeight; j++) {
		
		draw_set_halign(fa_left);
		
		var cellRectX1 = colX;
		var cellRectY1 = plusY + scrollPlusY;
		var cellRectX2 = cellRectX1 + (windowWidth / colAmount);
		var cellRectY2 = cellRectY1 + rowHeight;

		
		if (point_in_rectangle(mouse_x, mouse_y, cellRectX1, cellRectY1, cellRectX2, cellRectY2) and point_in_rectangle(mouse_x, mouse_y, x, y, x + windowWidth - global.scrollBarWidth, y + windowHeight)
		&& !instance_exists(obj_dropDown)) {
			if (!scrollBarHolding) {
				obj_importMapping.mouseoverRow = j;
				timesHit++;
			}
		}
		if (obj_importMapping.mouseoverRow == j) {
			draw_set_color(global.colorThemeSelected1);
			draw_rectangle(cellRectX1 - clipX, cellRectY1 - clipY, cellRectX2 - clipX, cellRectY2 - clipY, false);
		}
		
		
		var currentCell = ds_grid_get(global.tagInfoGrid, i, j);
		
		if (i == global.tagInfoGrid_colMarkerPercent) {
			if (currentCell >= 99 && currentCell < 100) {
				currentCell = 99;
			}
			currentCell = string(max(round(currentCell), 1)) + "%";
		}
		else if (i == global.tagInfoGrid_colSingleTokenMarker) {
			currentCell = (currentCell) ? "Yes" : "";
		}
		else if (i == global.tagInfoGrid_colLevel) {
			if (currentCell == global.levelToken) {
				currentCell = "token";
			}
			else if (currentCell == global.levelUnit) {
				currentCell = "unit";
			}
			else if (currentCell == global.levelDiscourse) {
				currentCell = "discourse";
			}
			else {
				currentCell = "";
			}
		}
		else if (i == global.tagInfoGrid_colSpecialFields) {
			
			if (currentCell == "0") {
				currentCell = "";
			}
			
			var currentLevel = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colLevel, j);
			if (currentLevel == global.levelToken || currentLevel == global.levelUnit) {
			
				var dropDownButtonX1 = floor(colX + colWidth - 4 - global.scrollBarWidth - buttonRectSize);
				var dropDownButtonY1 = floor(plusY + 5 + scrollPlusY);
				var dropDownButtonX2 = floor(dropDownButtonX1 + buttonRectSize);
				var dropDownButtonY2 = floor(dropDownButtonY1 + buttonRectSize);
				
				if (!instance_exists(obj_dropDown)) {
					if (point_in_rectangle(mouse_x, mouse_y, dropDownButtonX1, dropDownButtonY1, dropDownButtonX2, dropDownButtonY2)) {
						draw_set_color(global.colorThemeBG);
						draw_rectangle(dropDownButtonX1 - clipX, dropDownButtonY1 - clipY, dropDownButtonX2 - clipX, dropDownButtonY2 - clipY, false);
						draw_set_color(global.colorThemeBorders);
						draw_rectangle(dropDownButtonX1 - clipX, dropDownButtonY1 - clipY, dropDownButtonX2 - clipX, dropDownButtonY2 - clipY, true);
				
						if (mouse_check_button_pressed(mb_left)) {
							obj_importMapping.inDropDown = true;
						}
						if (mouse_check_button_released(mb_left)) {
							obj_importMapping.colToChange = i;
							obj_importMapping.rowToChange = j;
					
							var dropDownOptionList = ds_list_create();
						
							if (ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colLevel, j) == global.levelUnit) {
								ds_list_add(dropDownOptionList, "Speaker", "Unit Start", "Unit End", "Unit Delimiter", "Turn Delimiter");
							}
							if (ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colLevel, j) == global.levelToken) {
								ds_list_add(dropDownOptionList, "Display Token");
							}
							if (ds_list_size(dropDownOptionList) > 0) {
								var dropDownInst = instance_create_depth(colX, floor(plusY + rowHeight  + scrollPlusY) , -999, obj_dropDown);
								dropDownInst.optionList = dropDownOptionList;
								dropDownInst.optionListType = 32;
							}
						}
					}
				}
			
				draw_sprite_ext(spr_dropDown, 0, mean(dropDownButtonX1, dropDownButtonX2) - clipX, mean(dropDownButtonY1, dropDownButtonY2) - clipY, 1, -1, 0, c_white, 1);
			}
			
		}
		
		
		draw_set_color(global.colorThemeText);
		draw_set_font(global.fontMain);
		draw_text(floor(colX + 5 - clipX), floor(plusY + (rowHeight / 2) + scrollPlusY - clipY), string(currentCell));
		
		if (i == global.tagInfoGrid_colLevel) {
			
			var dropDownButtonX1 = floor(colX + colWidth - 4 - buttonRectSize);
			var dropDownButtonY1 = floor(plusY + 5 + scrollPlusY);
			var dropDownButtonX2 = dropDownButtonX1 + buttonRectSize;
			var dropDownButtonY2 = dropDownButtonY1 + buttonRectSize;

			if (scr_pointInRectangleClippedWindow(mouse_x, mouse_y, dropDownButtonX1, dropDownButtonY1, dropDownButtonX2, dropDownButtonY2)) {
				
				if (!instance_exists(obj_dropDown)) {
					draw_set_color(global.colorThemeBG);
					draw_rectangle(dropDownButtonX1 - clipX, dropDownButtonY1 - clipY, dropDownButtonX2 - clipX, dropDownButtonY2 - clipY, false);
				
					draw_set_color(global.colorThemeBorders);
					draw_rectangle(dropDownButtonX1 - clipX, dropDownButtonY1 - clipY, dropDownButtonX2 - clipX, dropDownButtonY2 - clipY, true);
					mouseOverLevel = true;
					if (mouse_check_button_pressed(mb_left)) {
						obj_importMapping.inDropDown = true;
					}
					if (mouse_check_button_released(mb_left)) {
						obj_importMapping.colToChange = i;
						obj_importMapping.rowToChange = j;
					
						var dropDownOptionList = ds_list_create();

						ds_list_add(dropDownOptionList, "Token", "Unit", "Discourse" , "Exception");

						if (ds_list_size(dropDownOptionList) > 0 ) {
							var dropDownInst = instance_create_depth(prevColX,floor(plusY + rowHeight  + scrollPlusY) , -999, obj_dropDown);
							dropDownInst.optionList = dropDownOptionList;
							dropDownInst.optionListType = 12;
						}
					}
				}
			}
			else {
				mouseOverLevel = false;
			}
		
			draw_sprite_ext(spr_dropDown, 0, mean(dropDownButtonX1, dropDownButtonX2) - clipX, mean(dropDownButtonY1, dropDownButtonY2) - clipY, 1, 1, 0, c_white, 1);
		
		}

		plusY += rowHeight;
	}
}

draw_set_halign(fa_left);

if (obj_importMapping.mouseoverRow >= 0) {
	if (mouse_check_button_released(mb_left) and !mouseOverLevel and !obj_importMapping.inDropDown) {
		obj_importMapping.rezInfoGridSelectedRow = obj_importMapping.mouseoverRow;
		
		
		// set every marker that has the same level as the one clicked to display false,
		// and then set the clicked marker's display to true
		var selectedRowLevel = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colLevel, obj_importMapping.rezInfoGridSelectedRow);
		var tagInfoGridHeight = ds_grid_height(global.tagInfoGrid);
		/*
		for (var i = 0; i < tagInfoGridHeight; i++) {
			var currentLevel = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colLevel, i);
			var currentField = ds_grid_get(global.tagInfoGrid, global.tagInfoGrid_colSpecialFields, i);
			if (currentLevel == selectedRowLevel ) {
				if (selectedRowLevel == global.levelToken && currentField == "Display Token") {
					ds_grid_set(global.tagInfoGrid, global.tagInfoGrid_colSpecialFields, i, 0);
				}
				else if (selectedRowLevel == global.levelUnit && currentField == "Speaker") {
					ds_grid_set(global.tagInfoGrid, global.tagInfoGrid_colSpecialFields, i, 0);
				}
			}
		}
		if (selectedRowLevel == global.levelToken) {
			ds_grid_set(global.tagInfoGrid, global.tagInfoGrid_colSpecialFields, obj_importMapping.rezInfoGridSelectedRow, "Display Token");
		}
		else if (selectedRowLevel == global.levelUnit) {
			ds_grid_set(global.tagInfoGrid, global.tagInfoGrid_colSpecialFields, obj_importMapping.rezInfoGridSelectedRow, "Speaker");
		}
		*/
	}
}


if (obj_importMapping.rezInfoGridSelectedRow < 0) {
	obj_importMapping.rezInfoGridSelectedRow = -1;
}














// draw header for column
draw_set_color(global.colorThemeBG);
draw_rectangle(tagInfoWindowRectX1 - clipX, tagInfoWindowRectY1 - clipY, tagInfoWindowRectX2 - clipX, tagInfoWindowRectY1 + rowHeight - clipY, false);
for (var i = 0; i < colAmount; i++) {
	var colX = tagInfoWindowRectX1 + ((windowWidth / (colAmount)) * i);
	var headerStr = "";
	if (i == global.tagInfoGrid_colMarker) {
		headerStr = "Marker";
	}
	else if (i == global.tagInfoGrid_colExample) {
		headerStr = "Example";
	}
	else if (i == global.tagInfoGrid_colLevel) {
		headerStr = "Level Estimate";
	}
	else if (i == global.tagInfoGrid_colMarkerPercent) {
		headerStr = "Marker %";
	}
	else if (i == global.tagInfoGrid_colSingleTokenMarker) {
		headerStr = "Single Token";
	}
	else if (i == global.tagInfoGrid_colTokenCount) {
		headerStr = "Token Count";
	}
	else if (i == global.tagInfoGrid_colSpecialFields) {
		headerStr = "Special Fields";
	}

	draw_set_font(global.fontMainBold);
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

scr_scrollBar(ds_grid_height(global.tagInfoGrid), -1, rowHeight, rowHeight,
global.colorThemeSelected1, global.colorThemeSelected2,
global.colorThemeSelected1, global.colorThemeSelected2, spr_ascend, (tagInfoWindowRectX2 - tagInfoWindowRectX1), (tagInfoWindowRectY2 - tagInfoWindowRectY1));
	
scrollPlusY = min(scrollPlusY, 0);



scr_surfaceEnd();






// draw Tag Info window border
draw_set_color(global.colorThemeBorders);
draw_set_alpha(1);
draw_rectangle(tagInfoWindowRectX1, tagInfoWindowRectY1, tagInfoWindowRectX2, tagInfoWindowRectY2, true);