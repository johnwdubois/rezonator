/*
	scr_panelPane_drawChainListLoop();
	
	Last Updated: 2019-01-29
	
	Called from: obj_panelPane
	
	Purpose: draw the chains for whatever tab you are on, if a user clicks on a chain then focus it and
			set chainContents panelPane to look at that chain
	
	Mechanism: loop through chainGrid of whatever tab you are on and draw chainName
	
	Author: Terry DuBois, Georgio Klironomos
*/




draw_set_font(global.fontChainList);
var strHeight = string_height("0") * 1.5;

// Set text margin area
var filterRectMargin = 8;
var filterRectSize = (strHeight / 2) + 5;
var textMarginLeft = filterRectMargin + (filterRectSize * 2);

var textMarginTop = functionChainList_tabHeight;
var textPlusY = 0;
//var chainNameRectMinusY = 4;
var textAdjustY = 0;

var focusedElementY = -1;
var focusedLineNameRectY1 = -1;
var focusedLineNameRectY2 = -1;

var lineGridHeight = ds_grid_height(obj_control.lineGrid);

// Set opacity, font, and alignment of text chain lists
draw_set_alpha(1);
draw_set_halign(fa_left);
draw_set_valign(fa_middle);
draw_set_color(global.colorThemeText);

scr_surfaceStart();

//really super wanna set a draw range for this guy!!
var mouseInPane = obj_control.mouseoverPanelPane;
for (var i = 0; i < lineGridHeight; i++) {
	
	if (y + textMarginTop + scrollPlusY + textPlusY < y - strHeight) {
	//or y + textMarginTop + scrollPlusY + textPlusY > y + windowHeight + strHeight) {
		textPlusY += strHeight;
		continue;
	}
	if (y + textMarginTop + scrollPlusY + textPlusY > y + windowHeight + strHeight) {
			textPlusY += strHeight;
			break;
	}
	
	
	// Get grid info of current chain
	var currentLineUnitID = ds_grid_get(obj_control.lineGrid, obj_control.lineGrid_colUnitID, i);
	
	if (currentLineUnitID < 0) {
		continue;
	}
	
	var currentLineState = ds_grid_get(obj_control.lineGrid, obj_control.lineGrid_colLineState, i);
	var lineColor = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colParticipantColor, currentLineUnitID - 1); // Access color of line
	var lineSpeaker = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colParticipantName, currentLineUnitID - 1);
	// Prevent those pesky comments from showing up in the line list
	if (lineSpeaker == "COMMENT") {
		continue;
	}
	
	var discoColor = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colDiscoColor, currentLineUnitID - 1);
	if (discoColor == -1 or discoColor == 0) {
		discoColor = obj_control.c_ltblue;
	}

	var currentLineWordList = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colWordIDList, currentLineUnitID - 1);
	var currentLineWordString = "";
	var currentLineWordListSize = ds_list_size(currentLineWordList);
	for(var wordListLoop = 0; wordListLoop < currentLineWordListSize; wordListLoop++) {
		var currentWordID = ds_list_find_value(currentLineWordList, wordListLoop);
		var currentWordToken = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colWordToken, currentWordID - 1);
		currentLineWordString += string(currentWordToken) + " ";
	}
	
	if(string_height(currentLineWordString) > 20) {
		//strHeight = 20;
		textAdjustY = string_height(currentLineWordString) - 20;
	}
	
	// Get dimensions of rectangle around line name
	var lineNameRectX1 = x;
	var lineNameRectY1 = y + textMarginTop + textPlusY + scrollPlusY - (strHeight / 2);
	var lineNameRectX2 = x + windowWidth;
	var lineNameRectY2 = lineNameRectY1 + strHeight;
	
	scr_panelPane_mouseOnLine(lineNameRectX1, lineNameRectY1, lineNameRectX2, lineNameRectY2, lineGridHeight, i, lineColor);
	
	
	//Color codes the line lists for User
	draw_set_color(discoColor); //soften the color
	//draw_set_color(lineColor);
	draw_rectangle(lineNameRectX1 - clipX, lineNameRectY1 - clipY, lineNameRectX2 - clipX, lineNameRectY2 - clipY - 2, false);
	
	// Outline the rectangle in black
	if (currentLineState == 1) {
		focusedLineNameRectY1 = lineNameRectY1;
		focusedLineNameRectY2 = lineNameRectY2;
		focusedElementY = y + textMarginTop + scrollPlusY + textPlusY;
		draw_set_font(global.fontChainListFocused);
		//draw_set_font(global.fontMain);
	}
	else {
		draw_set_font(global.fontMain);
	}
	
	// Draw text of chain names
	draw_set_color(global.colorThemeText);
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	draw_text(floor(x + (textMarginLeft/2) - (string_width(currentLineUnitID) / 2)) - clipX, floor(y + textMarginTop + scrollPlusY + textPlusY) - clipY, string(currentLineUnitID));
	
	//Color codes the line lists for User
	draw_set_color(merge_color(lineColor, global.colorThemeBG, 0.4)); //soften the color
	//draw_set_color(lineColor);
	draw_rectangle(x + (textMarginLeft) - clipX, lineNameRectY1 - clipY, lineNameRectX2 - clipX, lineNameRectY2 - clipY - 2, false);
	draw_set_color(global.colorThemeText);
	draw_text(floor(x + (textMarginLeft) + 10) - clipX, floor(y + textMarginTop + scrollPlusY + textPlusY) - clipY, lineSpeaker);
	
	var textMarginLeftReal = (obj_control.showParticipantName) ? (windowWidth / 3) : textMarginLeft;
	
	//draw_set_color(merge_color(lineColor, global.colorThemeBG, 0.4)); //soften the color
	draw_set_color(global.colorThemeBG);
	draw_rectangle(textMarginLeftReal - 10, lineNameRectY1 - clipY, lineNameRectX2 - clipX, lineNameRectY2 - clipY - 2, false);
	draw_set_color(global.colorThemeBG);
	draw_line_width(textMarginLeftReal - 10, lineNameRectY1 - clipY, windowWidth/3 - 10, lineNameRectY2 - clipY - 2, 1);
	draw_set_color(global.colorThemeText);
	draw_text(floor(textMarginLeftReal), floor(y + textMarginTop + scrollPlusY + textPlusY + textAdjustY / 2) - clipY, currentLineWordString);
	
	
	
	// Get height of chain name
	textPlusY += strHeight;
}



