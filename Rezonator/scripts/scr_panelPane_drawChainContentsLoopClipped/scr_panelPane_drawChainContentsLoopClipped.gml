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

var grid = obj_chain.rezChainGrid;

// Find current tab to draw correct contents
switch (functionChainList_currentTab) {
	case 0:
		grid = obj_chain.rezChainGrid;
		break;
	case 1:
		grid = obj_chain.trackChainGrid;
		break;
	case 2:
		grid = obj_chain.stackChainGrid;
		break;
	case 3:
		grid = obj_chain.cliqueDisplayGrid;
		break;
	default:
		grid = obj_chain.rezChainGrid;
		break;
}

// Set text margins
var textMarginTop = 32;
var textPlusY = 0;
var ableToBeMouseOver = true;

var alignTabWidth = 12;

// Create scroll bars
var scrollBarWidth = 16;
//draw_set_color(c_red);
//draw_rectangle(x + windowWidth - scrollBarWidth, y + (textMarginTop * 2), x + windowWidth, y + windowHeight, false);

var focusedChainExists = false;
var alignRectSize = 8;
var oldRow = -1;
//var olderRow = -1;


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