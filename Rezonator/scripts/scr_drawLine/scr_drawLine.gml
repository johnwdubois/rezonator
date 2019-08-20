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

scr_setDrawRange();
ds_grid_set_grid_region(currentActiveLineGrid, currentActiveLineGrid, lineGrid_colPixelYOriginal, 0, lineGrid_colPixelYOriginal, ds_grid_height(currentActiveLineGrid), lineGrid_colPixelY, 0);
ds_grid_add_region(currentActiveLineGrid, lineGrid_colPixelY, 0, lineGrid_colPixelY, ds_grid_height(currentActiveLineGrid), (scrollPlusY + 150 + drawLineYOffset));




// draw out of bounds rectangles on top & bottom of discourse
if (drawRangeStart == 0 and ds_grid_height(currentActiveLineGrid) > 0) {
	var firstLinePixelY = ds_grid_get(currentActiveLineGrid, obj_control.lineGrid_colPixelY, 0);
	draw_set_color(global.colorThemeOutOfBounds);
	draw_rectangle(0, 0, room_width, firstLinePixelY - (obj_control.gridSpaceVertical / 2), false);
}
if (drawRangeEnd == ds_grid_height(currentActiveLineGrid) - 1 and ds_grid_height(currentActiveLineGrid) > 0) {
	var lastLinePixelY = ds_grid_get(currentActiveLineGrid, obj_control.lineGrid_colPixelY, ds_grid_height(currentActiveLineGrid) - 1);
	draw_set_color(global.colorThemeOutOfBounds);
	draw_rectangle(0, lastLinePixelY + (obj_control.gridSpaceVertical / 2), room_width, room_height, false);
}

// draw out of bounds rectangle on left
if (obj_control.wordLeftMargin > obj_control.speakerLabelMargin + obj_control.speakerLabelMarginBuffer) {
	draw_set_color(global.colorThemeOutOfBounds);
	var leftOutOfBoundsRectX1 = obj_control.speakerLabelMargin - obj_control.speakerLabelMarginBuffer;
	var leftOutOfBoundsRectY1 = 0;
	var leftOutOfBoundsRectX2 = obj_control.wordLeftMargin - obj_control.speakerLabelMarginBuffer;
	var leftOutOfBoundsRectY2 = room_height;

	if (currentActiveLineGrid == searchGrid) {
		leftOutOfBoundsRectX2 = leftScreenBound;
	}
	
	draw_rectangle(leftOutOfBoundsRectX1, leftOutOfBoundsRectY1, leftOutOfBoundsRectX2, leftOutOfBoundsRectY2, false);
}

draw_set_color(global.colorThemeText);

