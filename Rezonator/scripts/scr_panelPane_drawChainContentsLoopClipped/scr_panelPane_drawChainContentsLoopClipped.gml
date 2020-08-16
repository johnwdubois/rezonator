/*
	scr_panelPane_drawchainContentsLoop();
	
	Last Updated: 2018-07-12
	
	Called from: obj_panelPane
	
	Purpose: whatever chain is focused on in the chainList panelPane, draw information on the individual contents of that chain
	
	Mechanism: loop through the IDList of the focused chain and gather information from corresponding grids
	
	Author: Terry DuBois, Georgio Klironomos
*/

//if (live_call()) return live_result;

// INcrease the size of the utterance column!!!

var filterPaneWidth = 0;
var chainListPaneWidth = 0;
with (obj_panelPane) {
	if (currentFunction == functionChainList) {
		chainListPaneWidth = windowWidth;
	}
	else if (currentFunction == functionFilter) {
		filterPaneWidth = windowWidth;
	}
}

//Set this pane to the right of the chainListPane
x = filterPaneWidth + chainListPaneWidth;



// Set opacity, alignment, and font of contents list
draw_set_alpha(1);
draw_set_halign(fa_left);
draw_set_valign(fa_middle);
draw_set_font(global.fontChainContents);
var strHeight = string_height("0");
draw_set_font(global.fontPanelTab);
var tabHeight = functionChainList_tabHeight;
var scrollBarListHeight = 0;

var grid = obj_chain.rezChainGrid;





if (functionChainContents_colXList == -1 or is_undefined(functionChainContents_colXList)) {
	exit;
}


if (clickedIn and keyboard_check_pressed(vk_escape)) {
	with (obj_panelPane) {
		functionChainList_lineGridRowFocused = -1;
		functionChainContents_BGColor = global.colorThemeBG;
	}
}


scr_surfaceStart();

// Find current tab to draw correct contents
switch (functionChainList_currentTab) {
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
	case functionChainList_tabLine:
		grid = -1;
		if (obj_control.showTranslation and not obj_control.showUnitTags) {
			scr_panelPane_drawLineTranslationLoopClipped();
		}
		else if (obj_control.showUnitTags and not obj_control.showTranslation) {
			scr_panelPane_drawUnitTagsLoopClipped();	
		}
		else {
			scr_panelPane_drawLineContentsLoopClipped();
		}
		
		//scr_panelPane_drawLineTranslationLoopClipped();
		break;
	default:
		grid = obj_chain.rezChainGrid;
		break;
}

