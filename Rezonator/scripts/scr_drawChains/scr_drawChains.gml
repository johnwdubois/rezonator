function scr_drawChains() {

	/*
		Purpose: draw rezChains and move words on screen according to the rezChains
	*/
	
	scr_setMouseLineWordID();

	var lineX1 = undefined;
	var lineY1 = undefined;
	var lineX2 = undefined;
	var lineY2 = undefined;
	var mouseLineX = undefined;
	var mouseLineY = undefined;

	var minWordWidth = 9999999;
	var linePlusX = 0;

	var currentWordStringHeight1 = string_height("0");
	var currentWordStringHeight2 = currentWordStringHeight1;

	var wordTopMargin = obj_control.wordTopMargin;
	var rezChainList = ds_map_find_value(global.nodeMap, "resonanceList");
	var rezChainListSize = ds_list_size(rezChainList);
	var activeLineGridHeight = ds_grid_height(obj_control.currentActiveLineGrid);
	var arrowSize = 0.3 + (0.1 * global.fontSize / 5);
	var camHeight = camera_get_view_height(camera_get_active());
	
	var justifyLeft = (obj_control.justify == obj_control.justifyLeft);
	var prose = (obj_control.shape == obj_control.shapeText);

	// loop through rezChainList to get chain info
	var chainShowListSize = ds_list_size(obj_chain.chainShowList);
	for (var i = 0; i < chainShowListSize; i++) {
		minWordWidth = 9999999;
		
		var currentChainID = ds_list_find_value(obj_chain.chainShowList, i);
		
		// skip this chain if we can't find it in the nodeMap
		if (!ds_map_exists(global.nodeMap, currentChainID)) continue;
		
		// make sure this chain's subMap exists and that it is actually a map
		var currentChainSubMap = ds_map_find_value(global.nodeMap, currentChainID);
		if (!scr_isNumericAndExists(currentChainSubMap, ds_type_map)) continue;
		
		// get chain's setIDList and make sure it exists
		var chainType = ds_map_find_value(currentChainSubMap, "type");
		//var currentSetIDList = ds_map_find_value(currentChainSubMap, "vizSetIDList");
		var currentSetIDList = obj_chain.chainShowMap[? currentChainID];
		var currentVizSetIDList = ds_map_find_value(currentChainSubMap, "vizSetIDList");
		
		if (!scr_isNumericAndExists(currentSetIDList, ds_type_list)) continue;
		var currentSetIDListSize = ds_list_size(currentSetIDList);
		var currentChainColor = ds_map_find_value(currentChainSubMap, "chainColor");
		var currentChainVisible = ds_map_find_value(currentChainSubMap, "visible");
		
		// make sure this is a rezChain or trackChain and that we should be drawing it
		if (chainType != "resonance" && chainType != "trail") continue;
		var showRezBorder = false;
		var showTrackBorder = false;
		if (currentChainVisible) {
			if (chainType == "resonance") showRezBorder = true;
			else if (chainType == "trail") showTrackBorder = true;
		}

	
		var tokensInSameLine = false;
		var firstTokenInLine = "";
		var token2IsChunk = false;
		
	
		// loop through current chain's wordIDList to draw the lines of the chain
		for (var j = 0; j < currentSetIDListSize + 1; j++) {
			
			var currentEntry1 = "";
			var currentEntry2 = "";
			
			// get the wordIDs for the 2 words we want to draw a line between
			if (j == 0) {
				currentEntry2 = currentSetIDList[| 0];
				var vizSetIndex = ds_list_find_index(currentVizSetIDList, currentEntry2);
				if (vizSetIndex >= 1) {
					currentEntry1 = currentVizSetIDList[| vizSetIndex - 1];
				}
			}
			else if (j >= 1 && j < currentSetIDListSize) {
				currentEntry1 = currentSetIDList[| j - 1];
				currentEntry2 = currentSetIDList[| j];
			}
			else {
				currentEntry1 = currentSetIDList[| currentSetIDListSize - 1];
				var vizSetIndex = ds_list_find_index(currentVizSetIDList, currentEntry1);
				if (vizSetIndex < ds_list_size(currentVizSetIDList) - 1) {
					currentEntry2 = currentVizSetIDList[| vizSetIndex + 1];
				}
			}
			
			
			var currentEntry1SubMap = global.nodeMap[? currentEntry1];
			var currentEntry2SubMap = global.nodeMap[? currentEntry2];
			
			
			
			
			if (!scr_isNumericAndExists(currentEntry1SubMap, ds_type_map)) continue;
			if (!scr_isNumericAndExists(currentEntry2SubMap, ds_type_map)) continue;
			
			var currentTokenID1 = currentEntry1SubMap[? "token"];
			var currentTokenID2 = currentEntry2SubMap[? "token"];
			
			// if this token is a chunk, we will just draw the line coming out of the chunk's first token
			if (scr_isChunk(currentTokenID1)) currentTokenID1 = scr_getFirstWordOfChunk(currentTokenID1);
			if (scr_isChunk(currentTokenID2)) currentTokenID2 = scr_getFirstWordOfChunk(currentTokenID2);

			
			// get tokenSubMaps
			var currentToken1SubMap = global.nodeMap[? currentTokenID1];
			var currentToken2SubMap = global.nodeMap[? currentTokenID2];
			if (!scr_isNumericAndExists(currentToken1SubMap, ds_type_map)) { show_debug_message("scr_drawChains ... currentToken1SubMap does not exist") continue;}
			if (!scr_isNumericAndExists(currentToken2SubMap, ds_type_map)){ show_debug_message("scr_drawChains ... currentToken2SubMap does not exist") continue;}
			
			// get stretches
			var stretch1 = currentEntry1SubMap[? "stretch"];
			var stretch2 = currentEntry2SubMap[? "stretch"];
				
			// get tokenTagSubMaps
			var currentTagSubMap1 = currentToken1SubMap[? "tagMap"];
			var currentTagSubMap2 = currentToken2SubMap[? "tagMap"];		
	
			
			// get unit IDs
			var tokenUnitID1 = currentToken1SubMap[? "unit"];
			var	tokenUnitID2 = currentToken2SubMap[? "unit"];
			
			// get token's Unit's subMap
			var tokenUnitID1SubMap = global.nodeMap[? tokenUnitID1];
			var tokenUnitID2SubMap = global.nodeMap[? tokenUnitID2];
			
			
			lineY1 = tokenUnitID1SubMap[?"pixelY"];
			//if (lineY1 < 0 or lineY1 > camHeight) continue;
			
			lineX1 = currentToken1SubMap[?"pixelX"];
			
			
			// check if the units are active
			var unit1Active = tokenUnitID1SubMap[? "active"];
			var unit2Active = tokenUnitID2SubMap[? "active"];
			
			// get the width of each token
			var currentWordStringWidth1 = string_width(string(currentTagSubMap1[? global.displayTokenField]));
			var currentWordStringWidth2 = string_width(string(currentTagSubMap2[? global.displayTokenField]));
		

		
	
			var sideLink = false;
			
			// check if this is a side link
			if (tokenUnitID1 == tokenUnitID2) {
				tokensInSameLine = true;
				// if we have not set the first word in the line yet, set it to be this one
				if (firstTokenInLine == "") {
					firstTokenInLine = currentTokenID1;
				}
				sideLink = true;
			}
			else {
				if (tokensInSameLine and firstTokenInLine != "") {
					currentTokenID1 = firstTokenInLine;
					currentToken1SubMap = global.nodeMap[? currentTokenID1];
					tokenUnitID1 = currentToken1SubMap[?"unit"];
					currentTagSubMap1 = currentToken1SubMap[? "tagMap"];
					tokenUnitID1SubMap = global.nodeMap[?tokenUnitID1];
		
					currentWordStringWidth1 = string_width(string(currentTagSubMap1[?global.displayTokenField]));
		
					lineX1 = currentToken1SubMap[?"pixelX"];
					lineY1 = tokenUnitID1SubMap[?"pixelY"];
				}
			
				firstTokenInLine = "";
			}
		
			// get the pixel X values for each token
			lineX2 = currentToken2SubMap[?"pixelX"];
			lineY2 = tokenUnitID2SubMap[? "pixelY"];
		

			
			// check if these y values are in our draw range
			var inDrawRange1 = !(lineY1 < wordTopMargin + (-obj_control.gridSpaceVertical * 2) and lineY2 < wordTopMargin + (-obj_control.gridSpaceVertical * 2));
			var inDrawRange2 = !(lineY1 > camHeight + (obj_control.gridSpaceVertical * 2) and lineY2 > camHeight + (obj_control.gridSpaceVertical * 2));
		 
			// only draw line if every value is real and we are in the draw range
			if (is_numeric(lineX1) && is_numeric(lineY1) && is_numeric(lineX2) && is_numeric(lineY2)
			&& unit1Active && unit2Active && inDrawRange1 && inDrawRange2) {
				
				var centerX1 = justifyLeft ? lineX1 + (currentWordStringWidth1 / 2) : lineX1 - (currentWordStringWidth1 / 2);
				var centerX2 = justifyLeft ? lineX2 + (currentWordStringWidth2 / 2) : lineX2 - (currentWordStringWidth2 / 2);
				
				var rezChainLineX1 = prose ? centerX1 : lineX1 + linePlusX;
				var rezChainLineY1 = sideLink ? lineY1 : lineY1 + (currentWordStringHeight1 / 2);
				var rezChainLineX2 = prose ? centerX2 : lineX2 + linePlusX;
				var rezChainLineY2 = sideLink ? lineY2 : lineY2 - (currentWordStringHeight2 / 2);
				
				// if we are grid justify and the 2 rezChain x values are within a few pixels of each other, they should just be equal
				if (!prose) {
					if (abs(rezChainLineX1 - rezChainLineX2) < 6) rezChainLineX2 = rezChainLineX1;
				}
				
				var trackChainLineX1 = centerX1;
				var trackChainLineY1 = lineY1 + (currentWordStringHeight1 * 0.25);
				var trackChainLineX2 = centerX2;
				var trackChainLineY2 = lineY2 + (currentWordStringHeight2 * 0.25);
				
				var lineLen = -1;
				var arrowDir = -1;
				var arrowScale = 0.5;
				var arrowX = -1;
				var arrowY = -1;
				
				if (chainType == "resonance") {
					lineLen = point_distance(rezChainLineX1, rezChainLineY1, rezChainLineX2, rezChainLineY2);
					arrowDir = point_direction(rezChainLineX1, rezChainLineY1, rezChainLineX2, rezChainLineY2);
					arrowX = rezChainLineX1 + lengthdir_x(lineLen - (currentWordStringHeight2 * 1.5), arrowDir);
					if (prose || stretch2 || stretch1) arrowY = rezChainLineY1 + lengthdir_y(lineLen - (currentWordStringHeight2 * 1.5), arrowDir);
					else arrowY = rezChainLineY1 + lengthdir_y(lineLen - (currentWordStringHeight2 * 0.5), arrowDir);
				}
				else {
					
					lineLen = point_distance(trackChainLineX1, lineY1, trackChainLineX2, lineY2);
					arrowDir = mean(point_direction(trackChainLineX1, lineY1, trackChainLineX2, lineY2), 270, 270, 270);
					arrowX = trackChainLineX2;
					arrowY = lineY2 - currentWordStringHeight2;
						
					if (sideLink) {
						arrowDir = 0;
						arrowX = trackChainLineX2 - sprite_get_width(spr_linkArrow);
						arrowY = trackChainLineY2;
					}
				}


			

				if (currentChainVisible) {
					draw_set_color(currentChainColor);
					draw_set_alpha(1);

					if (chainType == "resonance") {
						

						draw_line_width(rezChainLineX1, rezChainLineY1, rezChainLineX2, rezChainLineY2, 2);

						
						// mark stretches visually with a circle
						if (obj_control.showDevVars) {
							if (stretch1 && currentEntry1SubMap != currentEntry2SubMap) {
								draw_set_color(c_red);
								draw_circle(lineX1, lineY1, 15, false);
							}
							if (stretch2) {
								draw_set_color(c_blue);
								draw_circle(lineX2, lineY2, 15, false);
							}
						}

					}
					else if (chainType == "trail") {
						
						if (sideLink) {
							draw_line_width(trackChainLineX1, trackChainLineY1, trackChainLineX2, trackChainLineY2, 2);
						}
						else {
							scr_drawCurvedLine(trackChainLineX1, lineY1 + (currentWordStringHeight1 / 2), trackChainLineX2, lineY2 - (currentWordStringHeight2 / 2), currentChainColor);
						}

					}
					if((obj_chain.showRezArrows and chainType = "resonance") or (obj_chain.showTrackArrows and chainType = "trail")){
						draw_sprite_ext(spr_linkArrow, 0, arrowX, arrowY, arrowScale, arrowScale, arrowDir, currentChainColor, 1);
					}
				}
			}
		}
	}
	
	if (obj_chain.currentFocusedChainID != "") {	
		if (mouseLineWordID != "") {
				
			var mouseLineTokenSubMap = global.nodeMap[?mouseLineWordID];
			var mouseLineTokenTagSubMap = mouseLineTokenSubMap[?"tagMap"];
			var mouseLineUnitId = mouseLineTokenSubMap[?"unit"];
			var mouseLineUnitSubMap = global.nodeMap[?mouseLineUnitId];
				
				
			var mouseLineWordStringWidth = string_width(string(mouseLineTokenTagSubMap[?global.displayTokenField]));
			var mouseLineWordStringHeight = string_height(string(mouseLineTokenTagSubMap[?global.displayTokenField]));
				
				
			var wordPixelX = mouseLineTokenSubMap[?"pixelX"];
			var wordPixelY = mouseLineUnitSubMap[?"pixelY"];
		
					
			if (is_numeric(wordPixelX) and is_numeric(wordPixelY)) {
				mouseLineX = wordPixelX + (mouseLineWordStringWidth / 2);
				mouseLineY = wordPixelY + (mouseLineWordStringHeight / 2);
				if (!justifyLeft) {
					mouseLineX -= mouseLineWordStringWidth;
				}
			}
		}
	}
	
	
	draw_set_alpha(1);


	// draw pickwhip line to mouse from chain
	var drawPickwhip = (is_numeric(mouseLineX) && is_numeric(mouseLineY) && !instance_exists(obj_dialogueBox) && !instance_exists(obj_dropDown)
						&& obj_toolPane.currentMode != obj_toolPane.modeRead && !obj_chain.focusedChainWrongTool);
	
	if (drawPickwhip) {
		if (ds_map_exists(global.nodeMap, obj_chain.currentFocusedChainID)) {
			var chainSubMap = global.nodeMap[? obj_chain.currentFocusedChainID];
			if (scr_isNumericAndExists(chainSubMap, ds_type_map)) {
				var chainType = chainSubMap[? "type"];
				currentChainColor = chainSubMap[? "chainColor"];
				currentChainVisible = chainSubMap[? "visible"];
				draw_set_color(currentChainColor);
			
				if (currentChainVisible) {
					if (not mouseLineHide) {
						if (chainType == "resonance") {
							draw_line_width(mouseLineX, mouseLineY, mouse_x, mouse_y, 2);
						}
						else if (chainType == "trail") {
							scr_drawCurvedLine(mouseLineX, mouseLineY, mouse_x, mouse_y, currentChainColor);
						}
						if ((obj_chain.showRezArrows and chainType = "resonance") or (obj_chain.showTrackArrows and chainType = "trail")) {
							var arrowAngle = point_direction(mouseLineX, mouseLineY, mouse_x, mouse_y);
							if (chainType = "trail") arrowAngle = (mouseLineY < mouse_y) ? 270 : 90;
							draw_sprite_ext(spr_linkArrow, 1, mouse_x, mouse_y, arrowSize, arrowSize, arrowAngle, currentChainColor, 1);
						}
					}
				}
			}
		}
	}
	

}
