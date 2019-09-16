/*
	scr_drawLine();
	
	Last Updated: 2018-07-12
	
	Called from: obj_control
	
	Purpose: draws words and lines from the lineGrid that are within the drawRange
	
	Mechanism: loop through the lineGrid (only loop through necessary lines) and get wordIDList from each line, then draw out those words
	
	Author: Terry DuBois
*/



if (gridView || ds_grid_height(dynamicWordGrid) < 1) {
	exit;
}

scr_setSpeakerLabelColWidth();

ds_grid_set_region(wordDrawGrid, wordDrawGrid_colVisible, 0, wordDrawGrid_colVisible, ds_grid_height(wordDrawGrid), false);

// set draw variables for column text
draw_set_font(global.fontMain);
draw_set_halign(fa_left);
draw_set_valign(fa_middle);
draw_set_color(global.colorThemeText);
draw_set_alpha(1);


drawLineYOffset = 0;
if (filterGridActive) {
	drawLineYOffset = (camera_get_view_height(view_camera[0]) / 2) - 200;
}

var menuBarHeight = 0;
if (instance_exists(obj_menuBar)) {
	menuBarHeight = obj_menuBar.menuHeight;
}
var chainListHeight = 0;
with (obj_panelPane) {
	if (currentFunction == functionChainList) {
		chainListHeight = windowHeight;
	}
}


wordTopMargin = menuBarHeight + chainListHeight;
if (global.wheresElmo || global.rezzles) {
	wordTopMargin += 80;
}


scr_setDrawRange();
ds_grid_set_grid_region(currentActiveLineGrid, currentActiveLineGrid, lineGrid_colPixelYOriginal, 0, lineGrid_colPixelYOriginal, ds_grid_height(currentActiveLineGrid), lineGrid_colPixelY, 0);
ds_grid_add_region(currentActiveLineGrid, lineGrid_colPixelY, 0, lineGrid_colPixelY, ds_grid_height(currentActiveLineGrid), (scrollPlusY + wordTopMargin + 10));




// draw out of bounds rectangles on top & bottom of discourse
if (drawRangeStart == 0 and ds_grid_height(currentActiveLineGrid) > 0) {
	//var firstLinePixelY = ds_grid_get(currentActiveLineGrid, obj_control.lineGrid_colPixelY, 0);
	draw_set_color(global.colorThemeOutOfBounds);
	//draw_rectangle(0, 0, room_width, firstLinePixelY - (obj_control.gridSpaceVertical / 2), false);
	var oobTopRectY2 = wordTopMargin;
	if (ds_grid_height(currentActiveLineGrid) > 0) {
		var lowestY = ds_grid_get(currentActiveLineGrid, lineGrid_colPixelY, 0) - (gridSpaceVertical / 2) - 10;
		oobTopRectY2 = clamp(wordTopMargin, 0, lowestY);
	}
	draw_rectangle(0, 0, room_width, oobTopRectY2, false);
}
if (drawRangeEnd == ds_grid_height(currentActiveLineGrid) - 1 and ds_grid_height(currentActiveLineGrid) > 0) {
	var lastLinePixelY = ds_grid_get(currentActiveLineGrid, obj_control.lineGrid_colPixelY, ds_grid_height(currentActiveLineGrid) - 1);
	draw_set_color(global.colorThemeOutOfBounds);
	draw_rectangle(0, lastLinePixelY + (obj_control.gridSpaceVertical / 2), room_width, room_height, false);
}



// get speakerLabelMargin
speakerLabelMargin = ds_list_find_value(obj_control.speakerLabelColXList, ds_list_size(obj_control.speakerLabelColXList) - 1);
if (speakerLabelColXHolding > -1) {
	wordLeftMargin = speakerLabelMargin + 20;
}


if (speakerLabelColXHolding > -1) {
	mouseoverPanelPane = true;
}

