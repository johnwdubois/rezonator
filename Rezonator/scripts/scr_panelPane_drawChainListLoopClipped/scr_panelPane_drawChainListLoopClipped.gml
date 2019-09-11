/*
	scr_panelPane_drawChainListLoop();
	
	Last Updated: 2019-01-29
	
	Called from: obj_panelPane
	
	Purpose: draw the chains for whatever tab you are on, if a user clicks on a chain then focus it and
			set chainContents panelPane to look at that chain
	
	Mechanism: loop through chainGrid of whatever tab you are on and draw chainName
	
	Author: Terry DuBois, Georgio Klironomos
*/

windowWidth = camera_get_view_width(view_camera[0]) / 3.5;

var grid = obj_chain.rezChainGrid;

// Based on user selection, get the grid of the current tab
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
	default:
		grid = obj_chain.rezChainGrid;
		break;
}
if(instance_exists(obj_stackShow)){
	grid = obj_chain.stackChainGrid;
	obj_toolPane.currentTool = obj_toolPane.toolStackBrush;
}

draw_set_font(global.fontChainList);
var strHeight = string_height("0") * 1.5;

// Set text margin area
var filterRectMargin = 8;
var filterRectSize = strHeight / 2;
var textMarginLeft = filterRectMargin + (filterRectSize * 2);

var textMarginTop = functionChainList_tabHeight;
var textPlusY = 0;
var chainNameRectMinusY = 4;

var focusedElementY = -1;
var focusedChainNameRectY1 = -1;
var focusedChainNameRectY2 = -1;

// Set opacity, font, and alignment of text chain lists
draw_set_alpha(1);
draw_set_halign(fa_left);
draw_set_valign(fa_middle);
draw_set_color(global.colorThemeText);

scr_surfaceStart();