obj_control.leftScreenBound = room_width;

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
	var speakerRectX1 = 0;
	var speakerRectY1 = currentLineY - (gridSpaceVertical / 2);
	var speakerRectX2 = speakerLabelMargin - speakerLabelMarginBuffer;
	var speakerRectY2 = speakerRectY1 + gridSpaceVertical;
	
	var unitID = ds_grid_get(currentActiveLineGrid, lineGrid_colUnitID, drawLineLoop);
	var currentDiscoID = ds_grid_get(currentActiveLineGrid, lineGrid_colDiscoID, drawLineLoop);
	var currentLineNumberLabel = ds_grid_get(currentActiveLineGrid, lineGrid_colLineNumberLabel, drawLineLoop);
	
	var currentLineInStack = -1;
	
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
		if ((obj_toolPane.currentTool == obj_toolPane.toolStackBrush) and mouse_check_button(mb_left) and !instance_exists(obj_dialogueBox)) {
		
			var inMouseRect = rectangle_in_rectangle(0, speakerRectY1, room_width, speakerRectY2, min(mouseHoldRectX1, mouseHoldRectX2), min(mouseHoldRectY1, mouseHoldRectY2), max(mouseHoldRectX1, mouseHoldRectX2), max(mouseHoldRectY1, mouseHoldRectY2));
			if (inMouseRect) {
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
	
	
	// draw speaker label parts
	var speakerLabelPlusX = 0;
	for (var i = 0; i < 3; i++) {
		if (i == 0 and ds_grid_height(global.fileLineRipGrid) < 2) {
			continue;
		}
		
		if (!obj_control.showLineNumber and i != 2) {
			continue;
		}
		
		var speakerLabelCurrentColX1 = speakerLabelPlusX;
		var speakerLabelCurrentColY1 = speakerRectY1;
		var speakerLabelCurrentColX2 = speakerLabelCurrentColX1 + speakerLabelColWidth[i];
		var speakerLabelCurrentColY2 = speakerRectY2;
		
		draw_set_color(participantColor);
		draw_rectangle(speakerLabelCurrentColX1, speakerLabelCurrentColY1, speakerLabelCurrentColX2, speakerLabelCurrentColY2, false);
		draw_set_color(global.colorThemeBG);
		draw_rectangle(speakerLabelCurrentColX1, speakerLabelCurrentColY1, speakerLabelCurrentColX2, speakerLabelCurrentColY2, true);
		
		var speakerLabelCurrentColStr = "";
		if (i == 0 and currentDiscoID != undefined) {
			speakerLabelCurrentColStr = string(currentDiscoID);
		}
		else if (i == 1 and currentLineNumberLabel != undefined) {
			speakerLabelCurrentColStr = string(currentLineNumberLabel);
		}
		
		if (i == 2 and participantName != undefined) {
			speakerLabelCurrentColStr = string(participantName);
			if (showDevVars) {
				speakerLabelCurrentColStr = string(currentLineY);
			}

			while (string_width(speakerLabelCurrentColStr) > obj_control.speakerLabelColWidth[2]) {
				speakerLabelCurrentColStr = string_delete(speakerLabelCurrentColStr, string_length(speakerLabelCurrentColStr) - 1, 2);
			}
		}
		
		if (point_in_rectangle(mouse_x, mouse_y,speakerLabelCurrentColX1, speakerLabelCurrentColY1, speakerLabelCurrentColX2, speakerLabelCurrentColY2)
		and mouse_check_button_pressed(mb_right) and not instance_exists(obj_dialogueBox)  and not instance_exists(obj_dropDown) and !obj_control.mouseoverPanelPane){
			//show_message("clicked here" + string(drawLineLoop));
				
			var dropDownOptionList = ds_list_create();
			
			obj_control.swapLinePos1 = unitID;

			ds_list_add(dropDownOptionList, "Swap", "Shuffle", "Toggle line #", "Reset Order", "Check Order");

			if (ds_list_size(dropDownOptionList) > 0 and obj_control.ableToCreateDropDown) {
				var dropDownInst = instance_create_depth(mouse_x, mouse_y, -999, obj_dropDown);
				dropDownInst.optionList = dropDownOptionList;
				dropDownInst.optionListType = 3;
					
				obj_control.ableToCreateDropDown = false;
				obj_control.alarm[0] = 2;
			}
			
		}
		draw_set_color(global.colorThemeText);
		draw_text(speakerLabelCurrentColX1 + speakerLabelTextBuffer, mean(speakerLabelCurrentColY1, speakerLabelCurrentColY2), speakerLabelCurrentColStr);
		if (obj_control.showLineNumber) {
			speakerLabelPlusX += speakerLabelColWidth[i];
		}
		
	}
	
	/*
	if (point_in_rectangle(mouse_x, mouse_y, 0, speakerRectY1, camera_get_view_width(view_camera[0]), speakerRectY2)) {
		if (keyboard_check_pressed(vk_space)) {
			
			var audioFile = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colAudioFile, unitID - 1);
			
			audio_stop_all();
			
			if (file_exists(audioFile)) {
				var unitStart = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colUnitStart, unitID - 1);
				var unitEnd = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colUnitEnd, unitID - 1);
				
				obj_control.audioTrackStream = audio_create_stream(audioFile);
				obj_control.audioTrackIndex = audio_play_sound(obj_control.audioTrackStream, 0, true);
				audio_sound_set_track_position(obj_control.audioTrackIndex, unitStart);
			}
		}
	}
	*/
	
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