if (not mouseoverPanelPane and not global.wheresElmo) {
	if (point_in_rectangle(mouse_x, mouse_y, 0, wordTopMargin, speakerLabelMargin, camera_get_view_height(view_camera[0]))) {
	
		if (mouse_check_button_pressed(mb_left) or mouse_check_button_released(mb_left)) {
			if (ds_grid_value_exists(obj_chain.rezChainGrid, obj_chain.chainGrid_colChainState, 0, obj_chain.chainGrid_colChainState, ds_grid_height(obj_chain.rezChainGrid), obj_chain.chainStateFocus)
			or ds_grid_value_exists(obj_chain.trackChainGrid, obj_chain.chainGrid_colChainState, 0, obj_chain.chainGrid_colChainState, ds_grid_height(obj_chain.trackChainGrid), obj_chain.chainStateFocus)) {
				with (obj_chain) {
					scr_chainDeselect();
					scr_refreshVizLinkGrid();
				}
			}
			obj_toolPane.currentTool = obj_toolPane.toolStackBrush;
		}
	}
	else {
	
		if (mouse_check_button_pressed(mb_left) or mouse_check_button_released(mb_left)) {
			if (ds_grid_value_exists(obj_chain.stackChainGrid, obj_chain.chainGrid_colChainState, 0, obj_chain.chainGrid_colChainState, ds_grid_height(obj_chain.stackChainGrid), obj_chain.chainStateFocus)) {
				with (obj_chain) {
					scr_chainDeselect();
					scr_refreshVizLinkGrid();
				}
			}
		}
	
		if ((mouse_check_button(mb_left) or mouse_check_button_released(mb_left)) and not mouseoverNeutralSpace) {
			if (obj_toolPane.currentMode == obj_toolPane.modeRez or obj_toolPane.currentMode == obj_toolPane.modePointer) {
				obj_toolPane.currentTool = obj_toolPane.toolRezBrush;
			}
			else {
				obj_toolPane.currentTool = obj_toolPane.toolTrackBrush;
			}
		}
	}
}



// draw out of bounds rectangle on left
if (obj_control.wordLeftMargin > obj_control.speakerLabelMargin) {
	draw_set_color(global.colorThemeOutOfBounds);
	var leftOutOfBoundsRectX1 = obj_control.speakerLabelMargin;
	var leftOutOfBoundsRectY1 = 0;
	var leftOutOfBoundsRectX2 = obj_control.wordLeftMargin - 20;
	var leftOutOfBoundsRectY2 = camera_get_view_height(view_camera[0]);


	if (currentActiveLineGrid == searchGrid) {
		leftOutOfBoundsRectX2 = leftScreenBound;
	}
	
	if (abs(leftOutOfBoundsRectX1 - leftOutOfBoundsRectX2) > 2) {
		draw_rectangle(leftOutOfBoundsRectX1, leftOutOfBoundsRectY1, leftOutOfBoundsRectX2, leftOutOfBoundsRectY2, false);
	}
}

draw_set_color(global.colorThemeText);

obj_control.leftScreenBound = camera_get_view_width(view_camera[0]);

hoverWordID = -1;
hoverChunkID = -1;
//clickedChunkID = -1;