for (var i = 0; i < ds_grid_height(grid); i++) {
	
	if (y + textMarginTop + scrollPlusY + textPlusY < y - strHeight
	or y + textMarginTop + scrollPlusY + textPlusY > y + windowHeight + strHeight) {
		textPlusY += strHeight;
		continue;
	}
	
	
	// Get grid info of current chain
	var currentChainID = ds_grid_get(grid, obj_chain.chainGrid_colChainID, i);
	var currentChainState = ds_grid_get(grid, obj_chain.chainGrid_colChainState, i);
	var currentChainName = ds_grid_get(grid, obj_chain.chainGrid_colName, i);
	var currentChainColor = ds_grid_get(grid, obj_chain.chainGrid_colColor, i);
	
	
	// Get dimensions of rectagle around chain name
	var chainNameRectX1 = x// + textMarginLeft;
	var chainNameRectY1 = y + textMarginTop + textPlusY + scrollPlusY - (strHeight / 2);
	var chainNameRectX2 = x + windowWidth; //chainNameRectX1 + string_width(currentChainName);
	var chainNameRectY2 = chainNameRectY1 + strHeight// - chainNameRectMinusY;
	
	//Check mouse clicks to focus a chain in the list
	if (point_in_rectangle(mouse_x, mouse_y, chainNameRectX1, chainNameRectY1, chainNameRectX2, chainNameRectY2)
	and point_in_rectangle(mouse_x, mouse_y, x, y, x + windowWidth, y + windowHeight)) {
		if (obj_control.showDevVars) {
			draw_set_color(c_red);
			draw_circle(mouse_x, mouse_y, 5, true);
		}
		
		if (device_mouse_check_button_released(0, mb_left) and not instance_exists(obj_dialogueBox) and not instance_exists(obj_dropDown)) {
		
			if (currentChainState != obj_chain.chainStateFocus) {
				// Unfocus chain if previously focused
				//if (currentChainState == obj_chain.chainStateFocus) {
				//	currentChainState = obj_chain.chainStateNormal;
				//}
				//else {
				// Focuses on selected chain
					switch (functionChainList_currentTab) {
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
				
				
					// Unfocus any already focused chains
					for (var j = 0; j < ds_grid_height(grid); j++) {
						if (ds_grid_get(grid, obj_chain.chainGrid_colChainState, j) == obj_chain.chainStateFocus) {
							ds_grid_set(grid, obj_chain.chainGrid_colChainState, j, obj_chain.chainStateNormal);
						}
					}
				
					// Set chain to focus in the grid
					ds_grid_set(grid, obj_chain.chainGrid_colChainState, i, obj_chain.chainStateFocus);
					scr_setAllValuesInCol(obj_chain.linkGrid, obj_chain.linkGrid_colFocus, false);
				
					// Set chain to focus in the main screen
					if (obj_chain.mouseLineWordID >= 0 and obj_chain.mouseLineWordID < ds_grid_height(obj_control.wordDrawGrid)) {
						scr_setAllValuesInCol(obj_control.wordDrawGrid, obj_control.wordDrawGrid_colFillRect, false);
					}
					obj_chain.mouseLineWordID = -1;
				//}
			
				// Set scroll range in the chain list
				with (obj_panelPane) {
					functionChainContents_scrollRangeMin[functionChainList_currentTab] = 0;
					functionChainContents_scrollRangeMax[functionChainList_currentTab] = functionChainContents_maxScrollRange;
				}
				if (doubleClickTimer > -1) {	
						var rowInLineGrid = -1;
						var currentUnitIDList = -1;
						var currentUnitID = -1;
						
						currentUnitIDList = ds_grid_get(grid, obj_chain.chainGrid_colWordIDList, ds_grid_value_y(grid, obj_chain.chainGrid_colChainID, 0, obj_chain.chainGrid_colChainID, ds_grid_height(grid), currentChainID));
				
						if (functionChainList_currentTab == functionChainList_tabStackBrush
						or functionChainList_currentTab == functionChainList_tabClique) {
							currentUnitID = ds_list_find_value(currentUnitIDList, 0);
						}
						else {
							currentUnitID = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colUnitID, ds_list_find_value(currentUnitIDList, 0));
						}
					
						rowInLineGrid = ds_grid_value_y(obj_control.lineGrid, obj_control.lineGrid_colUnitID, 0, obj_control.lineGrid_colUnitID, ds_grid_height(obj_control.lineGrid), currentUnitID);
					
						// Set first unit of the double clicked chain to center display row, if possible
						if (rowInLineGrid >= 0 and rowInLineGrid < ds_grid_height(obj_control.lineGrid)) {
							//var displayRow = ds_grid_get(obj_control.lineGrid, obj_control.lineGrid_colDisplayRow, rowInLineGrid);
							//obj_control.currentCenterDisplayRow = ds_grid_get(obj_control.lineGrid, obj_control.lineGrid_colDisplayRow, displayRow);
							// Replacement of centerDisplayRow
							var linePixelY = ds_grid_get(obj_control.lineGrid, obj_control.lineGrid_colPixelYOriginal, rowInLineGrid);
							obj_control.scrollPlusYDest = -linePixelY + (camera_get_view_height(view_camera[0]) / 2) - 100;
						}
				}
				else {
					doubleClickTimer = 0;
				}
			}
		}
	}
	
	if (point_in_rectangle(mouse_x, mouse_y, chainNameRectX1, chainNameRectY1, chainNameRectX2, chainNameRectY2)
	and mouse_check_button_pressed(mb_right) and not instance_exists(obj_dialogueBox)  and not instance_exists(obj_dropDown) and grid != obj_chain.cliqueDisplayGrid) {
		
			// Unfocus any already focused chains
			for (var j = 0; j < ds_grid_height(grid); j++) {
				if (ds_grid_get(grid, obj_chain.chainGrid_colChainState, j) == obj_chain.chainStateFocus) {
					ds_grid_set(grid, obj_chain.chainGrid_colChainState, j, obj_chain.chainStateNormal);
				}
			}
				
			// Set chain to focus in the grid
			ds_grid_set(grid, obj_chain.chainGrid_colChainState, i, obj_chain.chainStateFocus);
			scr_setAllValuesInCol(obj_chain.linkGrid, obj_chain.linkGrid_colFocus, false);
				

		
		
		var dropDownOptionList = ds_list_create();
		if(grid  == obj_chain.stackChainGrid){
			ds_list_add(dropDownOptionList, "Rename", "Recolor", "Delete", "Caption");
		}
		else{
			ds_list_add(dropDownOptionList, "Rename", "Recolor", "Delete");
		}
		if (ds_list_size(dropDownOptionList) > 0 and obj_control.ableToCreateDropDown) {
			var dropDownInst = instance_create_depth(mouse_x, mouse_y, -999, obj_dropDown);
			dropDownInst.optionList = dropDownOptionList;
			dropDownInst.optionListType = 1;
					
			obj_control.ableToCreateDropDown = false;
			obj_control.alarm[0] = 2;
		}
	}
	
	//Color codes the chain lists for User
	var chainColor = ds_grid_get(grid, obj_chain.chainGrid_colColor, i); // Access color of new chain
	var rectX1 = chainNameRectX1; //x + textMarginLeft - 2; // Create the colored rectangle
	var rectX2 = chainNameRectX2; //x + textMarginLeft + 50;
	var rectY1 = chainNameRectY1; //y + textMarginTop + textPlusY + scrollPlusY - 9 - clipY
	var rectY2 = chainNameRectY2; //y + textMarginTop + textPlusY + scrollPlusY + 7 - clipY

	if (currentChainState == obj_chain.chainStateFocus) {
		rectX1 = x;
	}
	draw_set_color(merge_color(chainColor, global.colorThemeBG, 0.75)); //soften the color
	draw_rectangle(rectX1 - clipX, rectY1 - clipY, rectX2 - clipX, rectY2 - clipY, false);
	
	// Outline the rectangle in black
	if (currentChainState == obj_chain.chainStateFocus) {
		focusedChainNameRectY1 = chainNameRectY1;
		focusedChainNameRectY2 = chainNameRectY2;
		focusedElementY = y + textMarginTop + scrollPlusY + textPlusY;
		draw_set_font(global.fontChainListFocused);
	}
	else {
		draw_set_font(global.fontChainList);
	}
	
	// Draw text of chain names
	draw_set_color(global.colorThemeText);
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	draw_text(x + textMarginLeft - clipX, y + textMarginTop + scrollPlusY + textPlusY - clipY, currentChainName);
	
	// Draw little boxes for filter selection
	var chainFilterRectX1 = x + filterRectMargin - clipX;
	var chainFilterRectY1 = y + textMarginTop + scrollPlusY + textPlusY - (filterRectSize / 2) - clipY;
	var chainFilterRectX2 = chainFilterRectX1 + filterRectSize;
	var chainFilterRectY2 = chainFilterRectY1 + filterRectSize;
	var inFilter = ds_grid_get(grid, obj_chain.chainGrid_colInFilter, i);
	draw_set_font(global.fontPanelTab);
	
	draw_set_color(global.colorThemeText);
	// Fill in boxes if filtered
	if (inFilter) {
		draw_rectangle(chainFilterRectX1, chainFilterRectY1, chainFilterRectX2, chainFilterRectY2, false);
		draw_set_color(global.colorThemeBG);
	}
	else {
		draw_set_color(global.colorThemeText);
		draw_rectangle(chainFilterRectX1, chainFilterRectY1, chainFilterRectX2, chainFilterRectY2, true);
	}
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_text(mean(chainFilterRectX1, chainFilterRectX2), chainFilterRectY1 + (filterRectSize / 2), "F");
	
	
	// Check boxes for user selection with mouse click
	if (((point_in_rectangle(mouse_x, mouse_y, chainFilterRectX1 + clipX, chainFilterRectY1 + clipY, chainFilterRectX2 + clipX, chainFilterRectY2 + clipY) and device_mouse_check_button_released(0, mb_left))
	or (keyboard_check_pressed(ord("P")) and !keyboard_check(vk_control) and currentChainState == obj_chain.chainStateFocus)) and not instance_exists(obj_dialogueBox)) {
		
		if (point_in_rectangle(mouse_x, mouse_y, x, y, x + windowWidth, y + windowHeight)) {
			// Record previous display row in case Filter is empty
			obj_control.prevCenterYDest = ds_grid_get(obj_control.filterGrid, obj_control.lineGrid_colUnitID, obj_control.currentCenterDisplayRow); // Shouldn't get in the of the other PrevRow check
			// Set selected objects to be filtered
			inFilter = !inFilter;
			ds_grid_set(grid, obj_chain.chainGrid_colInFilter, i, inFilter);
			
			// Render the filter in the mainscreen
			if (obj_control.filterGridActive) {
				with (obj_control) {
					scr_renderFilter();
				}
			}
			// Add to moveCounter
			obj_control.moveCounter ++;
		}
	}
	/*
	if (point_in_rectangle(mouse_x, mouse_y, chainFilterRectX1 + clipX, chainFilterRectY1 + clipY, chainFilterRectX2 + clipX, chainFilterRectY2 + clipY)) {
		draw_set_colour(global.colorThemeBG);
		draw_rectangle(mouse_x + 64, mouse_y - 16, mouse_x + 130, mouse_y + 16, false);
		draw_set_colour(global.colorThemeBorders);
		draw_rectangle(mouse_x + 64, mouse_y - 16, mouse_x + 130, mouse_y + 16, true);
		draw_set_colour(global.colorThemeText);
		draw_set_font(fnt_mainBold);
		draw_text(mouse_x + 72, mouse_y, "Filter");	
		draw_set_font(global.fontChainList);
	}
	*/
	
	
	
	// Create little boxes for alignment selection
	if (functionChainList_currentTab == functionChainList_tabRezBrush
	or functionChainList_currentTab == functionChainList_tabTrackBrush) {
		// Set dimensions for little boxes
		var chainAlignRectX1 = x + windowWidth - (filterRectSize * 2) - scrollBarWidth;//x + (filterRectMargin * 2) + filterRectSize - clipX;
		var chainAlignRectY1 = y + textMarginTop + textPlusY - (filterRectSize / 2) + scrollPlusY;
		var chainAlignRectX2 = chainAlignRectX1 + filterRectSize;
		var chainAlignRectY2 = chainAlignRectY1 + filterRectSize;
		var isAligned = ds_grid_get(grid, obj_chain.chainGrid_colAlign, i);
		
		//Check for user selection of alignment with mouse clicks
		if (point_in_rectangle(mouse_x, mouse_y, chainAlignRectX1, chainAlignRectY1, chainAlignRectX2, chainAlignRectY2)
		and point_in_rectangle(mouse_x, mouse_y, x, y, x + windowWidth, y + windowHeight)) {
			draw_set_alpha(0.5);
			draw_set_color(c_purple);
			draw_rectangle(chainAlignRectX1 - clipX, chainAlignRectY1 - clipY, chainAlignRectX2 - clipX, chainAlignRectY2 - clipY, false);
			if (device_mouse_check_button_released(0, mb_left)) {
				
				// Unselect alignment if already selected
				if (functionChainList_currentTab == functionChainList_tabTrackBrush and not isAligned) {
					scr_setAllValuesInCol(obj_chain.trackChainGrid, obj_chain.chainGrid_colAlign, false);
				}
				
				// Show alignments in main screen
				isAligned = !isAligned;
				if (isAligned) {
					with (obj_chain) {
						alarm[6] = 5;
						// Protect against RaceToInfinity
						chainIDRaceCheck = currentChainID;
					}
				}
				
				// Set alignment in grid
				ds_grid_set(grid, obj_chain.chainGrid_colAlign, i, isAligned);
			}
		}
	
		// Fill in selected boxes
		if (isAligned) {
			draw_sprite_ext(spr_align, 0, mean(chainAlignRectX1, chainAlignRectX2) - clipX, mean(chainAlignRectY1, chainAlignRectY2) - clipY, 1, 1, 0, c_white, 1);
		}
		else if (isAligned == -1) {
			draw_sprite_ext(spr_align, 1, mean(chainAlignRectX1, chainAlignRectX2) - clipX, mean(chainAlignRectY1, chainAlignRectY2) - clipY, 1, 1, 0, c_white, 0.5);
		}
		else {
			draw_sprite_ext(spr_align, 1, mean(chainAlignRectX1, chainAlignRectX2) - clipX, mean(chainAlignRectY1, chainAlignRectY2) - clipY, 1, 1, 0, c_white, 1);
		}
		
		draw_set_alpha(1);
	}
	
	
	
	
	
	

	
	// Get height of chain name
	textPlusY += strHeight;
}



