/*
	scr_panelPane_drawchainContentsLoop();
	
	Last Updated: 2018-07-12
	
	Called from: obj_panelPane
	
	Purpose: whatever chain is focused on in the chainList panelPane, draw information on the individual contents of that chain
	
	Mechanism: loop through the IDList of the focused chain and gather information from corresponding grids
*/

draw_set_alpha(1);
draw_set_halign(fa_left);
draw_set_valign(fa_middle);
draw_set_font(fnt_chainContents);


var grid = obj_chain.rezChainGrid;

switch (functionChainList_currentTab)
{
	case 0:
		grid = obj_chain.rezChainGrid;
		break;
	case 1:
		grid = obj_chain.trackChainGrid;
		break;
	case 2:
		grid = obj_chain.stackChainGrid;
		break;
	default:
		grid = obj_chain.rezChainGrid;
		break;
}

var textMarginTop = 32;
var textPlusY = 0;
var ableToBeMouseOver = true;

var scrollBarWidth = 16;
draw_set_color(c_white);
draw_rectangle(x + windowWidth - scrollBarWidth, y + (textMarginTop * 2), x + windowWidth, y + windowHeight, false);

var focusedChainExists = false;

if (ds_grid_value_exists(grid, obj_chain.chainGrid_colChainState, 0, obj_chain.chainGrid_colChainState, ds_grid_height(grid), obj_chain.chainStateFocus))
{
	focusedChainExists = true;
	var rowInChainGrid = ds_grid_value_y(grid, obj_chain.chainGrid_colChainState, 0, obj_chain.chainGrid_colChainState, ds_grid_height(grid), obj_chain.chainStateFocus);
	var chainID = ds_grid_get(grid, obj_chain.chainGrid_colChainID, rowInChainGrid);
	with (obj_panelPane)
	{
		functionChainContents_IDList = ds_grid_get(grid, obj_chain.chainGrid_colWordIDList, rowInChainGrid);
	}
	
	if (functionChainContents_hop > -1)
	{
		if (ds_list_find_index(functionChainContents_IDList, functionChainContents_hop) > -1)
		{
			currentTopViewRow = ds_list_find_index(functionChainContents_IDList, functionChainContents_hop);//functionChainContents_hop;
		}
		
		functionChainContents_hop = -1;
	}
	
	currentTopViewRow = max(0, currentTopViewRow);
	currentTopViewRow = min(ds_list_size(functionChainContents_IDList) - scrollRange, currentTopViewRow);
	
	for (var j = currentTopViewRow; j < currentTopViewRow + scrollRange; j++)
	{	
		if (j < 0 or j >= ds_list_size(functionChainContents_IDList))
		{
			continue;
		}
		
		var currentWordID = ds_list_find_value(functionChainContents_IDList, j);
		var currentWordInfoCol;
		currentWordInfoCol[0] = "";
		
		var stringHeight = 14;
		var rectX1 = x;
		var rectY1 = y + textMarginTop + textPlusY - (stringHeight / 2);
		var rectX2 = x + windowWidth - scrollBarWidth;
		var rectY2 = rectY1 + stringHeight;
		
		var rowInLinkGrid = scr_findInGridThreeParameters(obj_chain.linkGrid, obj_chain.linkGrid_colSource, currentWordID, obj_chain.linkGrid_colChainID, chainID, obj_chain.linkGrid_colDead, false);
		var focusedLink = ds_grid_get(obj_chain.linkGrid, obj_chain.linkGrid_colFocus, rowInLinkGrid);
		var sourceWordID = ds_grid_get(obj_chain.linkGrid, obj_chain.linkGrid_colSource, rowInLinkGrid);
			
		if (focusedLink)
		{
			draw_set_color(c_ltgray);
			draw_rectangle(rectX1, rectY1, rectX2, rectY2, false);
			
			if (grid == obj_chain.rezChainGrid or grid == obj_chain.trackChainGrid)
			{
				ds_grid_set_region(obj_control.wordDrawGrid, obj_control.wordDrawGrid_colFillRect, 0, obj_control.wordDrawGrid_colFillRect, ds_grid_height(obj_control.wordDrawGrid), false);
				ds_grid_set(obj_control.wordDrawGrid, obj_control.wordDrawGrid_colFillRect, sourceWordID - 1, true);
				obj_chain.mouseLineWordID = sourceWordID;
			}
		}
		else if (point_in_rectangle(mouse_x, mouse_y, rectX1, rectY1, rectX2, rectY2) and ableToBeMouseOver)
		{
			ableToBeMouseOver = false;
			draw_set_color(c_ltgray);
			draw_rectangle(rectX1, rectY1, rectX2, rectY2, false);
			
			if (mouse_check_button_pressed(mb_left))
			{	
				ds_grid_set_region(obj_chain.linkGrid, obj_chain.linkGrid_colFocus, 0, obj_chain.linkGrid_colFocus, ds_grid_height(obj_chain.linkGrid), false);
				ds_grid_set(obj_chain.linkGrid, obj_chain.linkGrid_colFocus, rowInLinkGrid, true);
				scr_refreshChainGrid();
			}
		}
		
		for (var getInfoLoop = 0; getInfoLoop < 3; getInfoLoop++)
		{
			currentWordInfoCol[getInfoLoop] = "";
			
			switch (functionChainContents_infoCol[getInfoLoop])
			{
				// 0 --> wordID
				// 1 --> unitID
				// 2 --> wordTranscript
				case 0:
					if (functionChainList_currentTab == functionChainList_tabStackBrush)
					{
						currentWordInfoCol[getInfoLoop] = string(currentWordID);
					}
					else
					{
						currentWordInfoCol[getInfoLoop] = string(ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colUnitID, currentWordID - 1));
					}
					break;
				case 1:
					if (functionChainList_currentTab == functionChainList_tabStackBrush)
					{
						currentWordInfoCol[getInfoLoop] = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colParticipantName, currentWordID);
					}
					else
					{
						currentWordInfoCol[getInfoLoop] = string(ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colWordSeq, currentWordID - 1));
					}
					break;
				case 2:
					if (functionChainList_currentTab == functionChainList_tabStackBrush)
					{
						currentWordInfoCol[getInfoLoop] = "";
						var currentWordIDList = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colWordIDList, currentWordID - 1);
						for (var i = 0; i < ds_list_size(currentWordIDList); i++)
						{
							var currentWordID = ds_list_find_value(currentWordIDList, i);
							var currentWordString = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colWordToken, currentWordID - 1);
							currentWordInfoCol[getInfoLoop] += currentWordString + " ";
						}
						
						if (string_length(currentWordInfoCol[getInfoLoop]) > 16)
						{
							currentWordInfoCol[getInfoLoop] = string_delete(currentWordInfoCol[getInfoLoop], 12, string_length(currentWordInfoCol[getInfoLoop]) - 12);
							currentWordInfoCol[getInfoLoop] += "...";
						}
					}
					else
					{
						currentWordInfoCol[getInfoLoop] = string(ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colWordTranscript, currentWordID - 1));
					}
					break;
				default:
					currentWordInfoCol[getInfoLoop] = string(currentWordID);
					break;
			}
			
			var textX = x + (getInfoLoop * (windowWidth / 3));
			var textY = y + textMarginTop + textPlusY;
			
			draw_set_color(c_black);
			draw_text(textX, textY, currentWordInfoCol[getInfoLoop]);
		}
		
		textPlusY += string_height(currentWordInfoCol[0]) * 0.75;
	}
}


