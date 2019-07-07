/*
	scr_panelPane_drawSort();
	
	Last Updated: 2018-07-12
	
	Called from: obj_panelPane
	
	Purpose: whatever chain is focused on in the chainList panelPane, draw information on the individual contents of that chain
	
	Mechanism: loop through the IDList of the focused chain and gather information from corresponding grids
	
	Author: Terry DuBois
*/

draw_set_alpha(1);
draw_set_halign(fa_left);
draw_set_valign(fa_middle);
draw_set_color(global.colorThemeText);

var textMarginLeft = 12;
var textMarginTop = 20;

draw_set_font(global.fontSortPane);

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
		draw_set_color(global.colorThemeSelected1);
		draw_rectangle(gridNameRectX1, gridNameRectY1, gridNameRectX2, gridNameRectY2, false);
		
		if (mouse_check_button_pressed(mb_left))
		{
			functionSort_gridGridSelected = i;
		}
	}
	
	draw_set_alpha(1);
	draw_set_color(global.colorThemeText);
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
	draw_set_color(global.colorThemeSelected1);
	draw_rectangle(x + (windowWidth / 3), y + textMarginTop + 12, x + windowWidth, y + windowHeight, false);
}
draw_set_color(global.colorThemeText);
draw_line(x + (windowWidth / 3), y, x + (windowWidth) / 3, y + windowHeight);
draw_line(x + (windowWidth / 3), y + textMarginTop + 12, x + windowWidth, y + textMarginTop + 12);

draw_set_color(global.colorThemeText);
draw_set_font(fnt_sortPaneBold);
draw_text(x + (windowWidth / 3) + textMarginLeft, y + textMarginTop, selectedGridName + " sort order");