var focusedChainRow = ds_grid_value_y(grid, obj_chain.chainGrid_colChainState, 0, obj_chain.chainGrid_colChainState, ds_grid_height(grid), obj_chain.chainStateFocus);
	
// Allows use of arrow keys, pgUp/pgDwn, and ctrl+key in chain list if clicked in chainList
if (clickedIn) {	
	if ((mouse_wheel_up() or keyboard_check(vk_up)) and (holdUp < 2 or holdUp > 30)) {
			
		if (focusedChainRow > 0 and focusedChainRow < ds_grid_height(grid)) {
			scr_unFocusAllChains();
			scr_setAllValuesInCol(obj_chain.linkGrid, obj_chain.linkGrid_colFocus, false); 
			focusedChainRow--;
			ds_grid_set(grid, obj_chain.chainGrid_colChainState, focusedChainRow, obj_chain.chainStateFocus);
				
			if (focusedElementY <= y + textMarginTop + strHeight) {
				scrollPlusYDest += max(abs(focusedElementY - (y + textMarginTop + strHeight)) + strHeight, strHeight);
			}
		}
		else {
			scrollPlusYDest += 4;
		}
	}
		
	if ((mouse_wheel_down() || keyboard_check(vk_down)) and (obj_panelPane.holdDown < 2 || obj_panelPane.holdDown > 30)) {
			
		if (focusedChainRow < ds_grid_height(grid) - 1 and focusedChainRow >= 0) {
			scr_unFocusAllChains();
			scr_setAllValuesInCol(obj_chain.linkGrid, obj_chain.linkGrid_colFocus, false); 
			focusedChainRow++;
			ds_grid_set(grid, obj_chain.chainGrid_colChainState, focusedChainRow, obj_chain.chainStateFocus);
				
			if (focusedElementY >= y + windowHeight - strHeight) {
				scrollPlusYDest -= max(abs(focusedElementY - (y + windowHeight - strHeight)) + strHeight, strHeight);
			}
		}
		else {
			scrollPlusYDest -= 4;
		}
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

if (focusedChainNameRectY1 > -1 and focusedChainNameRectY2 > -1) {
	draw_set_color(global.colorThemeBorders);
	for (var j = 0; j < 3; j++) {
		draw_rectangle(x + j - clipX, focusedChainNameRectY1 + j - clipY, x + windowWidth - j - clipX, focusedChainNameRectY2 - j - clipY, true);
	}
}




scr_scrollBar(ds_grid_height(grid), focusedElementY, strHeight, textMarginTop,
	global.colorThemeSelected1, global.colorThemeSelected2,
	global.colorThemeSelected1, global.colorThemeSelected2, spr_ascend, windowWidth, windowHeight);





scr_surfaceEnd();