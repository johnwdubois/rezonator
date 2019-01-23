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
	case functionChainList_tabTrackBrush:
		grid = obj_chain.trackChainGrid;
		break;
	case functionChainList_tabStackBrush:
		grid = obj_chain.stackChainGrid;
		break;
	case functionChainList_tabClique:
		grid = obj_chain.cliqueDisplayGrid;
		break;
	default:
		grid = obj_chain.rezChainGrid;
		break;
}

var filterRectMargin = 8;
var filterRectSize = 8;
if (functionChainList_currentTab == functionChainList_tabStackBrush)
{
	var textMarginLeft = 24;
}
else
{
	var textMarginLeft = 48;
}

var textMarginTop = 8;
var textPlusY = 0;
var chainNameRectMinusY = 4;

var scrollBarWidth = 16;
draw_set_color(c_white);
draw_rectangle(x + windowWidth - scrollBarWidth, y + (textMarginTop * 2), x + windowWidth, y + windowHeight, false);

draw_set_alpha(1);
draw_set_halign(fa_left);
draw_set_valign(fa_middle);
draw_set_color(c_black);
draw_set_font(fnt_chainList);

currentTopViewRow = max(0, currentTopViewRow);
currentTopViewRow = min(ds_grid_height(grid) - scrollRange, currentTopViewRow);

for (var i = currentTopViewRow; i < currentTopViewRow + scrollRange; i++)
{
	if (i < 0 or i > ds_grid_height(grid))
	{
		continue;
	}
	
	var currentChainState = ds_grid_get(grid, obj_chain.chainGrid_colChainState, i);
	var currentChainName = ds_grid_get(grid, obj_chain.chainGrid_colName, i);
	var currentChainColor = ds_grid_get(grid, obj_chain.chainGrid_colColor, i);
	
	textPlusY += string_height(currentChainName);
	
	var chainNameRectX1 = x + textMarginLeft;
	var chainNameRectY1 = y + textMarginTop + textPlusY - (string_height(currentChainName) / 2);
	var chainNameRectX2 = chainNameRectX1 + string_width(currentChainName);
	var chainNameRectY2 = chainNameRectY1 + string_height(currentChainName) - chainNameRectMinusY;
	
	/*
	if (currentChainState == obj_chain.chainStateFocus)
	{
		draw_set_color(obj_control.c_ltblue);
		draw_rectangle(chainNameRectX1, chainNameRectY1, chainNameRectX2, chainNameRectY2, false);
	}
	*/
	
	if (point_in_rectangle(mouse_x, mouse_y, chainNameRectX1, chainNameRectY1, chainNameRectX2, chainNameRectY2))
	{
		/*
		if (currentChainState != obj_chain.chainStateFocus)
		{
			draw_set_color(c_ltgray);
			draw_rectangle(chainNameRectX1, chainNameRectY1, chainNameRectX2, chainNameRectY2, false);
		}
		*/
		
		if (mouse_check_button_pressed(mb_left))
		{
			if (currentChainState == obj_chain.chainStateFocus)
			{
				currentChainState = obj_chain.chainStateNormal;
			}
			else//focuses on selected chain
			{
				switch (functionChainList_currentTab)
				{
					case functionChainList_tabRezBrush:
						obj_toolPane.currentTool = obj_toolPane.toolRezBrush;
						break;
					case functionChainList_tabTrackBrush:
						obj_toolPane.currentTool = obj_toolPane.toolTrackBrush;
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
				
				scr_setAllValuesInCol(obj_chain.linkGrid, obj_chain.linkGrid_colFocus, false);
				
				if (obj_chain.mouseLineWordID >= 0 and obj_chain.mouseLineWordID < ds_grid_height(obj_control.wordDrawGrid))
				{
					scr_setAllValuesInCol(obj_control.wordDrawGrid, obj_control.wordDrawGrid_colFillRect, false);
				}
				obj_chain.mouseLineWordID = -1;
			}
			
			with (obj_panelPane)
			{
				functionChainContents_scrollRangeMin[functionChainList_currentTab] = 0;
				functionChainContents_scrollRangeMax[functionChainList_currentTab] = functionChainContents_maxScrollRange;
			}
		}
	}
	
	//Color codes the chain lists for User
	var chainColor = ds_grid_get(grid, obj_chain.chainGrid_colColor, i); //access color of new chain
	var rectX1 = x + textMarginLeft - 2;
	var rectX2 = x + textMarginLeft + 50;
	if (currentChainState == obj_chain.chainStateFocus)
	{
		rectX1 = x;
	}
	draw_set_color(merge_color(chainColor, c_white, 0.65)); //soften the color
	draw_rectangle(rectX1, y + textMarginTop + textPlusY - 9, rectX2, y + textMarginTop + textPlusY + 7, false);
	if (currentChainState == obj_chain.chainStateFocus)
	{
		draw_set_color(c_black);
		draw_rectangle(rectX1, y + textMarginTop + textPlusY - 9, rectX2, y + textMarginTop + textPlusY + 7, true);
	}
	//unsure if this solution can scale with different resolutions
	
	draw_set_color(c_black);
	draw_text(x + textMarginLeft, y + textMarginTop + textPlusY, currentChainName);
	/*
	draw_set_color(currentChainColor);
	draw_circle(x + textMarginLeft + string_width(currentChainName) + 10, y + textMarginTop + textPlusY - 2, 5, false);
	draw_set_color(c_black);*/
	
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
			
			if (obj_control.filterGridActive)
			{
				with (obj_control)
				{
					scr_renderFilter();
				}
			}
		}
	}
	
	if (functionChainList_currentTab == functionChainList_tabRezBrush
	or functionChainList_currentTab == functionChainList_tabTrackBrush)
	{
		draw_set_alpha(1);
		draw_set_color(c_purple);
		
		var chainAlignRectX1 = x + (filterRectMargin * 2) + filterRectSize;
		var chainAlignRectY1 = y + textMarginTop + textPlusY - (filterRectSize / 2);
		var chainAlignRectX2 = chainAlignRectX1 + filterRectSize;
		var chainAlignRectY2 = chainAlignRectY1 + filterRectSize;
		var isAligned = ds_grid_get(grid, obj_chain.chainGrid_colAlign, i);
	
		if (isAligned)
		{
			draw_rectangle(chainAlignRectX1, chainAlignRectY1, chainAlignRectX2, chainAlignRectY2, false);
		}
		else if (isAligned == -1)
		{
			draw_set_alpha(0.5);
			draw_rectangle(chainAlignRectX1, chainAlignRectY1, chainAlignRectX2, chainAlignRectY2, false);
		}
		else
		{
			draw_set_alpha(1);
			draw_rectangle(chainAlignRectX1, chainAlignRectY1, chainAlignRectX2, chainAlignRectY2, true);
		}
		
		draw_set_alpha(1);
	
		if (point_in_rectangle(mouse_x, mouse_y, chainAlignRectX1, chainAlignRectY1, chainAlignRectX2, chainAlignRectY2))
		{
			if (mouse_check_button_pressed(mb_left))
			{
				
				
				if (functionChainList_currentTab == functionChainList_tabTrackBrush and not isAligned)
				{
					scr_setAllValuesInCol(obj_chain.trackChainGrid, obj_chain.chainGrid_colAlign, false);
				}
				
				ds_grid_set(grid, obj_chain.chainGrid_colAlign, i, !isAligned);
				
				/*
				var wordIDList = ds_grid_get(grid, obj_chain.chainGrid_colWordIDList, i);
				for (var k = 0; k < ds_list_size(wordIDList); k++)
				{
					var currentWordID = ds_list_find_value(wordIDList, k);
					ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colAligned, currentWordID - 1, isAligned);
				}
				*/
			}
		}
	}
}

