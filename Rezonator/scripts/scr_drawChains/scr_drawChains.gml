function scr_drawChains() {
	/*
		Purpose: draw rezChains and move words on screen according to the rezChains
	*/
	
	//scr_setMouseLineWordID();

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
	var rezChainList = ds_map_find_value(global.nodeMap, "rezChainList");
	var rezChainListSize = ds_list_size(rezChainList);
	var activeLineGridHeight = ds_grid_height(obj_control.currentActiveLineGrid);
	var arrowSize = 0.3 + (0.1 * global.fontSize / 5);

	// loop through rezChainList to get chain info
	var chainShowListSize = ds_list_size(obj_chain.chainShowList);
	for (var i = 0; i < chainShowListSize; i++) {
		minWordWidth = 9999999;
		
		var currentChainID = ds_list_find_value(obj_chain.chainShowList, i);
		
		// skip this chain if we can't find it in the nodeMap
		if (!ds_map_exists(global.nodeMap, currentChainID)) continue;
		
		// make sure this chain's subMap exists and that it is actually a map
		var currentChainSubMap = ds_map_find_value(global.nodeMap, currentChainID);
		if (!is_numeric(currentChainSubMap)) continue;
		if (!ds_exists(currentChainSubMap, ds_type_map)) continue;
		
		// get chain's setIDList and make sure it exists
		var chainType = ds_map_find_value(currentChainSubMap, "type");
		var currentSetIDList = ds_map_find_value(currentChainSubMap, "vizSetIDList");
		if (!is_numeric(currentSetIDList)) continue;
		if (!ds_exists(currentSetIDList, ds_type_list)) continue;
		var currentSetIDListSize = ds_list_size(currentSetIDList);
		var currentChainColor = ds_map_find_value(currentChainSubMap, "chainColor");
		var currentChainVisible = ds_map_find_value(currentChainSubMap, "visible");
		var currentChainAlign = ds_map_find_value(currentChainSubMap, "alignChain");
		
		// make sure this is a rezChain or trackChain and that we should be drawing it
		if (chainType != "rezChain" && chainType != "trackChain") continue;
		var showRezBorder = false;
		var showTrackBorder = false;
		if (currentChainVisible) {
			if (chainType == "rezChain") showRezBorder = true;
			else if (chainType == "trackChain") showTrackBorder = true;
		}
	
		// find minimum word width so we know the X position of the chain
		for (var j = 0; j < currentSetIDListSize; j++) {
			var currentEntry = ds_list_find_value(currentSetIDList, j);
			var currentEntrySubMap = ds_map_find_value(global.nodeMap, currentEntry);
			var currentWordID = ds_map_find_value(currentEntrySubMap, "token");
			var tokenSubMap = global.nodeMap[?currentWordID];
			var currentWordWidth = 0;
			if (scr_isNumericAndExists(tokenSubMap, ds_type_map)){
				var tagMap = tokenSubMap[?"tagMap"];
				if (scr_isNumericAndExists(tagMap, ds_type_map)){
					currentWordWidth = string_width(string(tagMap[?global.displayTokenField]));
				}
			}
			currentWordWidth = max(currentWordWidth, 0);
		
			if (currentWordWidth < minWordWidth) {
				minWordWidth = currentWordWidth;
				linePlusX = minWordWidth;
			}
		}
	
		var tokensInSameLine = false;
		var firstTokenInLine = "";
	
		// loop through current chain's wordIDList to draw the lines of the chain
		for (var j = 0; j < currentSetIDListSize - 1; j++) {
			
			// get the wordIDs for the 2 words we want to draw a line between
			var currentEntry1 = currentSetIDList[| j];
			var currentEntry1SubMap = global.nodeMap[? currentEntry1];
			var currentEntry2 = currentSetIDList[| j + 1];
			var currentEntry2SubMap = global.nodeMap[? currentEntry2];
			var currentTokenID1 = currentEntry1SubMap[? "token"];
			var currentTokenID2 = currentEntry2SubMap[? "token"];
			
			//get tokenSubMaps
			var currentToken1SubMap = global.nodeMap[? currentTokenID1];
			var currentToken2SubMap = global.nodeMap[? currentTokenID2];
			if(!scr_isNumericAndExists(currentToken1SubMap, ds_type_map)){show_debug_message("TRERRY IS A DINGLE1") continue;}
			if(!scr_isNumericAndExists(currentToken2SubMap, ds_type_map)){show_debug_message("TRERRY IS A DINGLE2") continue;}
				
			//get tokenTagSubMaps
			var currentTagSubMap1 = currentToken1SubMap[? "tagMap"];
			var currentTagSubMap2 = currentToken2SubMap[? "tagMap"];		
	
			
			//get unit IDs
			var tokenUnitID1 = currentToken1SubMap[?"unit"];
			var	tokenUnitID2 = currentToken2SubMap[?"unit"];
			
			//get token's Unit's subMap
			var tokenUnitID1SubMap = global.nodeMap[?tokenUnitID1];
			var tokenUnitID2SubMap = global.nodeMap[?tokenUnitID2];
			
			/*
			// check if the words are chunks
			var currentWordID1IsChunk = false;
			if (ds_map_exists(global.nodeMap, currentTokenID1)) {
				var currentWordID1SubMap = global.nodeMap[? currentTokenID1];
				var currentWordID1Type = currentWordID1SubMap[? "type"];
				if (currentWordID1Type == "chunk") currentWordID1IsChunk = true;
				if (currentWordID1IsChunk) {
					var currentWordID1TokenList = currentWordID1SubMap[? "tokenList"];
					currentTokenID1 = currentWordID1TokenList[| 0];
				}
			}
			var currentWordID2IsChunk = false;
			if (ds_map_exists(global.nodeMap, currentTokenID2)) {
				var currentWordID2SubMap = global.nodeMap[? currentTokenID2];
				var currentWordID2Type = currentWordID2SubMap[? "type"];
				if (currentWordID2Type == "chunk") currentWordID2IsChunk = true;
				if (currentWordID2IsChunk) {
					var currentWordID2TokenList = currentWordID2SubMap[? "tokenList"];
					currentTokenID2 = currentWordID2TokenList[| 0];
				}
			}
			*/
	
			var currentWordStringWidth1 = string_width(string(currentTagSubMap1[?global.displayTokenField]));
			var currentWordStringWidth2 = string_width(string(currentTagSubMap2[?global.displayTokenField]));
		
			lineX1 = currentToken1SubMap[?"pixelX"];
			lineY1 = tokenUnitID1SubMap[?"pixelY"];
		
	
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
		
			var currentWordStringWidth2 = string_width(string(currentTagSubMap2[?global.displayTokenField]));
		
			lineX2 = currentToken2SubMap[?"pixelX"];
			lineY2 = tokenUnitID2SubMap[?"pixelY"];
		
			var currentLineGridIndex1InDrawRange = true;
			var currentLineGridIndex2InDrawRange = true;
			
			var unitSeq1 = tokenUnitID1SubMap[?"unitSeq"];
			var unitSeq2 = tokenUnitID2SubMap[?"unitSeq"];
		
			if (unitSeq1 < obj_control.drawRangeStart or unitSeq1 > obj_control.drawRangeEnd) {
				currentLineGridIndex1InDrawRange = false;
			}
		
			if (unitSeq2 < obj_control.drawRangeStart or unitSeq2 > obj_control.drawRangeEnd) {
				currentLineGridIndex2InDrawRange = false;
			}
		
		
		 
			// only draw line if every value is real and we are in the draw range
			if not (lineX1 == undefined or lineY1 == undefined or lineX2 == undefined or lineY2 == undefined)
			and not (lineY1 < wordTopMargin + (-obj_control.gridSpaceVertical * 2) and lineY2 < wordTopMargin + (-obj_control.gridSpaceVertical * 2))
			and not (lineY1 > camera_get_view_height(camera_get_active()) + (obj_control.gridSpaceVertical * 2) and lineY2 > camera_get_view_height(camera_get_active()) + (obj_control.gridSpaceVertical * 2)) {
				/*
				if (chunkWord1) {
					var wordRectBuffer = 15;
					lineY1 += wordRectBuffer;
					chunkWord1 = 0;
				}
				if (chunkWord2) {
					var wordRectBuffer = 15;
					lineY2 -= (wordRectBuffer);
				}
				*/
			
				if (currentChainVisible) {
					draw_set_color(currentChainColor);
					draw_set_alpha(1);
					/*
					if (chunkWord2) {
						if (chainType == "rezChain") {
							draw_line_width(lineX1 + linePlusX, lineY1 + (currentWordStringHeight1 / 2), lineX2 + linePlusX, lineY2 - (currentWordStringHeight2 / 2), 2);
						}
						else if (chainType == "trackChain") {
							scr_drawCurvedLine(lineX1 + (currentWordStringWidth1 / 2), lineY1, lineX2 + (currentWordStringWidth2 / 2), lineY2, currentChainColor);
						}
					}
					else{*/
					if (chainType == "rezChain") {
						draw_line_width(lineX1 + linePlusX, lineY1 + (currentWordStringHeight1 / 2), lineX2 + linePlusX, lineY2 + (currentWordStringHeight2 / 2), 2);
					}
					else if (chainType == "trackChain") {
						scr_drawCurvedLine(lineX1 + (currentWordStringWidth1 / 2), lineY1, lineX2 + (currentWordStringWidth2 / 2), lineY2, currentChainColor);
					}
					
				}
				// I need to modify this with the Chunk's wordRectBuffer
				//chunkWord2 = 0;
			}
		}
	
	
		if (obj_chain.currentFocusedChainID == currentChainID) {	
			if (mouseLineWordID != "") {
				
				var mouseLineTokenSubMap = global.nodeMap[?mouseLineWordID];
				var mouseLineTokenTagSubMap = mouseLineTokenSubMap[?"tagMap"];
				var mouseLineUnitId = mouseLineTokenSubMap[?"unit"];
				var mouseLineUnitSubMap = global.nodeMap[?mouseLineUnitId];
				
				
				var mouseLineWordStringWidth = string_width(string(mouseLineTokenTagSubMap[?global.displayTokenField]));
				var mouseLineWordStringHeight = string_height(string(mouseLineTokenTagSubMap[?global.displayTokenField]));
				
				
				var wordPixelX = mouseLineTokenSubMap[?"pixelX"];
				var wordPixelY = mouseLineUnitSubMap[?"pixelY"];
					
				if(wordPixelX != undefined and wordPixelY != undefined) {
					mouseLineX = wordPixelX + (mouseLineWordStringWidth / 2);
					mouseLineY = wordPixelY + (mouseLineWordStringHeight / 2);
				}
			}
		}
	}
	
	draw_set_alpha(1);


	// draw pickwhip line to mouse from chain
	var drawPickwhip = (!is_undefined(mouseLineX) && !is_undefined(mouseLineY) && !instance_exists(obj_dialogueBox) && !instance_exists(obj_dropDown)
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
						if (chainType == "rezChain") {
							draw_line_width(mouseLineX, mouseLineY, mouse_x, mouse_y, 2);
						}
						else if (chainType == "trackChain") {
							scr_drawCurvedLine(mouseLineX, mouseLineY, mouse_x, mouse_y, currentChainColor);
						}
						if (obj_chain.showChainArrows) {
							var arrowAngle = point_direction(mouseLineX, mouseLineY, mouse_x, mouse_y);
							draw_sprite_ext(spr_linkArrow, 1, mouse_x, mouse_y, arrowSize, arrowSize, arrowAngle, currentChainColor, 1);
						}
					}
				}
			}
		}
	}


}