draw_set_font(fnt_panelTab);
var tabHeight = 16;

for (var i = 0; i < 3; i++)
{
	var colRectX1 = x + (i * (windowWidth / 3));
	var colRectY1 = y;
	var colRectX2 = colRectX1 + (windowWidth / 3);
	var colRectY2 = colRectY1 + windowHeight;
	
	var colName = "";
	
	switch (functionChainContents_infoCol[i])
	{
		// 0 --> wordID
		// 1 --> unitID
		// 2 --> wordTranscript
		case 0:
			if (functionChainList_currentTab == functionChainList_tabStackBrush)
			{
				colName = "unitID";
			}
			else
			{
				colName = "unitID";
			}
			break;
		case 1:
			if (functionChainList_currentTab == functionChainList_tabStackBrush)
			{
				colName = "speaker"
			}
			else
			{
				colName = "place";
			}
			break;
		case 2:
			if (functionChainList_currentTab == functionChainList_tabStackBrush)
			{
				colName = "utterance";
			}
			else
			{
				colName = "text";
			}
			break;
		default:
			colName = "";
			break;
	}
	
	draw_set_color(c_black);
	draw_rectangle(colRectX1, colRectY1, colRectX2, colRectY2, true);
	draw_line(x, y + tabHeight, x + windowWidth, y + tabHeight);
	draw_text(colRectX1, y + (tabHeight / 2), colName);
}


var scrollBarHeight = ((scrollRange * windowHeight) / ds_list_size(functionChainContents_IDList));
var scrollBarRectX1 = x + windowWidth - scrollBarWidth;
var scrollBarRectY1 = y + ((currentTopViewRow * windowHeight) / ds_list_size(functionChainContents_IDList));
var scrollBarRectX2 = scrollBarRectX1 + scrollBarWidth;
var scrollBarRectY2 = scrollBarRectY1 + scrollBarHeight;

scrollBarRectY1 = max(scrollBarRectY1, y + (textMarginTop / 2));
scrollBarRectY2 = max(scrollBarRectY2, y + (textMarginTop / 2));

if (ds_list_size(functionChainContents_IDList) == 0 or not focusedChainExists)
{
	scrollBarRectY1 = y + (textMarginTop / 2);
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
	currentTopViewRow = floor(((mouse_y - y - scrollBarHoldingPlusY) * ds_list_size(functionChainContents_IDList)) / (windowHeight));
}