draw_set_font(global.fontSortPane);
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
			draw_set_color(global.colorThemeSelected1);
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
			draw_set_color(global.colorThemeSelected1);
			draw_rectangle(colNameRectX1, colNameRectY1, colNameRectX2, colNameRectY2, false);
			
			if (mouse_check_button_pressed(mb_left) and point_in_rectangle(mouse_x, mouse_y, colNameRectX1, colNameRectY1, colNameRectX2, colNameRectY2))
			{
				var dropDownOptionList = ds_list_create();
				
				switch (selectedGrid)
				{
					case obj_control.lineGrid:
						ds_list_add(dropDownOptionList, "discoID", "unitStart", "unitEnd", "uID", "unitID");
						break;
					case obj_control.searchGrid:
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
	
	if (functionSort_animationSeq == i)
	{
		draw_set_color(obj_control.c_ltblue);
		draw_set_alpha(max(functionSort_animationAlpha, 0));
		draw_rectangle(colNameRectX1, colNameRectY1, colNameRectX2, colNameRectY2, false);
		
		if (functionSort_animationAlpha > 0)
		{
			functionSort_animationAlpha -= 0.2;
		}
		else
		{
			if (functionSort_animationSeq < ds_grid_height(functionSort_sortGrid) - 1)
			{
				functionSort_animationSeq++;
				functionSort_animationAlpha = 1;
			}
			else
			{
				functionSort_animationSeq = -1;
				functionSort_animationAlpha = 1;
			}
		}
	}
	
	draw_set_alpha(1);
	
	if (not colAscend)
	{
		ascendButtonYScale = -1;
	}
	
	draw_sprite_ext(spr_ascend, 0, mean(ascendButtonX1, ascendButtonX2), mean(ascendButtonY1, ascendButtonY2), 1, ascendButtonYScale, 0, global.colorThemeSelected2, 1);
	
	draw_set_color(global.colorThemeText);
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


var refreshButtonAlpha = 0;
var refreshButtonX1 = x + windowWidth - sprite_get_width(spr_refresh);
var refreshButtonY1 = y + windowHeight - sprite_get_height(spr_refresh);
var refreshButtonX2 = refreshButtonX1 + sprite_get_width(spr_refresh);
var refreshButtonY2 = refreshButtonY1 + sprite_get_height(spr_refresh);

var restoreDefButtonAlpha = 0;
var restoreDefButtonX1 = ascendButtonX1;
var restoreDefButtonY1 = refreshButtonY1;
var restoreDefButtonX2 = refreshButtonX1;
var restoreDefButtonY2 = refreshButtonY2;

draw_set_alpha(1);
draw_set_color(global.colorThemeText);
draw_set_halign(fa_left);
draw_text(restoreDefButtonX1 + 10, mean(restoreDefButtonY1, restoreDefButtonY2), "Restore default");

draw_set_color(global.colorThemeBG);
draw_rectangle(refreshButtonX1, refreshButtonY1, refreshButtonX2, refreshButtonY2, false);
draw_sprite_ext(spr_refresh, 0, mean(refreshButtonX1, refreshButtonX2), mean(refreshButtonY1, refreshButtonY2), 1, 1, 0, obj_control.c_ltblue, 1);

if (point_in_rectangle(mouse_x, mouse_y, refreshButtonX1, refreshButtonY1, refreshButtonX2, refreshButtonY2) and not selectedGridHard and not instance_exists(obj_dropDown))
{
	refreshButtonAlpha = 0.25;
	
	if (mouse_check_button_pressed(mb_left))
	{
		functionSort_performSort = true;
	}
}
else if (point_in_rectangle(mouse_x, mouse_y, restoreDefButtonX1, restoreDefButtonY1, restoreDefButtonX2, restoreDefButtonY2) and not selectedGridHard and not instance_exists(obj_dropDown))
{
	restoreDefButtonAlpha = 0.25;
	
	if (mouse_check_button_pressed(mb_left))
	{
		scr_panelPane_sortDefaultSetup();
		
		alarm[2] = 1;
	}
}



if (functionSort_performSort)
{
	functionSort_performSort = false;
	
	scr_gridMultiColSort(selectedGrid, colSort[0, 0], colSort[0, 1], colSort[1, 0], colSort[1, 1], colSort[2, 0], colSort[2, 1], colSort[3, 0], colSort[3, 1]);
	
	switch (selectedGrid)
	{
		case obj_control.lineGrid:
			scr_refreshLineGridDisplayRow(obj_control.lineGrid);
			break;
		case obj_control.searchGrid:
			scr_refreshLineGridDisplayRow(obj_control.searchGrid);
			break;
		default:
			break;
	}
	
	functionSort_animationSeq = 0;
	functionSort_animationAlpha = 1;
}

draw_set_color(global.colorThemeBorders);
draw_set_alpha(1);
draw_rectangle(refreshButtonX1, refreshButtonY1, refreshButtonX2, refreshButtonY2, true);
if (refreshButtonAlpha > 0)
{
	draw_set_alpha(refreshButtonAlpha);
	draw_rectangle(refreshButtonX1, refreshButtonY1, refreshButtonX2, refreshButtonY2, false);
}

draw_set_color(global.colorThemeBorders);
draw_set_alpha(1);
draw_rectangle(restoreDefButtonX1, restoreDefButtonY1, restoreDefButtonX2, restoreDefButtonY2, true);
if (restoreDefButtonAlpha > 0)
{
	draw_set_alpha(restoreDefButtonAlpha);
	draw_rectangle(restoreDefButtonX1, restoreDefButtonY1, restoreDefButtonX2, restoreDefButtonY2, false);
}



//check to see if lineGrid has default sort
var lineGridSortGrid = ds_grid_get(functionSort_gridGrid, functionSort_gridGrid_colSortGrid, 0);
if (ds_grid_get(lineGridSortGrid, functionSort_gridSortColGrid_colCol, 0) != obj_control.lineGrid_colDiscoID
or ds_grid_get(lineGridSortGrid, functionSort_gridSortColGrid_colCol, 1) != obj_control.lineGrid_colUnitStart
or ds_grid_get(lineGridSortGrid, functionSort_gridSortColGrid_colCol, 2) != obj_control.lineGrid_colUnitEnd
or ds_grid_get(lineGridSortGrid, functionSort_gridSortColGrid_colCol, 3) != obj_control.lineGrid_colLineNumberLabel)
{
	obj_control.lineGridDefaultSort = false;
	
	while (ds_grid_value_exists(obj_chain.rezChainGrid, obj_chain.chainGrid_colAlign, 0, obj_chain.chainGrid_colAlign, ds_grid_height(obj_chain.rezChainGrid), true))
	{
		var rowToChange = ds_grid_value_y(obj_chain.rezChainGrid, obj_chain.chainGrid_colAlign, 0, obj_chain.chainGrid_colAlign, ds_grid_height(obj_chain.rezChainGrid), true);
		if(rowToChange >= 0){
			ds_grid_set(obj_chain.rezChainGrid, obj_chain.chainGrid_colAlign, rowToChange, -1);
		}
	}
	while (ds_grid_value_exists(obj_chain.trackChainGrid, obj_chain.chainGrid_colAlign, 0, obj_chain.chainGrid_colAlign, ds_grid_height(obj_chain.trackChainGrid), true))
	{
		var rowToChange = ds_grid_value_y(obj_chain.rezChainGrid, obj_chain.chainGrid_colAlign, 0, obj_chain.chainGrid_colAlign, ds_grid_height(obj_chain.trackChainGrid), true);
		if(rowToChange >= 0){
			ds_grid_set(obj_chain.trackChainGrid, obj_chain.chainGrid_colAlign, rowToChange, -1);
		}
	}
}
else
{
	obj_control.lineGridDefaultSort = true;
	
	while (ds_grid_value_exists(obj_chain.rezChainGrid, obj_chain.chainGrid_colAlign, 0, obj_chain.chainGrid_colAlign, ds_grid_height(obj_chain.rezChainGrid), -1))
	{
		var rowToChange = ds_grid_value_y(obj_chain.rezChainGrid, obj_chain.chainGrid_colAlign, 0, obj_chain.chainGrid_colAlign, ds_grid_height(obj_chain.rezChainGrid), -1);
		if(rowToChange >= 0){
			ds_grid_set(obj_chain.rezChainGrid, obj_chain.chainGrid_colAlign, rowToChange, true);
		}
	}
	while (ds_grid_value_exists(obj_chain.trackChainGrid, obj_chain.chainGrid_colAlign, 0, obj_chain.chainGrid_colAlign, ds_grid_height(obj_chain.trackChainGrid), -1))
	{
		var rowToChange = ds_grid_value_y(obj_chain.rezChainGrid, obj_chain.chainGrid_colAlign, 0, obj_chain.chainGrid_colAlign, ds_grid_height(obj_chain.trackChainGrid), -1);
		if(rowToChange >= 0){
			ds_grid_set(obj_chain.trackChainGrid, obj_chain.chainGrid_colAlign, rowToChange, true);
		}
	}
}