// for every row in lineGrid from drawRangeStart to drawRangeEnd, draw the words in that line
for (var drawLineLoop = drawRangeStart; drawLineLoop <= drawRangeEnd; drawLineLoop++) {
	if (drawLineLoop < 0 or drawLineLoop >= ds_grid_height(currentActiveLineGrid)) {
		continue;
	}
	
	var currentWordIDList = ds_grid_get(currentActiveLineGrid, lineGrid_colWordIDList, drawLineLoop);
	
	// get & set the correct pixel-Y value for each line
	var currentLineY = ds_grid_get(currentActiveLineGrid, lineGrid_colPixelY, drawLineLoop);
	// Adapt to dynamic line height
	//currentLineY *= (obj_control.gridSpaceVertical/33.4);
	
	
	// set speaker label stuff up
	speakerRectX1 = 0;
	speakerRectY1 = currentLineY - (gridSpaceVertical / 2);
	speakerRectX2 = speakerLabelMargin;
	speakerRectY2 = speakerRectY1 + gridSpaceVertical;
	
	
	var unitID = ds_grid_get(currentActiveLineGrid, lineGrid_colUnitID, drawLineLoop);
	var currentDiscoID = ds_grid_get(currentActiveLineGrid, lineGrid_colDiscoID, drawLineLoop);
	var currentLineNumberLabel = ds_grid_get(currentActiveLineGrid, lineGrid_colLineNumberLabel, drawLineLoop);
	
	
	
	
	
	
	
	
	
	
	var mouseRectExists = (abs(obj_control.mouseHoldRectY1 - obj_control.mouseHoldRectY2) > 5);
	if ((obj_toolPane.currentTool == obj_toolPane.toolStackBrush) and mouseRectMade and not mouseoverPanelPane and !instance_exists(obj_stackShow) and !instance_exists(obj_dialogueBox)) {
		inMouseHoldRect = rectangle_in_rectangle(speakerRectX1, speakerRectY1, speakerRectX2, speakerRectY2, min(mouseHoldRectX1, mouseHoldRectX2), min(mouseHoldRectY1, mouseHoldRectY2), max(mouseHoldRectX1, mouseHoldRectX2), max(mouseHoldRectY1, mouseHoldRectY2));
		if (inMouseHoldRect) {
			with (obj_control) {
				if (ds_list_find_index(inRectUnitIDList, unitID) == -1) {
					ds_list_add(inRectUnitIDList, unitID);
				}
			}
		}
	}
	else if((obj_toolPane.currentTool == obj_toolPane.toolStackBrush) and not mouseoverPanelPane and (window_get_cursor() != cr_size_we) and point_in_rectangle(mouse_x, mouse_y, speakerRectX1, speakerRectY1, speakerRectX2, speakerRectY2)) {
			if ((device_mouse_check_button_released(0, mb_left) and !obj_chain.inRezPlay) and (not mouseRectExists and touchReleaseCheck) and !instance_exists(obj_stackShow) and not obj_control.speakerLabelHoldingDelay) {
				var currentWordID = ds_list_find_value(currentWordIDList, 0);
				with (obj_chain) {
					scr_wordClicked(currentWordID, unitID);
				}
			}
		}

	
	
	var currentLineInStack = -1;
	if (mouse_y > speakerRectY1 and mouse_y < speakerRectY2 and not obj_control.rectNotInPanelPane) {
		obj_control.lineContainsMouseYPos = speakerRectY1;	
	}
	
	if (ds_grid_height(obj_chain.unitInStackGrid) == ds_grid_height(obj_control.unitGrid)) {
		currentLineInStack = ds_grid_get(obj_chain.unitInStackGrid, obj_chain.unitInStackGrid_colStack, unitID - 1);
	}

	
	// draw stack rectangle if this line is in a stack
	if (currentLineInStack > -1) {
		
			var currentStackChainID = currentLineInStack;
			var rowInStackChainGrid = ds_grid_value_y(obj_chain.stackChainGrid, obj_chain.chainGrid_colChainID, 0, obj_chain.chainGrid_colChainID, ds_grid_height(obj_chain.stackChainGrid), currentStackChainID);
			
			var stackColor = ds_grid_get(obj_chain.stackChainGrid, obj_chain.chainGrid_colColor, rowInStackChainGrid);
			
			if (typeof(stackColor) == "number") {
		
				draw_set_color(stackColor);
				draw_set_alpha(0.2);
			
				var stackRectWidth = (room_width - speakerRectX2);
				var stackRectX1 = speakerRectX2;
				var stackRectY1 = speakerRectY1;
				var stackRectX2 = room_width;
				var stackRectY2 = speakerRectY2;
			
				draw_rectangle(stackRectX1, stackRectY1, stackRectX2, stackRectY2, false);
			}
	}
	else {
		if (ds_list_size(inRectUnitIDList) > 0) {
			if (ds_list_find_index(inRectUnitIDList, unitID) > -1) {
				if (ds_grid_height(obj_chain.stackChainGrid) > 0) {
					var focusedStackRow = ds_grid_value_y(obj_chain.stackChainGrid, obj_chain.chainGrid_colChainState, 0, obj_chain.chainGrid_colChainState, ds_grid_height(obj_chain.stackChainGrid), obj_chain.chainStateFocus);
					if (focusedStackRow >= 0 and focusedStackRow < ds_grid_height(obj_chain.stackChainGrid)) {
						var stackColor = ds_grid_get(obj_chain.stackChainGrid, obj_chain.chainGrid_colColor, focusedStackRow);
						var stackRectWidth = (room_width - speakerRectX2);
						var stackRectX1 = speakerRectX2 + (stackRectWidth);
						var stackRectY1 = speakerRectY1;
						var stackRectX2 = room_width;
						var stackRectY2 = speakerRectY2;
						
						draw_set_color(stackColor);
						draw_set_alpha(0.2);
						
						draw_rectangle(stackRectX1, stackRectY1, stackRectX2, stackRectY2, false);
					}
				}
			}
		}
	}
	
	
	
	
	
	
	
	
	
	// Set the opacity of the Highlight
	if(currentActiveLineGrid == obj_control.searchGrid) {
		highlightedSearchRowAlpha = 0.3;
	}
	else {
		highlightedSearchRowAlpha -= 0.00005;
	}
	highlightedSearchRowAlpha = max(0, highlightedSearchRowAlpha);
	
	// Highlight last clicked word in Search view
	if(unitID == highlightedSearchRow) {
		draw_set_color(global.colorThemeHighlight);
		draw_set_alpha(highlightedSearchRowAlpha);
			
		var highlightRectX1 = speakerRectX2;
		var highlightRectY1 = speakerRectY1;
		var highlightRectX2 = room_width;
		var highlightRectY2 = speakerRectY2;
		
		draw_rectangle(highlightRectX1, highlightRectY1, highlightRectX2, highlightRectY2, false);
	}
	
	/*Draw quickstack highlights here */
	if (!obj_chain.inRezPlay) {
		if ((obj_toolPane.currentTool == obj_toolPane.toolStackBrush) and mouse_check_button(mb_left) and !instance_exists(obj_dialogueBox) and !instance_exists(obj_stackShow)) {
		
			var inMouseRect = rectangle_in_rectangle(0, speakerRectY1, room_width, speakerRectY2, min(mouseHoldRectX1, mouseHoldRectX2), min(mouseHoldRectY1, mouseHoldRectY2), max(mouseHoldRectX1, mouseHoldRectX2), max(mouseHoldRectY1, mouseHoldRectY2));
			if (inMouseRect and speakerLabelColXHolding == -1) {
				draw_set_color(c_ltblue);
				draw_set_alpha(0.3);
			
				var quickStackRectX1 = speakerRectX2;
				var quickStackRectY1 = speakerRectY1;
				var quickStackRectX2 = room_width;
				var quickStackRectY2 = speakerRectY2;
		
				draw_rectangle(quickStackRectX1, quickStackRectY1, quickStackRectX2, quickStackRectY2, false);
			}
		}
	}
		
	var previousWordDisplayCol = -1;
	
	// draw hits if in search view, otherwise draw words for this line
	if (searchGridActive) {
		scr_drawLineHitIDListLoop(currentWordIDList, previousWordDisplayCol, currentLineY, drawLineLoop, unitID);
	}
	else {
		scr_drawLineWordIDListLoop(currentWordIDList, previousWordDisplayCol, currentLineY, drawLineLoop, unitID);
	}
	
	

	
	var participantColor = ds_grid_get(unitGrid, unitGrid_colParticipantColor, unitID - 1);
	var participantName = ds_grid_get(unitGrid, unitGrid_colParticipantName, unitID - 1);
	draw_set_alpha(1);
	draw_set_halign(fa_left);
	draw_set_color(participantColor);
	var speakerLabelTextBuffer = 3;
	
	scr_drawSpeakerLabel(unitID, currentDiscoID, currentLineNumberLabel, participantName, participantColor, speakerLabelTextBuffer);
}

// show draw range of lines if development variables are on
if (showDevVars) {
	draw_set_alpha(1);
	draw_set_font(fnt_debug);
	draw_set_halign(fa_right);
	draw_text(room_width - 300, 250, "drawRange: " + string(drawRangeStart) + " ... " + string(drawRangeEnd));
	draw_text(room_width - 300, 265, "camY range: " + string(camera_get_view_y(view_camera[0]) + camera_get_view_height(view_camera[0])));
	
	draw_text(mouse_x, mouse_y, "(" + string(mouse_x) + ", " + string(mouse_y) + ")");
}