var scrollBarHeight = ((scrollRange * windowHeight) / ds_grid_height(grid));
var scrollBarRectX1 = x + windowWidth - scrollBarWidth;
var scrollBarRectY1 = y + ((currentTopViewRow * windowHeight) / ds_grid_height(grid));
var scrollBarRectX2 = scrollBarRectX1 + scrollBarWidth;
var scrollBarRectY2 = scrollBarRectY1 + scrollBarHeight;

scrollBarRectY1 = max(scrollBarRectY1, y + (textMarginTop * 2));
scrollBarRectY2 = max(scrollBarRectY2, y + (textMarginTop * 2));

if (ds_grid_height(grid) == 0)
{
	scrollBarRectY1 = y + (textMarginTop * 2);
	scrollBarRectY2 = y + windowHeight;
	scrollBarHolding = false;
}

draw_set_color(c_ltgray);
draw_rectangle(scrollBarRectX1, scrollBarRectY1, scrollBarRectX2, scrollBarRectY2, false);

if (point_in_rectangle(mouse_x, mouse_y, scrollBarRectX1, scrollBarRectY1, scrollBarRectX2, scrollBarRectY2))
{
	if (mouse_check_button_pressed(mb_left))
	{
		scrollBarHolding = true;
		scrollBarHoldingPlusY = mouse_y - scrollBarRectY1;
	}
}

scrollBarHoldingPlusY = 0;

if (mouse_check_button_released(mb_left))
{
	scrollBarHolding = false;
}

if (scrollBarHolding)
{
	currentTopViewRow = floor(((mouse_y - y - scrollBarHoldingPlusY) * ds_grid_height(grid)) / (windowHeight));
}

if(obj_panelPane.clickedIn) {
	if ((mouse_wheel_up() || keyboard_check(vk_up)))
	{
		if (currentTopViewRow > 0)
		{
			currentTopViewRow--;
			
		}
	}
	if (keyboard_check_pressed(vk_pageup)){//added pageUp/pageDown functionality to gridView
		if (currentTopViewRow > 0){
			currentTopViewRow -= scrollRange;
		}
	}
	if (keyboard_check(vk_control) and keyboard_check_pressed(vk_up))
	{//added pageUp/pageDown functionality to gridView
		if (currentTopViewRow > 0)
		{
			currentTopViewRow -= ds_grid_height(grid);
		}
	}
}
if(obj_panelPane.clickedIn) {
	if ((mouse_wheel_down() || keyboard_check(vk_down))){
		if (currentTopViewRow + scrollRange < ds_grid_height(grid)){
			currentTopViewRow++;
			
		}
	}
	if (keyboard_check_pressed(vk_pagedown)){
		if (currentTopViewRow + scrollRange < ds_grid_height(grid)){
			currentTopViewRow += scrollRange;
		}
	}
	if (keyboard_check(vk_control) and keyboard_check_pressed(vk_down))
	{
		
		if (currentTopViewRow + scrollRange < ds_grid_height(grid))
		{
			currentTopViewRow += ds_grid_height(grid);
		}
	}
}