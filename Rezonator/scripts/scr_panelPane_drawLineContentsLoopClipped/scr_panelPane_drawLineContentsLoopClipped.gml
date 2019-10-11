/*
	scr_panelPane_drawchainContentsLoop();
	
	Last Updated: 2018-07-12
	
	Called from: obj_panelPane
	
	Purpose: whatever chain is focused on in the chainList panelPane, draw information on the individual contents of that chain
	
	Mechanism: loop through the IDList of the focused chain and gather information from corresponding grids
	
	Author: Terry DuBois, Georgio Klironomos
*/





// Set opacity, alignment, and font of contents list
draw_set_alpha(1);
draw_set_halign(fa_left);
draw_set_valign(fa_middle);
draw_set_font(global.fontChainContents);
var strHeight = string_height("0");
draw_set_font(global.fontPanelTab);
var tabHeight = functionChainList_tabHeight;
var scrollBarListHeight = 0;

var grid = obj_control.lineGrid;




if (functionChainContents_colXList == -1 or is_undefined(functionChainContents_colXList)) {
	exit;
}


var rowInLineGrid = functionChainContents_lineGridRowFocused;



// Set text margins
var textMarginTop = tabHeight;
var textPlusY = 0;
var ableToBeMouseOver = true;

var xBuffer = 6;

// Create scroll bars
var scrollBarWidth = 16;

var focusedChainExists = false;
var alignRectSize = strHeight;
var oldRow = -1;

var focusedElementY = -1;




draw_set_font(global.fontChainContents);
var strHeight = string_height("0");



// Check for focused chain and make sure grid is not empty, gather information from grids
if (ds_grid_height(grid) != 0 and functionChainContents_lineGridRowFocused >= 0
and functionChainContents_lineGridRowFocused < ds_grid_height(grid)) {
	// Collect beginning of chain info
	focusedChainExists = true;
	var unitID = ds_grid_get(grid, obj_control.lineGrid_colUnitID, rowInLineGrid);
	
	// Get wordID list
	with (obj_panelPane) {
		functionChainContents_IDList = ds_grid_get(grid, obj_control.lineGrid_colWordIDList, rowInLineGrid);
		
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
		for (var j = 0; j < ds_list_size(functionChainContents_IDList); j++) {
		
			//Get info on current word
			var currentWordID = ds_list_find_value(functionChainContents_IDList, j);
			var currentWordInfoCol;
			currentWordInfoCol[0] = "";
		
			//Set size of rectangle around word
			var rectX1 = x;
			var rectY1 = y + textMarginTop + textPlusY - (strHeight / 2) + scrollPlusY;
			var rectX2 = x + windowWidth - scrollBarWidth;
			var rectY2 = rectY1 + strHeight;

			

			if (scr_pointInRectangleClippedWindow(mouse_x, mouse_y, rectX1, rectY1, rectX2, rectY2) and ableToBeMouseOver) {
				ableToBeMouseOver = false;
				draw_set_alpha(0.25);
				draw_set_color(global.colorThemeText);
				draw_rectangle(rectX1 - clipX, rectY1 - clipY, rectX2 - clipX, rectY2 - clipY, false);
			

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
			
				switch (functionChainContents_infoCol[getInfoLoop]) {
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
							for (var i = 0; i < ds_list_size(currentWordIDList); i++) {
								var currentWordID = ds_list_find_value(currentWordIDList, i);
								var currentWordString = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colWordToken, currentWordID - 1);
								currentWordInfoCol[getInfoLoop] += currentWordString + " ";
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
	
	switch (functionChainContents_infoCol[i]) {
		case 0:
			colName = "uID";
			break;
		case 1:
			colName = "place";
			break;
		case 2:
			colName = "text";
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
