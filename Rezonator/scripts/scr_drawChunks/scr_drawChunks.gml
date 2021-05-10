// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_drawChunks(){
	obj_chain.mouseOverAnyChunk = false;
	obj_control.hoverChunkID = "";
	// loop through all the chunks currently on screen, and draw them!
	var chunkShowListSize = ds_list_size(chunkShowList);
	for (var i = 0; i < chunkShowListSize; i++) {
		
		// get submap of chunk and make sure it exists
		var currentChunkID = chunkShowList[| i];
		var currentChunkSubMap = global.nodeMap[? currentChunkID];
		if (!is_numeric(currentChunkSubMap)) continue;
		if (!ds_exists(currentChunkSubMap, ds_type_map)) continue;
		
		// get tokenList & inChainsList of current chunk
		var currentChunkTokenList = currentChunkSubMap[? "tokenList"];
		var currentChunkInChainsList = currentChunkSubMap[? "inChainsList"];
		if (!is_numeric(currentChunkTokenList) || !is_numeric(currentChunkInChainsList)) continue;
		if (!ds_exists(currentChunkTokenList, ds_type_list) || !ds_exists(currentChunkInChainsList, ds_type_list)) continue;
		
		// get first & last token of chunk
		var currentChunkFirstTokenID = currentChunkTokenList[| 0];
		var currentChunkLastTokenID = currentChunkTokenList[| ds_list_size(currentChunkTokenList) - 1];
		
		var currentChunkFirstTokenSubMap = global.nodeMap[?currentChunkFirstTokenID];
		var currentChunkLastTokenSubMap = global.nodeMap[?currentChunkLastTokenID];
		
		var currentChunkFirstTokenTagMap = currentChunkFirstTokenSubMap[?"tagMap"];
		var currentChunkLastTokenTagMap = currentChunkLastTokenSubMap[?"tagMap"];
		
		
		
		// get x coordinates of words
		var firstTokenLeftX = currentChunkFirstTokenSubMap[?"pixelX"];		
		var lastTokenLeftX = currentChunkLastTokenSubMap[?"pixelX"];	
		var lastTokenDisplayStr = currentChunkLastTokenTagMap[?global.displayTokenField];	
		var lastTokenStrWidth = (is_string(lastTokenDisplayStr)) ? string_width(lastTokenDisplayStr) : 0;
		var lastTokenRightX = lastTokenLeftX + lastTokenStrWidth;
		var displayUnit = currentChunkFirstTokenSubMap[?"unit"];
		
		
		scr_adaptFont(lastTokenDisplayStr, "M");
		var strHeight = (is_string(lastTokenDisplayStr)) ? string_height(lastTokenDisplayStr) : 0;
		
		// set rect coordinates for chunk
		var chunkRectX1 = -1;
		var chunkRectY1 = -1;
		var chunkRectX2 = -1;
		var chunkRectY2 = -1;
		
		if (is_numeric(firstTokenLeftX)) chunkRectX1 = firstTokenLeftX - 10;
		if (is_numeric(lastTokenRightX)) chunkRectX2 = lastTokenRightX + 10;
		if (displayUnit != "" and is_string(displayUnit)) {
			var unitSubMap = global.nodeMap[?displayUnit];
			var pixelY = unitSubMap[?"pixelY"]
			chunkRectY1 = pixelY - strHeight;
			chunkRectY2 = pixelY + strHeight;
		}
		
		// draw BG rect
		draw_set_color(global.colorThemeBG);
		draw_set_alpha(1);
		draw_rectangle(chunkRectX1, chunkRectY1, chunkRectX2, chunkRectY2, false);
		
		// check whether this chunk is in a focused chain
		var chunkInFocusedChain = false;
		if (obj_chain.currentFocusedChainID != "") {
			for (var j = 0; j < ds_list_size(currentChunkInChainsList); j++) {
				if (obj_chain.currentFocusedChainID == currentChunkInChainsList[| j]) chunkInFocusedChain = true;
			}
		}
		
		// draw selection box		
		var mouseOverChunk = (point_in_rectangle(mouse_x,mouse_y,chunkRectX1, chunkRectY1, chunkRectX2, chunkRectY2) && obj_control.hoverTokenID == "" && not obj_control.mouseoverPanelPane && not obj_toolPane.mouseOverToolPane);
		if (mouseOverChunk) {
			obj_control.hoverChunkID = currentChunkID;
			obj_control.mouseoverNeutralSpace = false;
			draw_set_color(global.colorThemeSelected1);
			draw_set_alpha(.5);
			draw_rectangle(chunkRectX1, chunkRectY1, chunkRectX2, chunkRectY2, false);
			// click on chunk
			if (device_mouse_check_button_released(0, mb_left) and !(global.delayInput > 0)and !instance_exists(obj_dropDown)) {
				// add chunk to pre-existing chain
				if (ds_list_size(currentChunkInChainsList) < 1) {
					obj_chain.currentFocusedChunkID = currentChunkID;
					if (obj_chain.currentFocusedChainID != "") {						
						var chainSubMap = global.nodeMap[? obj_chain.currentFocusedChainID];
						if (is_numeric(chainSubMap)) {
							if (ds_exists(chainSubMap, ds_type_map)) {
								scr_newLink(currentChunkID);
								global.delayInput = 5;
							}
						}
					}
					else{
						scr_newChain(currentChunkID);
						scr_newLink(currentChunkID);
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
					var chainToRefocus = currentChunkInChainsList[| 0];
					if (is_string(chainToRefocus) && ds_map_exists(global.nodeMap, chainToRefocus)) {
						obj_chain.currentFocusedChainID = chainToRefocus;
						scr_refocusChainEntry(currentChunkID);
					}
				}
			}
			
			// Check for rightMouseClick
			if (device_mouse_check_button_released(0, mb_right) and !instance_exists(obj_dialogueBox)) {
				
				obj_control.rightClickID = currentChunkID;
	
				// wait 1 frame and then show the right click dropdown
				with (obj_alarm) {
					alarm[11] = 2;
				}

			}
			
			obj_chain.mouseOverAnyChunk = true;
		}
		
		var colorOfRect = global.colorThemeSelected2;	
		var typeOfChain = "rezChain";

		if (ds_list_size(currentChunkInChainsList) > 0) {
			var chunksChain = currentChunkInChainsList[| 0];
			var chunksChainsSubMap = global.nodeMap[? chunksChain];
					
			if (is_numeric(chunksChainsSubMap)) {
				if (ds_exists(chunksChainsSubMap, ds_type_map)) {
					typeOfChain = chunksChainsSubMap[? "type"];
					colorOfRect = chunksChainsSubMap[? "chainColor"];
				}
			}
		}
		
		// draw border of chunk
		draw_set_color(colorOfRect);
		draw_set_alpha(1);
		scr_drawRectWidth(chunkRectX1, chunkRectY1, chunkRectX2, chunkRectY2, 3, (typeOfChain == "trackChain"));
		
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
	
	// unfocus chunks if user clicks anywhere else
	if(!obj_chain.mouseOverAnyChunk){
		if(device_mouse_check_button_released(0, mb_left)){
			obj_chain.currentFocusedChunkID = "";
		}
	}

		draw_set_alpha(1);
		
}