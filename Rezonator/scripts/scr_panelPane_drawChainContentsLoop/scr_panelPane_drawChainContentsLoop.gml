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
		grid = obj_chain.anaphChainGrid;
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

if (ds_grid_value_exists(grid, obj_chain.chainGrid_colChainState, 0, obj_chain.chainGrid_colChainState, ds_grid_height(grid), obj_chain.chainStateFocus))
{
	var rowInChainGrid = ds_grid_value_y(grid, obj_chain.chainGrid_colChainState, 0, obj_chain.chainGrid_colChainState, ds_grid_height(grid), obj_chain.chainStateFocus);
	functionChainContents_IDList = ds_grid_get(grid, obj_chain.chainGrid_colWordIDList, rowInChainGrid);
	
	for (var j = functionChainContents_scrollRangeMin[functionChainList_currentTab]; j < functionChainContents_scrollRangeMax[functionChainList_currentTab]; j++)
	{	
		if (j < 0 or j >= ds_list_size(functionChainContents_IDList))
		{
			continue;
		}
		
		var currentWordID = ds_list_find_value(functionChainContents_IDList, j);
		var currentWordInfoCol;
		currentWordInfoCol[0] = "";
		
		for (var getInfoLoop = 0; getInfoLoop < 3; getInfoLoop++)
		{
			currentWordInfoCol[getInfoLoop] = "";
			
			switch (functionChainContents_infoCol[getInfoLoop])
			{
				// 0 --> wordID
				// 1 --> unitID
				// 2 --> wordTranscript
				case 0:
					currentWordInfoCol[getInfoLoop] = string(currentWordID);
					break;
				case 1:
					if (functionChainList_currentTab == functionChainList_tabStackBrush)
					{
						currentWordInfoCol[getInfoLoop] = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colParticipantName, currentWordID);
					}
					else
					{
						currentWordInfoCol[getInfoLoop] = string(ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colUnitID, currentWordID - 1));
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
			draw_text(textX, textY, currentWordInfoCol[getInfoLoop]);
		}
		
		textPlusY += string_height(currentWordInfoCol[0]);
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
				colName = "wordID";
			}
			break;
		case 1:
			if (functionChainList_currentTab == functionChainList_tabStackBrush)
			{
				colName = "speaker"
			}
			else
			{
				colName = "unitID";
			}
			break;
		case 2:
			if (functionChainList_currentTab == functionChainList_tabStackBrush)
			{
				colName = "utterance";
			}
			else
			{
				colName = "wordTranscript";
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