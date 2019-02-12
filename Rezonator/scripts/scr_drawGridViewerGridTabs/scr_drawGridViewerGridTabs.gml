/*
	scr_drawGridViewerGridTabs(gridArrayIndex);
	
	Last Updated: 2018-09-11
	
	Called from: obj_gridViewer
	
	Purpose: draw the tabs showing all of the viewable grids for the gridViewer
	
	Mechanism: loop through a list of the viewable grids and draw tabs for each grid,
				and when the tab is clicked on, that is the grid to be shown
	
	Author: Terry DuBois
*/

var gridArrayIndex = argument0;

draw_set_alpha(1);
draw_set_halign(fa_left);
draw_set_valign(fa_middle);
draw_set_font(fnt_debug);

var rectWidth = windowWidth[gridArrayIndex] / ds_list_size(gridList);
var rectHeight = 20;

for (var i = 0; i < ds_list_size(gridList); i++)
{
	var currentGrid = ds_list_find_value(gridList, i);
	
	var rectX1 = windowX[gridArrayIndex] + (i * rectWidth);
	var rectY1 = windowY[gridArrayIndex] - rectHeight;
	var rectX2 = rectX1 + rectWidth;
	var rectY2 = windowY[gridArrayIndex];
	
	if (grid[gridArrayIndex] == currentGrid)
	{
		draw_set_color(obj_control.c_ltblue);
	}
	else
	{
		draw_set_color(global.colorThemeBG);
	}
	
	draw_rectangle(rectX1, rectY1, rectX2, rectY2, false);
	
	draw_set_color(global.colorThemeText);
	draw_rectangle(rectX1, rectY1, rectX2, rectY2, true);
	
	var colName = "";
	
	switch (currentGrid)
	{
		case obj_control.unitGrid:
			colName = "unitGrid";
			break;
		case obj_control.lineGrid:
			colName = "lineGrid";
			break;
		case obj_control.wordGrid:
			colName = "wordGrid";
			break;
		case obj_control.dynamicWordGrid:
			colName = "dynamicWordGrid";
			break;
		case obj_control.filterGrid:
			colName = "filterGrid";
			break;
		case obj_control.searchGrid:
			colName = "searchGrid";
			break;
		case obj_control.hitGrid:
			colName = "hitGrid";
			break;
		case obj_chain.linkGrid:
			colName = "linkGrid";
			break;
		case obj_chain.vizLinkGrid:
			colName = "vizLinkGrid";
			break;
		case obj_chain.rezChainGrid:
			colName = "rezChainGrid";
			break;
		case obj_chain.trackChainGrid:
			colName = "trackChainGrid";
			break;
		case obj_chain.stackChainGrid:
			colName = "stackChainGrid";
			break;
		case obj_chain.unitInStackGrid:
			colName = "unitInStackGrid";
			break;
		case obj_chain.cliqueGrid:
			colName = "cliqueGrid";
			break;
		case obj_chain.cliqueDisplayGrid:
			colName = "cliqueDisplayGrid";
			break;
		default:
			break;
	}
	
	draw_text(rectX1 + 5, mean(rectY1, rectY2), colName);
	
	if (point_in_rectangle(mouse_x, mouse_y, rectX1, rectY1, rectX2, rectY2))
	{
		if (mouse_check_button_pressed(mb_left))
		{
			grid[gridArrayIndex] = currentGrid;
		}
	}
}