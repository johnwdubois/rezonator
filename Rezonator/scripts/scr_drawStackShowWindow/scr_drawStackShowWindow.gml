/*
	scr_panelPane_drawChainListLoop();
	
	Last Updated: 2019-01-29
	
	Called from: obj_panelPane
	
	Purpose: draw the chains for whatever tab you are on, if a user clicks on a chain then focus it and
			set chainContents panelPane to look at that chain
	
	Mechanism: loop through chainGrid of whatever tab you are on and draw chainName
	
	Author: Terry DuBois, Georgio Klironomos
*/

var grid = obj_chain.stackChainGrid;


// Set text margin area
var filterRectMargin = 8;
var filterRectSize = 8;
var textMarginLeft = 24;

var textMarginTop = 16;
var textPlusY = 0;
var chainNameRectMinusY = 4;

var focusedElementY = -1;

// Set opacity, font, and alignment of text chain lists
draw_set_alpha(1);
draw_set_halign(fa_left);
draw_set_valign(fa_middle);
draw_set_color(global.colorThemeText);
draw_set_font(global.fontChainList);
var strHeight = string_height("0");

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
	var chainNameRectX1 = x + textMarginLeft;
	var chainNameRectY1 = y + textMarginTop + textPlusY + scrollPlusY - (strHeight / 2);
	var chainNameRectX2 = chainNameRectX1 + string_width(currentChainName);
	var chainNameRectY2 = chainNameRectY1 + string_height(currentChainName) - chainNameRectMinusY;
	
		//Check mouse clicks to focus a chain in the list
	if (point_in_rectangle(mouse_x, mouse_y, chainNameRectX1, chainNameRectY1, chainNameRectX2, chainNameRectY2)
	and mouse_check_button_pressed(mb_left)) {
		
		// Unfocus chain if previously focused
		if (currentChainState == obj_chain.chainStateFocus) {
			currentChainState = obj_chain.chainStateNormal;
		}
		else {

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
		}
	}
	
	//Color codes the chain lists for User
	var chainColor = ds_grid_get(grid, obj_chain.chainGrid_colColor, i); // Access color of new chain
	var rectX1 = x + textMarginLeft - 2; // Create the colored rectangle
	var rectX2 = chainNameRectX2 + 5; //x + textMarginLeft + 50;

	if (currentChainState == obj_chain.chainStateFocus) {
		rectX1 = x;
	}
	draw_set_color(merge_color(chainColor, global.colorThemeBG, 0.65)); //soften the color
	draw_rectangle(rectX1 - clipX, y + textMarginTop + textPlusY + scrollPlusY - 9 - clipY, rectX2 - clipX, y + textMarginTop + textPlusY + scrollPlusY + 7 - clipY, false);
	
	// Outline the rectangle in black
	if (currentChainState == obj_chain.chainStateFocus) {
		draw_set_color(global.colorThemeBorders);
		draw_rectangle(rectX1 - clipX, y + textMarginTop + textPlusY + scrollPlusY - 9 - clipY, rectX2 - clipX, y + textMarginTop + textPlusY + scrollPlusY + 7 - clipY, true);
		
		focusedElementY = y + textMarginTop + scrollPlusY + textPlusY;
	}
	
	// Draw text of chain names
	draw_set_color(global.colorThemeText);
	draw_text(x + textMarginLeft - clipX, y + textMarginTop + scrollPlusY + textPlusY - clipY, currentChainName);
	
	// Draw little boxes for filter selection
	var chainFilterRectX1 = x + filterRectMargin - clipX;
	var chainFilterRectY1 = y + textMarginTop + scrollPlusY + textPlusY - (filterRectSize / 2) - clipY;
	var chainFilterRectX2 = chainFilterRectX1 + filterRectSize;
	var chainFilterRectY2 = chainFilterRectY1 + filterRectSize;
	var inFilter = ds_grid_get(grid, obj_chain.chainGrid_colInFilter, i);
	
	// Fill in boxes if filtered
	if (inFilter) {
		draw_rectangle(chainFilterRectX1, chainFilterRectY1, chainFilterRectX2, chainFilterRectY2, false);
	}
	else {
		draw_rectangle(chainFilterRectX1, chainFilterRectY1, chainFilterRectX2, chainFilterRectY2, true);
	}
	
	// Check boxes for user selection with mouse click
	if ((point_in_rectangle(mouse_x, mouse_y, chainFilterRectX1 + clipX, chainFilterRectY1 + clipY, chainFilterRectX2 + clipX, chainFilterRectY2 + clipY) and mouse_check_button_pressed(mb_left))
	or (keyboard_check_pressed(ord("P")) and !keyboard_check(vk_control) and currentChainState == obj_chain.chainStateFocus)) {
		// Record previous display row in case Filter is empty
		obj_control.prevCenterDisplayRow = obj_control.scrollPlusYDest; //ds_grid_get(obj_control.filterGrid, obj_control.lineGrid_colUnitID, obj_control.currentCenterDisplayRow); // Shouldn't get in the of the other PrevRow check
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
	
	
	// Get height of chain name
	textPlusY += strHeight;
}



var focusedChainRow = ds_grid_value_y(grid, obj_chain.chainGrid_colChainState, 0, obj_chain.chainGrid_colChainState, ds_grid_height(grid), obj_chain.chainStateFocus);
	
// Allows use of arrow keys, pgUp/pgDwn, and ctrl+key in chain list if clicked in chainList
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




scr_scrollBar(ds_grid_height(grid), focusedElementY, strHeight, 0,
	global.colorThemeSelected1, global.colorThemeSelected2,
	global.colorThemeSelected1, global.colorThemeSelected2, spr_ascend, windowWidth, windowHeight);





scr_surfaceEnd();