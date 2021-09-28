// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_drawLineEntryList(unitID, unitSubMap, entryList, pixelY, OOBCheck){

	
	if(OOBCheck){
		if (pixelY + gridSpaceVertical < wordTopMargin || pixelY - gridSpaceVertical > camera_get_view_height(view_camera[0])) exit;
	}
	
	draw_set_color(global.colorThemeText);
	draw_set_alpha(1);
	draw_set_valign(fa_middle);
	
	// set halign
	var halign = fa_left;
	if (justify == justifyRight) halign = fa_right;
	draw_set_halign(halign);
	
	var camWidth = camera_get_view_width(camera_get_active());
	var shapeTextX = 0;
	var spaceWidth = string_width(" ");
	
	// get unit width
	var unitWidth = 0;
	if (justify == justifyRight && drawLineState == lineState_rtl && shape == shapeText) {
		unitWidth = scr_getUnitTextStupid(unitSubMap);
	}
	else if (justify != justifyLeft) {
		unitWidth = string_width(scr_getUnitText(unitSubMap));
	}
	
	var entryListSize = ds_list_size(entryList);
	//var i = (obj_control.drawLineState == obj_control.lineState_ltr)? 0 : entryListSize-1;
	
	var i = (obj_control.justify == obj_control.justifyLeft) ? 0 : entryListSize-1;
	var isBAD = (obj_control.justify == obj_control.justifyLeft && obj_control.drawLineState == obj_control.lineState_rtl && obj_control.shape == obj_control.shapeText);
	if (isBAD) i = entryListSize-1;
	var j = 0;
	var k = (drawLineState == lineState_ltr) ? 0 : entryListSize-1;

	repeat(entryListSize) {
		
		// get current entry submap and make sure it exists
		var currentEntry = entryList[| i];
		var currentEntrySubMap = global.nodeMap[? currentEntry];
		if (!scr_isNumericAndExists(currentEntrySubMap, ds_type_map)) continue;
		
		// get token for this entry and make sure that exists
		var currentToken = currentEntrySubMap[? "token"];
		var currentTokenSubMap = global.nodeMap[? currentToken];
		if (!scr_isNumericAndExists(currentTokenSubMap, ds_type_map)) continue;
		currentTokenSubMap[? "relativeOrder"] = k;
		
		// get tag map for this token
		var currentTagMap = currentTokenSubMap[? "tagMap"];
		if (!scr_isNumericAndExists(currentTagMap, ds_type_map)) continue;
		var currentDisplayStr = string(currentTagMap[? global.displayTokenField]);

		// get & set pixelX value
		var tokenOnScreen = (currentTokenSubMap[? "pixelX"] >= 0 && currentTokenSubMap[? "pixelX"] < camWidth);
		if (tokenOnScreen) {
			scr_tokenCalculateVoid(currentToken);
			scr_adaptFont(currentDisplayStr,"M");
		}
		
		var currentDisplayCol = currentTokenSubMap[? "displayCol"];
		var currentPixelX = scr_setTokenX(currentTokenSubMap, currentDisplayCol, entryListSize, j, unitWidth, shapeTextX, camWidth,currentDisplayStr);
		
		
		
		
		var wordDistance = string_width(currentDisplayStr) + (spaceWidth * (proseSpaceHorizontal / 23));
		if (justify == justifyRight && drawLineState == lineState_rtl && shape == shapeText && i >= 1) {
			
			var nextEntry = entryList[| i - 1];
			var nextEntrySubMap = global.nodeMap[? nextEntry];
			var nextToken = nextEntrySubMap[? "token"];
			var nextTokenSubMap = global.nodeMap[? nextToken];
			var nextTagMap = nextTokenSubMap[? "tagMap"];
			var nextDisplayStr = nextTagMap[? global.displayTokenField];
			var nextWordDistance = string_width(nextDisplayStr) + (spaceWidth * (proseSpaceHorizontal / 10));
			
			shapeTextX += nextWordDistance;
			
		}
		else {
			shapeTextX += wordDistance;
		}

		
		
		
		
		//mouseover Token check
		if (tokenOnScreen) {
			var currentTokenStringWidth = string_width(currentDisplayStr);
			var currentTokenStringHeight = string_height(currentDisplayStr);		
			var tokenRectBuffer = 3;
			var tokenRectX1 = currentPixelX - tokenRectBuffer;
			var tokenRectY1 = pixelY - (currentTokenStringHeight / 2) - tokenRectBuffer;
			var tokenRectX2 = tokenRectX1 + currentTokenStringWidth + (tokenRectBuffer * 2);
			var tokenRectY2 = tokenRectY1 + currentTokenStringHeight + (tokenRectBuffer * 2);
			if (halign == fa_right) {
				tokenRectX1 -= currentTokenStringWidth;
				tokenRectX2 -= currentTokenStringWidth;
			}
			var mouseOverToken = point_in_rectangle(mouse_x,mouse_y, tokenRectX1, tokenRectY1, tokenRectX2, tokenRectY2) && hoverTokenID == "" && !mouseoverPanelPane && !instance_exists(obj_dropDown) && !instance_exists(obj_dialogueBox);
		
		
			// draw background tokenRect
			draw_set_color(global.colorThemeBG);
			draw_set_alpha(1);
			draw_rectangle(tokenRectX1, tokenRectY1, tokenRectX2, tokenRectY2, false);
		
			// check if this token is in mouse rect
			var mouseRectExists = makingRect;
			var inMouseRect = false;
			if (mouseRectExists) {
				inMouseRect = (rectangle_in_rectangle(tokenRectX1, tokenRectY1, tokenRectX2, tokenRectY2, min(mouse_x, mouseHoldRectX1), min(mouse_y, mouseHoldRectY1), max(mouse_x, mouseHoldRectX1), max(mouse_y, mouseHoldRectY1))
				&& (mouse_x > mouseHoldRectX1 + minimumChunkDist || mouse_x < mouseHoldRectX1 - minimumChunkDist));
				if (mouseRectExists && inMouseRect && !mouse_check_button_released(mb_left)) {
					ds_list_add(inRectTokenIDList, currentToken);
					scr_addToListOnce(inRectUnitIDList, unitID);
				}
			}
		
			// draw border on this token if it is in the mouse rect
			if (mouseRectExists && inMouseRect && !mouse_check_button_released(mb_left)) {
				draw_set_color(c_ltblue);
				scr_drawRectWidth(tokenRectX1, tokenRectY1, tokenRectX2, tokenRectY2, 2, true);
			}
		
	
			// get this token's inChainsList, and update the chainShowList accordingly
			var inChainsList = currentTokenSubMap[?"inChainsList"];
			var inEntryList = currentTokenSubMap[?"inEntryList"];
			scr_updateChainShowList(inChainsList, inEntryList, obj_chain.chainShowList, currentTokenSubMap[?"inChunkList"], currentToken, tokenRectX1, tokenRectY1, tokenRectX2, tokenRectY2);	
		
		
		
			// mouseover token
			if(mouseOverToken){
			
				// if this token is not in a chain, draw a thin border when mousing over
				var sizeOfInChainsList = 0;
				if (scr_isNumericAndExists(inChainsList, ds_type_list)) sizeOfInChainsList = ds_list_size(inChainsList);
				if (sizeOfInChainsList == 0) {
					draw_set_color(global.colorThemeBorders);
					draw_rectangle(tokenRectX1,tokenRectY1,tokenRectX2,tokenRectY2, true);
				}
				obj_control.hoverTokenID = currentToken;
				var tokenTagMap = currentTokenSubMap[?"tagMap"];
				obj_control.hoverTextCopy = tokenTagMap[? global.displayTokenField];
			
				// click on token
				if(device_mouse_check_button_released(0, mb_left) and !obj_control.mouseoverPanelPane and !instance_exists(obj_dialogueBox)) {
					var focusedchainIDSubMap = global.nodeMap[? obj_chain.currentFocusedChainID];
				
					// if focused chain is a stack, deselect it
					if (scr_isNumericAndExists(focusedchainIDSubMap, ds_type_map)){
						var focusedChainType = focusedchainIDSubMap[? "type"];
						if (focusedChainType == "stack") {
							scr_chainDeselect();
						}
					}
				
					if (global.ctrlHold) {
						// combine chains
						var inChainsList = currentTokenSubMap[?"inChainsList"];
						scr_combineChainsDrawLine(inChainsList);
					}
				
					scr_tokenClicked(currentToken);
				}
			
				// Check for rightMouseClick
				if (device_mouse_check_button_released(0, mb_right) and !instance_exists(obj_dialogueBox)) {
				
					obj_control.rightClickID = obj_control.hoverTokenID;
	
					// wait 1 frame and then show the right click dropdown
					with (obj_alarm) {
						alarm[11] = 2;
					}

				}
			

			}
		
		
		
			// draw the token's text
			var wordFound = false;
			
			if (instance_exists(obj_panelPane)) {
				if(scr_isNumericAndExists(global.searchMap, ds_type_map)){
					var searchSubMap  = global.searchMap[?obj_panelPane.functionSearchList_searchSelected];
					if(scr_isNumericAndExists(searchSubMap, ds_type_map)){
			
						var searchedTokenList = searchSubMap[?"displayTokenList"];
			
						wordFound = (ds_list_find_index(searchedTokenList,currentToken) != -1);
			
					}
				}
			}
		

			draw_set_color((wordFound) ? make_color_rgb(20, 146, 181) : global.colorThemeText );

			draw_set_alpha(1);
			draw_text(floor(currentPixelX), floor(pixelY), currentDisplayStr);
		}
		
		// run through the loop forward or backward depending on if LTR or RTL
		//if (drawLineState == lineState_ltr) i++;
		if (justify == justifyLeft) i++;
		else i--;
		
		if(isBAD) i -= 2;
		j++;
		
		k += (drawLineState == lineState_ltr) ? 1 : -1;
		
	}
	
	
} 