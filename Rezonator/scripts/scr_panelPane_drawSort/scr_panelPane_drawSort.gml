draw_set_alpha(1);
draw_set_halign(fa_left);
draw_set_valign(fa_middle);
draw_set_color(c_black);
draw_set_font(fnt_chainList);

var textMarginLeft = 12;
var textMarginTop = 20;

draw_set_font(fnt_sortPane);

var selectedGridName = "";

for (var i = 0; i < ds_grid_height(functionSort_gridGrid); i++)
{
	var currentGrid = ds_grid_get(functionSort_gridGrid, functionSort_gridGrid_colGrid, i);
	
	var gridName = "";
	gridName = scr_getGridNameString(currentGrid);
	
	var gridNameRectX1 = x + textMarginLeft;
	var gridNameRectY1 = y + textMarginTop + (i * string_height(currentGrid)) - (string_height(currentGrid) / 2);
	var gridNameRectX2 = gridNameRectX1 + string_width(gridName);
	var gridNameRectY2 = gridNameRectY1 + string_height(gridName);
	
	if (point_in_rectangle(mouse_x, mouse_y, gridNameRectX1, gridNameRectY1, gridNameRectX2, gridNameRectY2)
	or i == functionSort_gridGridSelected)
	{
		draw_set_color(c_ltgray);
		draw_rectangle(gridNameRectX1, gridNameRectY1, gridNameRectX2, gridNameRectY2, false);
		
		if (mouse_check_button_pressed(mb_left))
		{
			functionSort_gridGridSelected = i;
		}
	}
	
	draw_set_color(c_black);
	draw_text(gridNameRectX1, mean(gridNameRectY1, gridNameRectY2), gridName);
	
	if (i == functionSort_gridGridSelected)
	{
		selectedGridName = gridName;
	}
}

var selectedGrid = ds_grid_get(functionSort_gridGrid, functionSort_gridGrid_colGrid, functionSort_gridGridSelected);
functionSort_sortGrid = ds_grid_get(functionSort_gridGrid, functionSort_gridGrid_colSortGrid, functionSort_gridGridSelected);

var selectedGridHard = ds_grid_get(functionSort_gridGrid, functionSort_gridGrid_colHard, functionSort_gridGridSelected);


if (selectedGridHard)
{
	draw_set_color(c_ltgray);
	draw_rectangle(x + (windowWidth / 3), y + textMarginTop + 12, x + windowWidth, y + windowHeight, false);
}
draw_set_color(c_black);
draw_line(x + (windowWidth / 3), y, x + (windowWidth) / 3, y + windowHeight);
draw_line(x + (windowWidth / 3), y + textMarginTop + 12, x + windowWidth, y + textMarginTop + 12);

draw_set_color(c_black);
draw_set_font(fnt_sortPaneBold);
draw_text(x + (windowWidth / 3) + textMarginLeft, y + textMarginTop, selectedGridName + " sort order");


draw_set_font(fnt_sortPane);
draw_set_halign(fa_right);

var colSort;
for (var i = 0; i < 4; i++)
{
	colSort[i, 0] = 0;
	colSort[i, 1] = true;
}

var mouseoverAnyOption = false;

