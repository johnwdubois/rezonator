/*
	scr_panelPane_drawLineContentsLoop();
	
	Last Updated: 2019-012-28
	
	Called from: obj_panelPane
	
	Purpose: whatever Line is focused on in the lineList panelPane, draw information on the individual words of that Line
	
	Mechanism: loop through the IDList of the focused Line and gather information from corresponding grids
	
	Author: Terry DuBois, Georgio Klironomos
*/

if (live_call()) return live_result;


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


var rowInLineGrid = functionChainList_lineGridRowFocused;



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
if (ds_grid_height(grid) != 0 and functionChainList_lineGridRowFocused >= 0
and functionChainList_lineGridRowFocused < ds_grid_height(grid)) {
	// Collect beginning of chain info
	focusedChainExists = true;
	var unitID = ds_grid_get(grid, obj_control.lineGrid_colUnitID, rowInLineGrid);
	
	if (unitID >= 0) {
	
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
			var IDListSize = ds_list_size(functionChainContents_IDList);
			for (var j = 0; j < IDListSize; j++) {
		
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
				if(functionChainContents_lineGridRowFocused == j) {
					draw_set_alpha(1);
					draw_set_color(global.colorThemeText);
					draw_rectangle(rectX1 - clipX, rectY1 - clipY, rectX2 - clipX, rectY2 - clipY, true);
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
			
						//ds_grid_set_region(obj_control.lineGrid, obj_control.lineGrid_colLineState, 0, obj_control.lineGrid_colLineState, ds_grid_height(obj_control.lineGrid), 0);
						//ds_grid_set(obj_control.lineGrid, obj_control.lineGrid_colLineState, i, 1);
						with (obj_panelPane) {
							functionChainContents_lineGridRowFocused = j;
							//functionChainContents_BGColor = lineColor;
						}
					
						doubleClickTimer = 0;
					}
		
				}
			
				var infoListSize = 3;
				if(functionChainList_currentTab == functionChainList_tabLine) {
					infoListSize = lineContentsHeaderListSize;
				}
			
				// Set collected info into respective columns
				for (var getInfoLoop = 0; getInfoLoop < infoListSize; getInfoLoop++) {
					currentWordInfoCol[getInfoLoop] = "";
					
					if (getInfoLoop == 0) {
						if (functionChainList_currentTab == functionChainList_tabStackBrush
						or functionChainList_currentTab == functionChainList_tabClique) {
							var unitID = currentWordID;
							currentWordInfoCol[getInfoLoop] = string(ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colUtteranceID, unitID - 1));
						}
						else {
							var unitID = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colUnitID, currentWordID - 1);
							currentWordInfoCol[getInfoLoop] = string(ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colUtteranceID, unitID - 1));
						}
					}
					else if (getInfoLoop == 1) {
						if (functionChainList_currentTab == functionChainList_tabStackBrush
						or functionChainList_currentTab == functionChainList_tabClique) {
							currentWordInfoCol[getInfoLoop] = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colParticipantName, currentWordID - 1);
						}
						else {
							currentWordInfoCol[getInfoLoop] = string(ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colWordSeq, currentWordID - 1));
						}
					}
					else if (getInfoLoop == 2) {
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
								var currentWordString = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colWordToken, currentWordID - 1);
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
					}
					else if (getInfoLoop > 2) {
						currentWordInfoCol[getInfoLoop] = string(ds_grid_get(global.labelWordGrid, getInfoLoop - 1, currentWordID - 1));
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

var headerListSize = 3;
lineContentsHeaderListSize = 3 + (ds_grid_width(global.labelWordGrid) - 2);
if (functionChainList_currentTab == functionChainList_tabLine) {
	headerListSize = lineContentsHeaderListSize;
}


/*if(obj_control.showDevVars) {
	headerListSize = 6;
}*/
// Create the column headers
for (var i = 0; i < headerListSize; i++) {
	var colRectX1 = x + (i * (windowWidth / 6));
	var colRectY1 = y;
	var colRectX2 = colRectX1 + (windowWidth / 6);
	var colRectY2 = colRectY1 + windowHeight;
	
	var colName = "";
	
	
	
	if (i == 0) {
		colName = "uID";
	}
	else if (i == 1) {
		colName = "place";
	}
	else if (i == 2) {
		colName = "text";
	}
	else if (i > 2) {
		colName = ds_list_find_value(global.labelWordGridColNameList, i - 1);
	}
	
	// draw lines to separate columns
	draw_set_color(global.colorThemeBG);
	draw_rectangle(colRectX1 - clipX, colRectY1 - clipY, colRectX2 - clipX, colRectY1 + tabHeight - clipY, false);
	draw_set_color(global.colorThemeBorders);
	draw_rectangle(colRectX1 - clipX, colRectY1 - clipY, colRectX2 - clipX, colRectY2 - clipY, true);
	
	// draw column header names
	draw_set_color(global.colorThemeText);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_set_font(global.fontPanelTab);
	draw_text(colRectX1 + 4 - clipX, y - clipY, colName);
	
	// draw wordView button
	var wordViewButtonSize = (tabHeight) - 8;
	var wordViewRectX1 = colRectX2 - wordViewButtonSize - 4;
	var wordViewRectY1 = colRectY1 + 4;
	var wordViewRectX2 = wordViewRectX1 + wordViewButtonSize;
	var wordViewRectY2 = wordViewRectY1 + wordViewButtonSize;
	if (obj_control.wordView == i) {
		draw_set_color(global.colorThemeBorders);
		draw_rectangle(wordViewRectX1 - clipX, wordViewRectY1 - clipY, wordViewRectX2 - clipX, wordViewRectY2 - clipY, false);
		draw_set_color(global.colorThemeBG);
	}
	else {
		draw_set_color(global.colorThemeText);
	}
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_text(mean(wordViewRectX1, wordViewRectX2) - clipX, mean(wordViewRectY1, wordViewRectY2) - clipY, "w");
	if (point_in_rectangle(mouse_x, mouse_y, wordViewRectX1, wordViewRectY1, wordViewRectX2, wordViewRectY2)) {
		draw_set_color(global.colorThemeBorders);
		draw_rectangle(wordViewRectX1 - clipX, wordViewRectY1 - clipY, wordViewRectX2 - clipX, wordViewRectY2 - clipY, true);
		if (mouse_check_button_released(mb_left)) {
			obj_control.wordView = i;
			
			var toggleTranscriptionGrid = -1;
			var toggleTranscriptionCol = -1;
			if (i == 0) {
				toggleTranscriptionGrid = obj_control.wordGrid;
				toggleTranscriptionCol = obj_control.wordGrid_colUtteranceID;
			}
			else if (i == 1) {
				toggleTranscriptionGrid = obj_control.wordGrid;
				toggleTranscriptionCol = obj_control.wordGrid_colWordSeq;
			}
			else if (i == 2) {
				toggleTranscriptionGrid = obj_control.wordGrid;
				toggleTranscriptionCol = (obj_control.transcriptAvailable) ? obj_control.wordGrid_colWordTranscript : obj_control.wordGrid_colWordToken;
			}
			else if (i > 2) {
				toggleTranscriptionGrid = global.labelWordGrid;
				toggleTranscriptionCol = i - 1;
			}
			scr_toggleTranscriptionMulti(toggleTranscriptionGrid, toggleTranscriptionCol);
		}
	}
	
	
	if (obj_control.showDevVars) {
		if(i == headerListSize - 1) {
			var buttonRectSize = (tabHeight) - 8;
			var newCategoryRectX1 = colRectX2 + buttonRectSize + 2;
			var newCategoryRectY1 = colRectY1 + 4;
			var newCategoryRectX2 = newCategoryRectX1 + buttonRectSize;
			var newCategoryRectY2 = newCategoryRectY1 + buttonRectSize;
		
			draw_set_color(global.colorThemeText);
			draw_sprite_ext(spr_filterIcons, 1, mean(newCategoryRectX1 - clipX, newCategoryRectX2 - clipX), mean(newCategoryRectY1 - clipY, newCategoryRectY2 - clipY), 1, 1, 0, c_white, 1);
			
			if (point_in_rectangle(mouse_x, mouse_y, newCategoryRectX1, newCategoryRectY1, newCategoryRectX2, newCategoryRectY2)) {
				draw_set_color(global.colorThemeBorders);
				draw_rectangle(newCategoryRectX1 - clipX, newCategoryRectY1 - clipY, newCategoryRectX2 - clipX, newCategoryRectY2 - clipY, true);
				if (mouse_check_button_released(mb_left)) {
					//show_message("YO");
					obj_panelPane.lineContentsHeaderListSize++;
					//show_message(obj_panelPane.lineContentsHeaderListSize);
					if (!obj_control.dialogueBoxActive) {
						keyboard_string = "";
						obj_control.newTagCategory = true;
					}

					obj_control.dialogueBoxActive = true;

					if (!instance_exists(obj_dialogueBox)) {
						instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
					}
				}
			}
		}
	
		if(i > 2) {
			var buttonRectSize = (tabHeight) - 8;
			var newCategoryRectX1 = colRectX2 - buttonRectSize*2 - 2;
			var newCategoryRectY1 = colRectY1 + 4;
			var newCategoryRectX2 = newCategoryRectX1 + buttonRectSize;
			var newCategoryRectY2 = newCategoryRectY1 + buttonRectSize;
		
			draw_set_color(global.colorThemeText);
			draw_sprite_ext(spr_filterIcons, 1, mean(newCategoryRectX1 - clipX, newCategoryRectX2 - clipX), mean(newCategoryRectY1 - clipY, newCategoryRectY2 - clipY), 1, 1, 0, c_white, 1);
			
			if (point_in_rectangle(mouse_x, mouse_y, newCategoryRectX1, newCategoryRectY1, newCategoryRectX2, newCategoryRectY2)) {
				draw_set_color(global.colorThemeBorders);
				draw_rectangle(newCategoryRectX1 - clipX, newCategoryRectY1 - clipY, newCategoryRectX2 - clipX, newCategoryRectY2 - clipY, true);
				if (mouse_check_button_released(mb_left)) {
					show_message("Add Tag");
					/*lineContentsHeaderListSize++;
					if (!obj_control.dialogueBoxActive) {
						keyboard_string = "";
						obj_control.newTag = true;
					}

					obj_control.dialogueBoxActive = true;

					if (!instance_exists(obj_dialogueBox)) {
						instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
					}*/
				}
			}
		
			var buttonRectSize = (tabHeight) - 8;
			var newCategoryRectX1 = colRectX2 - buttonRectSize - 2;
			var newCategoryRectY1 = colRectY1 + 4;
			var newCategoryRectX2 = newCategoryRectX1 + buttonRectSize;
			var newCategoryRectY2 = newCategoryRectY1 + buttonRectSize;
		
			draw_set_color(global.colorThemeText);
			draw_sprite_ext(spr_filterIcons, 1, mean(newCategoryRectX1 - clipX, newCategoryRectX2 - clipX), mean(newCategoryRectY1 - clipY, newCategoryRectY2 - clipY), 1, 1, 0, c_white, 1);
			
			if (point_in_rectangle(mouse_x, mouse_y, newCategoryRectX1, newCategoryRectY1, newCategoryRectX2, newCategoryRectY2)) {
				draw_set_color(global.colorThemeBorders);
				draw_rectangle(newCategoryRectX1 - clipX, newCategoryRectY1 - clipY, newCategoryRectX2 - clipX, newCategoryRectY2 - clipY, true);
				if (mouse_check_button_released(mb_left)) {
					show_message("Remove Tag");
					/*lineContentsHeaderListSize++;
					if (!obj_control.dialogueBoxActive) {
						keyboard_string = "";
						obj_control.newTag = true;
					}

					obj_control.dialogueBoxActive = true;

					if (!instance_exists(obj_dialogueBox)) {
						instance_create_layer(x, y, "InstancesDialogue", obj_dialogueBox);
					}*/
				}
			}
		}
	}
	
	/*if (functionChainContents_infoCol[i] == 3 && obj_control.showDevVars) {
		draw_set_color(global.colorThemeText);
		if (point_in_rectangle(mouse_x, mouse_y, colRectX1, colRectY1, colRectX2, colRectY1 + tabHeight)) {
			//show_message("YO");
			draw_set_color(global.colorThemeBorders);
			draw_set_alpha(0.5);
			draw_rectangle(colRectX1 - clipX, colRectY1 - clipY, colRectX2 - clipX, colRectY1 + tabHeight - clipY, false);
			if (mouse_check_button_released(mb_left)) {
				show_message("YO");
			}
		}
		draw_set_color(global.colorThemeText);
	}
	
	// draw toggleDraw button
			var buttonRectSize = (tabRectY2 - tabRectY1) - 8;
			var toggleDrawRectX1 = tabRectX2 - buttonRectSize - 4;
			var toggleDrawRectY1 = tabRectY1 + 4;
			var toggleDrawRectX2 = toggleDrawRectX1 + buttonRectSize;
			var toggleDrawRectY2 = toggleDrawRectY1 + buttonRectSize;
		
			draw_sprite_ext(spr_toggleDraw, obj_chain.toggleDrawRez, mean(toggleDrawRectX1, toggleDrawRectX2), mean(toggleDrawRectY1, toggleDrawRectY2), 1, 1, 0, c_white, 1);
			
			if (point_in_rectangle(mouse_x, mouse_y, toggleDrawRectX1, toggleDrawRectY1, toggleDrawRectX2, toggleDrawRectY2)) {
				draw_set_color(global.colorThemeBorders);
				draw_rectangle(toggleDrawRectX1, toggleDrawRectY1, toggleDrawRectX2, toggleDrawRectY2, true);
				if (mouse_check_button_released(mb_left)) {
					show_message("YO");
				}
			}
	*/
}
draw_set_alpha(1);

// draw line to separate column headers from data
draw_set_color(global.colorThemeBorders);
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



