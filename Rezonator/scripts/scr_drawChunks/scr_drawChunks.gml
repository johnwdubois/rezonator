// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_drawChunks(){
	draw_set_halign(fa_center);
	var mouseoverChunkList = ds_list_create();
	var mouseoverChunkX1 = -1;
	var mouseoverChunkY1 = -1;
	var mouseoverChunkX2 = -1;
	var mouseoverChunkY2 = -1;

	obj_chain.mouseOverAnyChunk = false;
	
	
	ds_list_clear(chunkShowList);
	
	
	// loop through all the chunks currently on screen, and draw them!
	var chunkShowMapSize = ds_map_size(obj_chain.chunkShowMap);	
	for (var i = chunkShowMapSize; i > 0; i--) {
		
		// get submap of chunk and make sure it exists
		var currentNestList = obj_chain.chunkShowMap[? string(i)];
		if(!scr_isNumericAndExists(currentNestList,ds_type_list)){continue;}
		var currentNestListSize = ds_list_size(currentNestList);
		for(var j = 0; j < currentNestListSize; j++){
			var currentChunkID = currentNestList[| j];
			scr_addToListOnce(chunkShowList, currentChunkID);
			var currentChunkSubMap = global.nodeMap[? currentChunkID];
			if (!scr_isNumericAndExists(currentChunkSubMap, ds_type_map)) continue;
		
			// get tokenList & inChainsList of current chunk
			var currentChunkTokenList = currentChunkSubMap[? "tokenList"];
			var currentChunkInChainsList = currentChunkSubMap[? "inChainsList"];
			var currentChunkNest = currentChunkSubMap[? "nest"];
			if (!is_numeric(currentChunkTokenList) || !is_numeric(currentChunkInChainsList)) continue;
			if (!ds_exists(currentChunkTokenList, ds_type_list) || !ds_exists(currentChunkInChainsList, ds_type_list)) continue;
		
			// get first & last token of chunk
			var currentChunkFirstTokenID = currentChunkTokenList[| 0];
			var currentChunkLastTokenID = currentChunkTokenList[| ds_list_size(currentChunkTokenList) - 1];
		
			var currentChunkFirstTokenSubMap = global.nodeMap[?currentChunkFirstTokenID];
			var currentChunkLastTokenSubMap = global.nodeMap[?currentChunkLastTokenID];
		
			var currentChunkFirstTokenTagMap = currentChunkFirstTokenSubMap[?"tagMap"];
			var currentChunkLastTokenTagMap = currentChunkLastTokenSubMap[?"tagMap"];
		
		
		
			// get x coordinates of tokens & chunks
			var firstTokenX = -1;
			var lastTokenX = -1;
			var chunkXBorder = 10;
			var chunkRectX1 = -1;
			var chunkRectX2 = -1;
			var firstTokenDisplayStr = currentChunkFirstTokenTagMap[? global.displayTokenField];
			var lastTokenDisplayStr = currentChunkLastTokenTagMap[? global.displayTokenField];
		
			var firstTokenStrWidth_ = (is_string(firstTokenDisplayStr)) ? string_width(firstTokenDisplayStr) : 0;
			var lastTokenStrWidth_ = (is_string(lastTokenDisplayStr)) ? string_width(lastTokenDisplayStr) : 0;
			
			var firstTokenStrWidth = firstTokenStrWidth_;
			var lastTokenStrWidth = lastTokenStrWidth_;
			
			if (obj_control.drawLineState == obj_control.lineState_rtl) {
				firstTokenStrWidth = lastTokenStrWidth_;
				lastTokenStrWidth = firstTokenStrWidth_;
			}
			
			
		
			// get coordinates based on tokens and their justifications
			if (obj_control.drawLineState == obj_control.lineState_ltr) {

					firstTokenX = currentChunkFirstTokenSubMap[? "pixelX"];
					//firstTokenLeftX = firstTokenRightX - firstTokenStrWidth;
					lastTokenX = currentChunkLastTokenSubMap[? "pixelX"];

			}
			else {

					firstTokenX = currentChunkLastTokenSubMap[? "pixelX"];
					lastTokenX = currentChunkFirstTokenSubMap[? "pixelX"];
					//lastTokenRightX = lastTokenLeftX + lastTokenStrWidth;

			}

		
			// set chunk x coordinates
			if (is_numeric(firstTokenX)) chunkRectX1 = firstTokenX - chunkXBorder;
			if (is_numeric(lastTokenX)) chunkRectX2 = lastTokenX + chunkXBorder;
		
			if(obj_control.justify == obj_control.justifyLeft){
				chunkRectX2 = chunkRectX2 + lastTokenStrWidth;
			}
			else{
				chunkRectX1 = chunkRectX1 - firstTokenStrWidth;
			}
	
			var displayUnit = currentChunkFirstTokenSubMap[? "unit"];
		
		
			scr_adaptFont(lastTokenDisplayStr, "M");
			var strHeight = (is_string(lastTokenDisplayStr)) ? string_height(lastTokenDisplayStr) : 0;
		
			// set rect coordinates for chunk
			var chunkRectY1 = -1;
			var chunkRectY2 = -1;
		

			if (displayUnit != "" and is_string(displayUnit)) {
				var unitSubMap = global.nodeMap[?displayUnit];
				var pixelY = unitSubMap[?"pixelY"]
				chunkRectY1 = pixelY - strHeight;
				chunkRectY2 = pixelY + strHeight;
			}
			var nestBuffer = 5 * currentChunkNest;

			chunkRectX1 = chunkRectX1;
			chunkRectX2 = chunkRectX2;
			chunkRectY1 = chunkRectY1 - nestBuffer;
			chunkRectY2 = chunkRectY2 + nestBuffer;
			currentChunkSubMap[? "x1"] = chunkRectX1;
			currentChunkSubMap[? "y1"] = chunkRectY1;
			currentChunkSubMap[? "x2"] = chunkRectX2;
			currentChunkSubMap[? "y2"] = chunkRectY2;
		
		
			// draw BG rect
			draw_set_color(global.colorThemeBG);
			draw_set_alpha(1);
			draw_rectangle(chunkRectX1, chunkRectY1, chunkRectX2, chunkRectY2, false);
		
			// check whether this chunk is in a focused chain
			var chunkInFocusedChain = false;
			if (obj_chain.currentFocusedChainID != "") {
				for (var k = 0; k < ds_list_size(currentChunkInChainsList); k++) {
					if (obj_chain.currentFocusedChainID == currentChunkInChainsList[| k]) chunkInFocusedChain = true;
				}
			}

			// draw selection box		
			var mouseOverChunk = (point_in_rectangle(mouse_x,mouse_y,chunkRectX1, chunkRectY1, chunkRectX2, chunkRectY2) && obj_control.hoverTokenID == "" && not obj_control.mouseoverPanelPane && not obj_toolPane.mouseOverToolPane) && !instance_exists(obj_dropDown) && !instance_exists(obj_dialogueBox) && !instance_exists(obj_flyout);
			if (mouseOverChunk) {
				ds_list_add(mouseoverChunkList, currentChunkID);
			}
		

		
			var colorOfRect = global.colorThemeSelected2;	
			var typeOfChain = "resonance";

			if (ds_list_size(currentChunkInChainsList) > 0) {
				var chunksChain = currentChunkInChainsList[| 0];
				var chunksChainsSubMap = global.nodeMap[? chunksChain];
					
				if (scr_isNumericAndExists(chunksChainsSubMap, ds_type_map)) {
					typeOfChain = chunksChainsSubMap[? "type"];
					colorOfRect = chunksChainsSubMap[? "chainColor"];
				}
			}
		
			// draw border of chunk
			if (!obj_control.hideChunks || ds_list_size(currentChunkInChainsList) >= 1) {
				draw_set_color(colorOfRect);
				draw_set_alpha(1);
				scr_drawRectWidth(chunkRectX1, chunkRectY1, chunkRectX2, chunkRectY2, 3, (typeOfChain == "trail"));
			}
		
			// if this chunk is focused, fill it in and draw the focused sqaures
			if (obj_chain.currentFocusedChunkID == currentChunkID || chunkInFocusedChain) {
				draw_set_color((obj_chain.mouseLineWordID == currentChunkID || obj_chain.mouseLineWordID ==  scr_getFirstWordOfChunk(currentChunkID)) ? colorOfRect : global.colorThemeSelected1);
				draw_set_alpha(.5);
				draw_rectangle(chunkRectX1, chunkRectY1, chunkRectX2, chunkRectY2, false);			

				var fontScale = 1;
			    draw_sprite_ext(spr_focusPoint, 0, chunkRectX1 - obj_control.wordDrawGridFocusedAnimation, chunkRectY1 - obj_control.wordDrawGridFocusedAnimation, fontScale, fontScale, 0, colorOfRect, 1);
			    draw_sprite_ext(spr_focusPoint, 0, chunkRectX2 + obj_control.wordDrawGridFocusedAnimation, chunkRectY1 - obj_control.wordDrawGridFocusedAnimation, fontScale, fontScale, 0, colorOfRect, 1);
			    draw_sprite_ext(spr_focusPoint, 0, chunkRectX1 - obj_control.wordDrawGridFocusedAnimation, chunkRectY2 + obj_control.wordDrawGridFocusedAnimation, fontScale, fontScale, 0, colorOfRect, 1);
			    draw_sprite_ext(spr_focusPoint, 0, chunkRectX2 + obj_control.wordDrawGridFocusedAnimation, chunkRectY2 + obj_control.wordDrawGridFocusedAnimation, fontScale, fontScale, 0, colorOfRect, 1);	    
			}
		}
	}
	
	// unfocus chunks if user clicks anywhere else
	if(!obj_chain.mouseOverAnyChunk && obj_panelPane.functionChainList_chunkMouseover == ""){
		if(device_mouse_check_button_released(0, mb_left)){
			obj_chain.currentFocusedChunkID = "";
		}
	}

	draw_set_alpha(1);
	
	
	
	
	
	
	
	// determine which chunk should be moused over
	var lowestNestChunk = "";
	var lowestNest = 999999999999;
	var mouseoverChunkListSize = ds_list_size(mouseoverChunkList);
	for (var i = 0; i < mouseoverChunkListSize; i++) {
		var currentChunk = mouseoverChunkList[| i];
		var currentChunkSubMap = global.nodeMap[? currentChunk];
		var currentChunkNest = currentChunkSubMap[? "nest"];
		if (currentChunkNest < lowestNest) {
			lowestNest = currentChunkNest;
			lowestNestChunk = currentChunk;
		}
	}
	
	
	// the moused over chunk
	if (lowestNestChunk != "") {
		obj_control.hoverChunkID = lowestNestChunk;

		obj_control.hoverTextCopy = scr_getChunkText(lowestNestChunk);
		
		// draw fill for hovered chunk
		var hoverChunkSubMap = global.nodeMap[? obj_control.hoverChunkID];
		var hoverChunkInChainsList = hoverChunkSubMap[? "inChainsList"];

		obj_control.mouseoverNeutralSpace = false;

		// click on chunk
		if (device_mouse_check_button_released(0, mb_left) and !(global.delayInput > 0)and !instance_exists(obj_dropDown)) {
			
			// focus chunk in panelPane
			with (obj_panelPane) {
				functionChainList_chunkSelected = obj_control.hoverChunkID;
				if (currentFunction == functionChainList) {
					scr_scrollNavToID(functionChainList_tabChunk, obj_control.hoverChunkID);
				}
			}
			
			
			// set field/tags if in read mode
			if (obj_toolPane.currentMode == obj_toolPane.modeRead) {
				if (obj_panelPane.functionField_chunkFieldSelected != "" && obj_panelPane.functionField_chunkTagSelected != ""
				&& is_string(obj_panelPane.functionField_chunkFieldSelected) && is_string(obj_panelPane.functionField_chunkTagSelected)) {
					var chunkTagMap = currentChunkSubMap[? "tagMap"];
					if (scr_isNumericAndExists(chunkTagMap, ds_type_map)) {
						chunkTagMap[? obj_panelPane.functionField_chunkFieldSelected] = obj_panelPane.functionField_chunkTagSelected;
						show_debug_message("scr_tokenClicked ... setting token: " + string(currentChunk) + ", field:" + string(obj_panelPane.functionField_chunkFieldSelected) + ", tag: " + string(obj_panelPane.functionField_chunkTagSelected));
					}
				}
			}
			
			// add chunk to pre-existing chain
			if (ds_list_size(hoverChunkInChainsList) < 1) {
				obj_chain.currentFocusedChunkID = obj_control.hoverChunkID;
				if (obj_chain.currentFocusedChainID != "") {						
					var chainSubMap = global.nodeMap[? obj_chain.currentFocusedChainID];
					if (scr_isNumericAndExists(chainSubMap, ds_type_map)) {
						scr_newLink(obj_control.hoverChunkID);
						global.delayInput = 5;
					}
				}
				else{
					scr_newChain(obj_control.hoverChunkID);
					scr_newLink(obj_control.hoverChunkID);
					global.delayInput = 5;
				}
				// if there is a focused chain, unfocus the chunk
				if (obj_chain.currentFocusedChainID != "") {
					obj_chain.currentFocusedChunkID = "";
				}
					
			}
			else {
				// if this chunk is in at least 1 chain, we will focus the first chain its inChainsList
				obj_chain.currentFocusedChunkID = "";
				var chainToRefocus = hoverChunkInChainsList[| 0];
				if (is_string(chainToRefocus) && ds_map_exists(global.nodeMap, chainToRefocus)) {
					obj_chain.currentFocusedChainID = chainToRefocus;
					scr_refocusChainEntry(obj_control.hoverChunkID);
				}
			}
		}
			
		// Check for rightMouseClick
		if (device_mouse_check_button_released(0, mb_right) and !instance_exists(obj_dialogueBox)) {
				
			obj_control.rightClickID = obj_control.hoverChunkID;
	
			// wait 1 frame and then show the right click dropdown
			with (obj_alarm) {
				alarm[11] = 2;
			}

		}
			
		obj_chain.mouseOverAnyChunk = true;
	}
	else {
		obj_control.hoverChunkID = "";
	}
	
	
	// highlight chunk: either highlight the chunk being moused over in the main screen, or highlight the chunk being moused over in the chunk pane
	if (obj_control.hoverChunkID != "" || obj_panelPane.functionChainList_chunkMouseover != "") {
		var highlightChunkID = (obj_control.hoverChunkID != "") ? obj_control.hoverChunkID : obj_panelPane.functionChainList_chunkMouseover;
		if (ds_list_find_index(chunkShowList, highlightChunkID) >= 0) {
			var hoverChunkSubMap = global.nodeMap[? highlightChunkID];
			if (scr_isNumericAndExists(hoverChunkSubMap, ds_type_map)) {
				var highlightChunkX1 = hoverChunkSubMap[? "x1"];
				var highlightChunkY1 = hoverChunkSubMap[? "y1"];
				var highlightChunkX2 = hoverChunkSubMap[? "x2"];
				var highlightChunkY2 = hoverChunkSubMap[? "y2"];
			
				draw_set_color(global.colorThemeSelected1);
				draw_set_alpha(.5);
				if (is_numeric(highlightChunkX1) && is_numeric(highlightChunkY1) && is_numeric(highlightChunkX2) && is_numeric(highlightChunkY2)) {
					draw_rectangle(highlightChunkX1, highlightChunkY1, highlightChunkX2, highlightChunkY2, false);
				}
			}
		}
	}
	
	
	
	
	ds_list_destroy(mouseoverChunkList);
}