for (var i = 0; i < ds_grid_height(functionSort_sortGrid); i++)
{
	var ascendButtonX1 = x + (windowWidth / 3) + textMarginLeft - (sprite_get_width(spr_ascend) / 2);
	var ascendButtonY1 = functionSort_colY[i];//y + textMarginTop + 24 + (i * 24) - (sprite_get_height(spr_ascend) / 2);
	var ascendButtonX2 = ascendButtonX1 + sprite_get_width(spr_ascend);
	var ascendButtonY2 = ascendButtonY1 + sprite_get_height(spr_ascend);
	
	var colNameRectX1 = ascendButtonX2;
	var colNameRectY1 = ascendButtonY1;
	var colNameRectX2 = x + windowWidth;
	var colNameRectY2 = ascendButtonY2;
	
	var textX = x + windowWidth - textMarginLeft;
	var textY = mean(ascendButtonY1, ascendButtonY2);
	var colName = scr_getColNameString(selectedGrid, ds_grid_get(functionSort_sortGrid, functionSort_gridSortColGrid_colCol, i));
	var colAscend = ds_grid_get(functionSort_sortGrid, functionSort_gridSortColGrid_colAscend, i);
	var ascendButtonYScale = 1;
	
	if (not selectedGridHard)
	{
		if (point_in_rectangle(mouse_x, mouse_y, ascendButtonX1, ascendButtonY1, ascendButtonX2, ascendButtonY2))
		{
			draw_set_color(c_ltgray);
			draw_rectangle(ascendButtonX1, ascendButtonY1, ascendButtonX2, ascendButtonY2, true);
		
			if (mouse_check_button_pressed(mb_left))
			{
				colAscend = !colAscend;
				ds_grid_set(functionSort_sortGrid, functionSort_gridSortColGrid_colAscend, i, colAscend);
			}
		}
		else if (point_in_rectangle(mouse_x, mouse_y, colNameRectX1, colNameRectY1, colNameRectX2, colNameRectY2) and not instance_exists(obj_dropDown))
		{
			ds_grid_set_region(functionSort_sortGrid, functionSort_gridSortColGrid_colMouseover, 0, functionSort_gridSortColGrid_colMouseover, ds_grid_height(functionSort_sortGrid), false);
			ds_grid_set(functionSort_sortGrid, functionSort_gridSortColGrid_colMouseover, i, true);
			mouseoverAnyOption = true;
		}
		
		var mouseoverCurrentSortCol = ds_grid_get(functionSort_sortGrid, functionSort_gridSortColGrid_colMouseover, i);
		if (mouseoverCurrentSortCol)
		{
			draw_set_color(c_ltgray);
			draw_rectangle(colNameRectX1, colNameRectY1, colNameRectX2, colNameRectY2, false);
			
			if (mouse_check_button_pressed(mb_left) and point_in_rectangle(mouse_x, mouse_y, colNameRectX1, colNameRectY1, colNameRectX2, colNameRectY2))
			{
				var dropDownOptionList = ds_list_create();
				
				switch (selectedGrid)
				{
					case obj_control.lineGrid:
						ds_list_add(dropDownOptionList, "discoID", "unitStart", "unitEnd", "uID", "unitID");
						break;
					default:
						break;
				}
				
				if (ds_list_size(dropDownOptionList) > 0 and obj_control.ableToCreateDropDown)
				{
					var dropDownInst = instance_create_depth(mouse_x, mouse_y, -999, obj_dropDown);
					dropDownInst.optionList = dropDownOptionList;
					dropDownInst.optionListType = 0;
					
					obj_control.ableToCreateDropDown = false;
					obj_control.alarm[0] = 2;
				}
			}
		}
	}
	
	if (not colAscend)
	{
		ascendButtonYScale = -1;
	}
	
	draw_sprite_ext(spr_ascend, 0, mean(ascendButtonX1, ascendButtonX2), mean(ascendButtonY1, ascendButtonY2), 1, ascendButtonYScale, 0, c_dkgray, 1);
	
	draw_set_color(c_black);
	draw_text(textX, textY, colName);
	
	colSort[i, 0] = ds_grid_get(functionSort_sortGrid, functionSort_gridSortColGrid_colCol, i);
	colSort[i, 1] = ds_grid_get(functionSort_sortGrid, functionSort_gridSortColGrid_colAscend, i);
}

if (not mouseoverAnyOption and not instance_exists(obj_dropDown))
{
	while (ds_grid_value_exists(functionSort_sortGrid, functionSort_gridSortColGrid_colMouseover, 0, functionSort_gridSortColGrid_colMouseover, ds_grid_height(functionSort_sortGrid), true))
	{
		var rowInSortGrid = ds_grid_value_y(functionSort_sortGrid, functionSort_gridSortColGrid_colMouseover, 0, functionSort_gridSortColGrid_colMouseover, ds_grid_height(functionSort_sortGrid), true);
		ds_grid_set(functionSort_sortGrid, functionSort_gridSortColGrid_colMouseover, rowInSortGrid, false);
	}
}


var refreshButtonX1 = x + windowWidth - sprite_get_width(spr_refresh);
var refreshButtonY1 = y + windowHeight - sprite_get_height(spr_refresh);
var refreshButtonX2 = refreshButtonX1 + sprite_get_width(spr_refresh);
var refreshButtonY2 = refreshButtonY1 + sprite_get_height(spr_refresh);

draw_sprite_ext(spr_refresh, 0, mean(refreshButtonX1, refreshButtonX2), mean(refreshButtonY1, refreshButtonY2), 1, 1, 0, obj_control.c_ltblue, 1);

draw_set_alpha(0.5);
if (point_in_rectangle(mouse_x, mouse_y, refreshButtonX1, refreshButtonY1, refreshButtonX2, refreshButtonY2) and not selectedGridHard and not instance_exists(obj_dropDown))
{
	draw_set_alpha(1);
	
	if (mouse_check_button_pressed(mb_left))
	{
		functionSort_performSort = true;
	}
}

if (functionSort_performSort)
{
	functionSort_performSort = false;
	
	scr_gridMultiColSort(selectedGrid, colSort[0, 0], colSort[0, 1], colSort[1, 0], colSort[1, 1], colSort[2, 0], colSort[2, 1], colSort[3, 0], colSort[3, 1]);
	scr_refreshLineGridDisplayRow();
}

draw_set_color(c_black);
draw_rectangle(refreshButtonX1, refreshButtonY1, refreshButtonX2, refreshButtonY2, true);