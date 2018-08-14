/*
	scr_panelPane_drawChainListLoop();
	
	Last Updated: 2018-07-12
	
	Called from: obj_panelPane
	
	Purpose: draw the chains for whatever tab you are on, if a user clicks on a chain then focus it and
			set chainContents panelPane to look at that chain
	
	Mechanism: loop through chainGrid of whatever tab you are on and draw chainName
*/

var grid = obj_chain.rezChainGrid;

switch (functionChainList_currentTab)
{
	case functionChainList_tabRezBrush:
		grid = obj_chain.rezChainGrid;
		break;
	case functionChainList_tabAnaphBrush:
		grid = obj_chain.anaphChainGrid;
		break;
	case functionChainList_tabStackBrush:
		grid = obj_chain.stackChainGrid;
		break;
	default:
		grid = obj_chain.rezChainGrid;
		break;
}

var filterRectMargin = 8;
var filterRectSize = 8;
var textMarginLeft = 24;
var textMarginTop = 8;
var textPlusY = 0;
var chainNameRectMinusY = 4;

draw_set_alpha(1);
draw_set_halign(fa_left);
draw_set_valign(fa_middle);
draw_set_font(fnt_chainList);

for (var i = 0; i < ds_grid_height(grid); i++)
{
	if (i < functionChainList_scrollRangeMin[functionChainList_currentTab] or i > functionChainList_scrollRangeMax[functionChainList_currentTab])
	{
		continue;
	}
	
	var currentChainName = ds_grid_get(grid, obj_chain.chainGrid_colName, i);
	var currentChainState = ds_grid_get(grid, obj_chain.chainGrid_colChainState, i);
	
	textPlusY += string_height(currentChainName);
	
	var chainNameRectX1 = x + textMarginLeft;
	var chainNameRectY1 = y + textMarginTop + textPlusY - (string_height(currentChainName) / 2);
	var chainNameRectX2 = chainNameRectX1 + string_width(currentChainName);
	var chainNameRectY2 = chainNameRectY1 + string_height(currentChainName) - chainNameRectMinusY;
	
	if (currentChainState == obj_chain.chainStateFocus)
	{
		draw_set_color(obj_control.c_ltblue);
		draw_rectangle(chainNameRectX1, chainNameRectY1, chainNameRectX2, chainNameRectY2, false);
	}
	
	if (point_in_rectangle(mouse_x, mouse_y, chainNameRectX1, chainNameRectY1, chainNameRectX2, chainNameRectY2))
	{
		if (currentChainState != obj_chain.chainStateFocus)
		{
			draw_set_color(c_ltgray);
			draw_rectangle(chainNameRectX1, chainNameRectY1, chainNameRectX2, chainNameRectY2, false);
		}
		
		if (mouse_check_button_pressed(mb_left))
		{
			if (currentChainState == obj_chain.chainStateFocus)
			{
				currentChainState = obj_chain.chainStateNormal;
			}
			else
			{
				switch (functionChainList_currentTab)
				{
					case functionChainList_tabRezBrush:
						obj_toolPane.currentTool = obj_toolPane.toolRezBrush;
						break;
					case functionChainList_tabAnaphBrush:
						obj_toolPane.currentTool = obj_toolPane.toolAnaphBrush;
						break;
					case functionChainList_tabStackBrush:
						obj_toolPane.currentTool = obj_toolPane.toolStackBrush;
						break;
					default:
						break;
				}
				
				for (var j = 0; j < ds_grid_height(grid); j++)
				{
					if (ds_grid_get(grid, obj_chain.chainGrid_colChainState, j) == obj_chain.chainStateFocus)
					{
						ds_grid_set(grid, obj_chain.chainGrid_colChainState, j, obj_chain.chainStateNormal);
					}
				}
				
				ds_grid_set(grid, obj_chain.chainGrid_colChainState, i, obj_chain.chainStateFocus);
			}
			
			with (obj_panelPane)
			{
				functionChainContents_scrollRangeMin[functionChainList_currentTab] = 0;
				functionChainContents_scrollRangeMax[functionChainList_currentTab] = functionChainContents_maxScrollRange;
			}
		}
	}
	
	draw_set_color(c_black);
	draw_text(x + textMarginLeft, y + textMarginTop + textPlusY, currentChainName);
	
	var chainFilterRectX1 = x + filterRectMargin;
	var chainFilterRectY1 = y + textMarginTop + textPlusY - (filterRectSize / 2);
	var chainFilterRectX2 = chainFilterRectX1 + filterRectSize;
	var chainFilterRectY2 = chainFilterRectY1 + filterRectSize;
	var inFilter = ds_grid_get(grid, obj_chain.chainGrid_colInFilter, i);
	
	if (inFilter)
	{
		draw_rectangle(chainFilterRectX1, chainFilterRectY1, chainFilterRectX2, chainFilterRectY2, false);
	}
	else
	{
		draw_rectangle(chainFilterRectX1, chainFilterRectY1, chainFilterRectX2, chainFilterRectY2, true);
	}
	
	if (point_in_rectangle(mouse_x, mouse_y, chainFilterRectX1, chainFilterRectY1, chainFilterRectX2, chainFilterRectY2))
	{
		if (mouse_check_button_pressed(mb_left))
		{
			ds_grid_set(grid, obj_chain.chainGrid_colInFilter, i, !inFilter);
		}
	}
}