//var focusedChainRow = ds_grid_value_y(grid, obj_chain.chainGrid_colChainState, 0, obj_chain.chainGrid_colChainState, ds_grid_height(grid), obj_chain.chainStateFocus);

// will create a focusedLine vriable in panelPane create, update it when changed, no gridValueY

// Allows use of arrow keys, pgUp/pgDwn, and ctrl+key in chain list if clicked in chainList
if (clickedIn) {	
	if ((mouse_wheel_up() or keyboard_check(vk_up)) and (holdUp < 2 or holdUp > 30)) {
			
		if (functionChainList_lineGridRowFocused > 0 and functionChainList_lineGridRowFocused < lineGridHeight) {

			//Allow for arrow keys to shift focus down the list of lines
			obj_panelPane.functionChainList_lineGridRowFocused--;
			var currentLineUnitID = ds_grid_get(obj_control.lineGrid, obj_control.lineGrid_colUnitID, obj_panelPane.functionChainList_lineGridRowFocused);
			var lineColor = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colParticipantColor, currentLineUnitID - 1);
			obj_panelPane.functionChainContents_BGColor = lineColor;
			ds_grid_set_region(obj_control.lineGrid, obj_control.lineGrid_colLineState, 0, obj_control.lineGrid_colLineState, lineGridHeight, 0);
			ds_grid_set(obj_control.lineGrid, obj_control.lineGrid_colLineState, obj_panelPane.functionChainList_lineGridRowFocused, 1);
			obj_panelPane.functionChainContents_lineGridRowFocused = -1;
			
		//	ds_grid_set(grid, obj_chain.chainGrid_colChainState, focusedChainRow, obj_chain.chainStateFocus);
			if (focusedElementY <= y + textMarginTop + strHeight) {
				scrollPlusYDest += max(abs(focusedElementY - (y + textMarginTop + strHeight)) + strHeight, strHeight);
			}
		}
		else {
			scrollPlusYDest += 4;
		}
	}
		
	if ((mouse_wheel_down() || keyboard_check(vk_down)) and (obj_panelPane.holdDown < 2 || obj_panelPane.holdDown > 30)) {
			
		if (functionChainList_lineGridRowFocused < lineGridHeight - 1 and functionChainList_lineGridRowFocused >= 0) {

			//Allow for arrow keys to shift focus down the list of lines
			obj_panelPane.functionChainList_lineGridRowFocused++;
			var currentLineUnitID = ds_grid_get(obj_control.lineGrid, obj_control.lineGrid_colUnitID, obj_panelPane.functionChainList_lineGridRowFocused);
			var lineColor = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colParticipantColor, currentLineUnitID - 1);
			obj_panelPane.functionChainContents_BGColor = lineColor;
			ds_grid_set_region(obj_control.lineGrid, obj_control.lineGrid_colLineState, 0, obj_control.lineGrid_colLineState, lineGridHeight, 0);
			ds_grid_set(obj_control.lineGrid, obj_control.lineGrid_colLineState, obj_panelPane.functionChainList_lineGridRowFocused, 1);
			obj_panelPane.functionChainContents_lineGridRowFocused = -1;
			
			//ds_grid_set(grid, obj_chain.chainGrid_colChainState, focusedChainRow, obj_chain.chainStateFocus);
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

if (focusedLineNameRectY1 > -1 and focusedLineNameRectY2 > -1) {
	draw_set_color(global.colorThemeBorders);
	for (var j = 0; j < 3; j++) {
		draw_rectangle(x + j - clipX, focusedLineNameRectY1 + j - clipY, x + windowWidth - j - clipX, focusedLineNameRectY2 - j - clipY, true);
	}
}




scr_scrollBar(lineGridHeight, focusedElementY, strHeight, textMarginTop,
	global.colorThemeSelected1, global.colorThemeSelected2,
	global.colorThemeSelected1, global.colorThemeSelected2, spr_ascend, windowWidth, windowHeight);






scr_surfaceEnd();