if (grid != -1) {
	// Set text margins
	var textMarginTop = tabHeight;
	var textPlusY = 0;
	var ableToBeMouseOver = true;

	var xBuffer = 6;


	var focusedChainExists = false;
	var alignRectSize = strHeight;
	var oldRow = -1;
	//var olderRow = -1;

	var focusedElementY = -1;


	with (obj_chain) {
		if (ds_grid_value_exists(grid, obj_chain.chainGrid_colChainState, 0, obj_chain.chainGrid_colChainState, ds_grid_height(grid), obj_chain.chainStateFocus) ) {
			oldFocusedContentsRow = ds_grid_value_y(grid, obj_chain.chainGrid_colChainState, 0, obj_chain.chainGrid_colChainState, ds_grid_height(grid), obj_chain.chainStateFocus);
		}
	}

	with (obj_chain) {
		if (oldFocusedContentsRow >= 0) {
			oldRow = oldFocusedContentsRow;
		}
	}

	draw_set_font(global.fontChainContents);
	var strHeight = string_height("0");


	// Check for focused chain and make sure grid is not empty, gather information from grids
	if (oldRow >= 0 && ds_grid_height(grid) != 0) {
		// Collect beginning of chain info
		focusedChainExists = true;
		var rowInChainGrid = oldRow;
		var chainID = ds_grid_get(grid, obj_chain.chainGrid_colChainID, rowInChainGrid);
		var chainAligned = ds_grid_get(grid, obj_chain.chainGrid_colAlign, rowInChainGrid);
	
		// Get wordID list
		with (obj_panelPane) {
			functionChainContents_IDList = ds_grid_get(grid, obj_chain.chainGrid_colWordIDList, rowInChainGrid);
		
			if (functionChainContents_IDList != undefined) {
				// Select top of the content list
				if (functionChainContents_hop > -1) {
					if (ds_list_find_index(functionChainContents_IDList, functionChainContents_hop) > -1) {
						//currentTopViewRow = ds_list_find_index(functionChainContents_IDList, functionChainContents_hop);
					}
					functionChainContents_hop = -1;
				}
			}
		}
	
		if (functionChainContents_IDList != undefined) {
		
			scrollBarListHeight = ds_list_size(functionChainContents_IDList);
	
			// Gather specfic information on words
			var IDListSize = ds_list_size(functionChainContents_IDList);
			for (var j = 0; j < IDListSize; j++) {
		
				//Get info on current word
				var currentWordID = ds_list_find_value(functionChainContents_IDList, j);
				var currentWordAligned = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colAligned, currentWordID - 1);
				var currentWordInfoCol;
				currentWordInfoCol[0] = "";
		
				//Set size of rectangle around word
				var rectX1 = x;
				var rectY1 = y + textMarginTop + textPlusY - (strHeight / 2) + scrollPlusY;
				var rectX2 = x + windowWidth - global.scrollBarWidth;
				var rectY2 = rectY1 + strHeight;
		
				// Find link info
				var rowInLinkGrid = scr_findInGridThreeParameters(obj_chain.linkGrid, obj_chain.linkGrid_colSource, currentWordID, obj_chain.linkGrid_colChainID, chainID, obj_chain.linkGrid_colDead, false);
				var focusedLink = ds_grid_get(obj_chain.linkGrid, obj_chain.linkGrid_colFocus, rowInLinkGrid);
				var sourceWordID = ds_grid_get(obj_chain.linkGrid, obj_chain.linkGrid_colSource, rowInLinkGrid);
		
				// Draw red rectangles if stretch word
				if (grid == obj_chain.rezChainGrid or grid == obj_chain.trackChainGrid) {
					if(sourceWordID !=  undefined) {
						if (ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colStretch, sourceWordID - 1)) {
							draw_set_alpha(0.25);
							draw_set_color(c_red);
							draw_rectangle(rectX1 - clipX, rectY1 - clipY, rectX2 - clipX, rectY2 - clipY, false);
						}
					}
				}
			
				// Sets the link focused in the panelPane to the link focused in the main screen
				if (focusedLink) {
			
					// Fill in square
					draw_set_alpha(0.25);
					draw_set_color(global.colorThemeText);
					draw_rectangle(rectX1 - clipX, rectY1 - clipY, rectX2 - clipX, rectY2 - clipY, false);
			
					// Focus in the main screen
					if (grid == obj_chain.rezChainGrid or grid == obj_chain.trackChainGrid) {
						ds_grid_set_region(obj_control.wordDrawGrid, obj_control.wordDrawGrid_colFillRect, 0, obj_control.wordDrawGrid_colFillRect, ds_grid_height(obj_control.wordDrawGrid), false);
						ds_grid_set(obj_control.wordDrawGrid, obj_control.wordDrawGrid_colFillRect, sourceWordID - 1, true);
						obj_chain.mouseLineWordID = sourceWordID;
					}
				}
				else if (scr_pointInRectangleClippedWindow(mouse_x, mouse_y, rectX1, rectY1, rectX2, rectY2) and ableToBeMouseOver) {
					ableToBeMouseOver = false;
					draw_set_alpha(0.25);
					draw_set_color(global.colorThemeText);
					draw_rectangle(rectX1 - clipX, rectY1 - clipY, rectX2 - clipX, rectY2 - clipY, false);
			
					// Focus in the main screen
					if (device_mouse_check_button_released(0, mb_left) and obj_toolPane.currentTool != obj_toolPane.toolBoxBrush)
					{	
						ds_grid_set_region(obj_chain.linkGrid, obj_chain.linkGrid_colFocus, 0, obj_chain.linkGrid_colFocus, ds_grid_height(obj_chain.linkGrid), false);
						ds_grid_set(obj_chain.linkGrid, obj_chain.linkGrid_colFocus, rowInLinkGrid, true);
						scr_refreshChainGrid();
				
				
					}
				}
				draw_set_alpha(1);
	
				// Check for double click
				if (scr_pointInRectangleClippedWindow(mouse_x, mouse_y, rectX1, rectY1, rectX2, rectY2) and device_mouse_check_button_released(0, mb_left)) {
					if (doubleClickTimer > -1) {
				
						var rowInLineGrid = -1;
				
						// Set double clicked word to center display row, if possible
						if (functionChainList_currentTab == functionChainList_tabStackBrush
						or functionChainList_currentTab == functionChainList_tabClique) {
							var currentUnitID = currentWordID;
							rowInLineGrid = ds_grid_value_y(obj_control.currentActiveLineGrid, obj_control.lineGrid_colUnitID, 0, obj_control.lineGrid_colUnitID, ds_grid_height(obj_control.lineGrid), currentUnitID);
						}
						else {
							var currentUnitID = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colUnitID, currentWordID - 1);
							rowInLineGrid = ds_grid_value_y(obj_control.currentActiveLineGrid, obj_control.lineGrid_colUnitID, 0, obj_control.lineGrid_colUnitID, ds_grid_height(obj_control.lineGrid), currentUnitID);
						}
					
						if (rowInLineGrid >= 0 and rowInLineGrid < ds_grid_height(obj_control.currentActiveLineGrid)) {
							//var displayRow = ds_grid_get(obj_control.lineGrid, obj_control.lineGrid_colDisplayRow, rowInLineGrid);
							//obj_control.currentCenterDisplayRow = ds_grid_get(obj_control.lineGrid, obj_control.lineGrid_colDisplayRow, displayRow);
							var linePixelY = ds_grid_get(obj_control.currentActiveLineGrid, obj_control.lineGrid_colPixelYOriginal, rowInLineGrid);
							obj_control.scrollPlusYDest = -linePixelY + (camera_get_view_height(view_camera[0]) / 2) - 100;
						}
					}
					else {
						doubleClickTimer = 0;
					}
		
				}
		
				// Set collected info into correct places
				for (var getInfoLoop = 0; getInfoLoop < 3; getInfoLoop++) {
					currentWordInfoCol[getInfoLoop] = "";
			
					switch (getInfoLoop) {
						case 0:
							if (functionChainList_currentTab == functionChainList_tabStackBrush
							or functionChainList_currentTab == functionChainList_tabClique) {
								var unitID = currentWordID;
								currentWordInfoCol[getInfoLoop] = string(ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colUtteranceID, unitID - 1));
							}
							else {
								var unitID = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colUnitID, currentWordID - 1);
								currentWordInfoCol[getInfoLoop] = string(ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colUtteranceID, unitID - 1));
							}
							break;
						case 1:
							if (functionChainList_currentTab == functionChainList_tabStackBrush
							or functionChainList_currentTab == functionChainList_tabClique) {
								currentWordInfoCol[getInfoLoop] = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colParticipantName, currentWordID - 1);
							}
							else {
								currentWordInfoCol[getInfoLoop] = string(ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colWordSeq, currentWordID - 1));
							}
							break;
						case 2:
							if (functionChainList_currentTab == functionChainList_tabStackBrush
							or functionChainList_currentTab == functionChainList_tabClique) {
								currentWordInfoCol[getInfoLoop] = "";
								var currentWordIDList = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colWordIDList, currentWordID - 1);
								if (currentWordIDList == undefined) {
									break;
								}
								var currentWordIDListSize = ds_list_size(currentWordIDList);
								for (var i = 0; i < currentWordIDListSize; i++) {
									var currentWordID = ds_list_find_value(currentWordIDList, i);
									var currentWordString = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayString, currentWordID - 1);//ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colWordToken, currentWordID - 1);
									currentWordInfoCol[getInfoLoop] += string(currentWordString) + " ";
								}
						
								if (string_length(currentWordInfoCol[getInfoLoop]) > 100) {
									currentWordInfoCol[getInfoLoop] = string_delete(currentWordInfoCol[getInfoLoop], 100, string_length(currentWordInfoCol[getInfoLoop]) - 100);
									currentWordInfoCol[getInfoLoop] += "...";
								}
							}
							else {
								currentWordInfoCol[getInfoLoop] = string(ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayString, currentWordID - 1));
							}
							break;
					}
			
					var textX = x + (getInfoLoop * (windowWidth / 6)) + xBuffer;
					var textY = y + textMarginTop + textPlusY;
			
					draw_set_color(global.colorThemeText);
					draw_set_alpha(1);
					draw_set_valign(fa_middle);
					draw_set_font(global.fontChainContents);
					draw_text(textX - clipX + 2, textY - clipY + scrollPlusY, currentWordInfoCol[getInfoLoop]);
				}
			
				if (functionChainList_currentTab == functionChainList_tabRezBrush) {
			
					var alignRectX1 = x + windowWidth - global.scrollBarWidth - strHeight - alignRectSize;
					var alignRectY1 = y + textMarginTop + textPlusY - (alignRectSize / 2) + scrollPlusY + 1;
					var alignRectX2 = x + windowWidth - global.scrollBarWidth - strHeight;
					var alignRectY2 = y + textMarginTop + textPlusY + (alignRectSize / 2) + scrollPlusY - 1;
		
		 			if (scr_pointInRectangleClippedWindow(mouse_x, mouse_y, alignRectX1, alignRectY1, alignRectX2, alignRectY2)) {
						draw_set_color(c_purple);
						draw_set_alpha(0.5);
						draw_rectangle(alignRectX1 - clipX, alignRectY1 - clipY, alignRectX2 - clipX, alignRectY2 - clipY, false);
				
						if (device_mouse_check_button_released(0, mb_left)
						and chainAligned and not ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colStretch, currentWordID - 1)) {
							currentWordAligned = !currentWordAligned;
							ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colAligned, currentWordID - 1, currentWordAligned);
			
							if (ds_grid_height(obj_chain.vizLinkGrid) > 0) {
								var rowInVizLinkGrid = scr_findInGridTwoParameters(obj_chain.vizLinkGrid, obj_chain.vizLinkGrid_colSource, currentWordID, obj_chain.vizLinkGrid_colAlign, !currentWordAligned);
								while (rowInVizLinkGrid >= 0 and rowInVizLinkGrid < ds_grid_height(obj_chain.vizLinkGrid)) {
									ds_grid_set(obj_chain.vizLinkGrid, obj_chain.vizLinkGrid_colAlign, rowInVizLinkGrid, currentWordAligned);
									rowInVizLinkGrid = scr_findInGridTwoParameters(obj_chain.vizLinkGrid, obj_chain.vizLinkGrid_colSource, currentWordID, obj_chain.vizLinkGrid_colAlign, !currentWordAligned);
								}
							}
						}
				
				
					}
					draw_sprite_ext(spr_align, !currentWordAligned, mean(alignRectX1, alignRectX2) - clipX, mean(alignRectY1, alignRectY2) - clipY, 1, 1, 0, c_white, 1);
			
				}
			
				textPlusY += strHeight;
			}
		}
	}

	var scrollBarListSize = 0;
	if (functionChainContents_IDList != undefined) {
		if (ds_exists(functionChainContents_IDList, ds_type_list)) {
			scrollBarListSize = ds_list_size(functionChainContents_IDList);
		}
	}

	var scrollBarBackColor = global.colorThemeSelected1;
	if (scrollBarListSize > 1000) {
		scrollBarBackColor = global.colorThemeSelected2;
	}

	scr_scrollBar(scrollBarListSize, focusedElementY, strHeight, tabHeight,
		scrollBarBackColor, global.colorThemeSelected2,
		global.colorThemeSelected1, global.colorThemeSelected2, spr_ascend, windowWidth, windowHeight);


	draw_set_alpha(1);


	draw_set_font(global.fontPanelTab);


	draw_set_color(global.colorThemeBG);
	draw_rectangle(x - clipX, y - clipY, x + windowWidth - clipX, y + tabHeight - clipY, false);


	for (var i = 0; i < 3; i++) {
		var colRectX1 = x + (i * (windowWidth / 6));
		var colRectY1 = y;
		var colRectX2 = colRectX1 + (windowWidth / 6);
		if(i == 2) {
			var colRectX2 = colRectX1 + (windowWidth);	
		}
		var colRectY2 = colRectY1 + windowHeight;
	
		var colName = "";
	
		switch (i) {
			// 0 --> wordID
			// 1 --> unitID
			// 2 --> wordTranscript
			case 0:
				if (functionChainList_currentTab == functionChainList_tabStackBrush
				or functionChainList_currentTab == functionChainList_tabClique) {
					colName = "uID";
				}
				else {
					colName = "uID";
				}
				break;
			case 1:
				if (functionChainList_currentTab == functionChainList_tabStackBrush
				or functionChainList_currentTab == functionChainList_tabClique) {
					colName = "speaker";
				}
				else {
					colName = "place";
				}
				break;
			case 2:
				if (functionChainList_currentTab == functionChainList_tabStackBrush
				or functionChainList_currentTab == functionChainList_tabClique) {
					colName = "utterance";
				}
				else {
					colName = "text";
				}
				break;
			default:
				colName = "N/A";
				break;
		}
	
		draw_set_color(global.colorThemeBG);
		draw_rectangle(colRectX1 - clipX, colRectY1 - clipY, colRectX2 - clipX, colRectY1 + tabHeight - clipY, false);
		draw_set_color(global.colorThemeBorders);
		draw_rectangle(colRectX1 - clipX, colRectY1 - clipY, colRectX2 - clipX, colRectY2 - clipY, true);
		draw_set_color(global.colorThemeText);
		draw_set_valign(fa_top);
		draw_set_font(global.fontPanelTab);
		draw_text(colRectX1 + 4 - clipX, y - clipY, colName);
		
		// sort arrow
		var sortArrowAngle = (functionChainContents_sortedCol == i) ? 0 : 270;
		if (functionChainContents_sortedCol == i and not functionChainContents_sortedColAsc) {
			sortArrowAngle = 180;
		}
		var sortArrowX = colRectX1 + string_width(colName + "AA");
		var sortArrowY = y + (sprite_get_height(spr_ascend) * 0.4);
		var sortArrowRectX1 = sortArrowX - 10;
		var sortArrowRectY1 = sortArrowY - 10;
		var sortArrowRectX2 = sortArrowX + 10;
		var sortArrowRectY2 = sortArrowY + 10;
		draw_sprite_ext(spr_ascend, 0, sortArrowX - clipX, sortArrowY - clipY, 1, 1, sortArrowAngle, c_white, 1);
		if (point_in_rectangle(mouse_x, mouse_y, sortArrowRectX1, sortArrowRectY1, sortArrowRectX2, sortArrowRectY2)) {
			draw_set_color(global.colorThemeBorders);
			draw_set_alpha(1);
			draw_rectangle(sortArrowRectX1 - clipX, sortArrowRectY1 - clipY, sortArrowRectX2 - clipX, sortArrowRectY2 - clipY, true);
			
			if (device_mouse_check_button_released(0, mb_left)) {
				if (functionChainContents_sortedCol == i) {
					if (functionChainContents_sortedColAsc) {
						functionChainContents_sortedColAsc = false;
					}
					else {
						functionChainContents_sortedCol = -1;
						functionChainContents_sortedColAsc = true;
					}
				}
				else {
					functionChainContents_sortedCol = i;
					functionChainContents_sortedColAsc = true;
				}
				scr_sortChainGrid(obj_chain.rezChainGrid, functionChainContents_sortedCol, functionChainContents_sortedColAsc);
				scr_sortChainGrid(obj_chain.trackChainGrid, functionChainContents_sortedCol, functionChainContents_sortedColAsc);
				scr_sortChainGrid(obj_chain.stackChainGrid, functionChainContents_sortedCol, functionChainContents_sortedColAsc);
			}
		}
	}


	draw_line(x - clipX, y + tabHeight - clipY, x + windowWidth - clipX, y + tabHeight - clipY);

	// Allows use of arrow keys, pgUp/pgDwn, and ctrl+key in chain list if clicked in chainContents
	if (clickedIn) {
	
		// Scroll up with mouse/key
		if ((mouse_wheel_up() || keyboard_check(vk_up)) and (obj_panelPane.holdUp < 2 || obj_panelPane.holdUp > 30)) {
			scrollPlusYDest += strHeight;
		}
	
		// Scroll down with mouse/key
		if ((mouse_wheel_down() || keyboard_check(vk_down)) and (obj_panelPane.holdDown < 2 || obj_panelPane.holdDown > 30)) {
			scrollPlusYDest -= strHeight;
		}
	
		// CTRL+UP and CTRL+DOWN
		if (keyboard_check(vk_control) && keyboard_check_pressed(vk_up)) {
			scrollPlusYDest = 100;
		}
		if (keyboard_check(vk_control) && keyboard_check_pressed(vk_down)) {
			scrollPlusYDest = -999999999999;
		}
	
		// PAGEUP and PAGEDOWN
		if (keyboard_check_pressed(vk_pageup)) {
			scrollPlusYDest += (windowHeight);
		}
		if (keyboard_check_pressed(vk_pagedown)) {
			scrollPlusYDest -= (windowHeight);
		}
	}
}


scr_surfaceEnd();