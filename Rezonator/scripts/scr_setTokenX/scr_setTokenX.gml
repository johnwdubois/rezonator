function scr_setTokenX(tokenSubMap, displayCol, entryListSize, indexOfList, unitWidth, shapeTextX, camWidth, tokenString) {
	var spaceWidth = string_width("    ");
	var tokenPixelX = tokenSubMap[? "pixelX"];
	var tokenPixelXDest = 0;
	
	var tokenTagMap = tokenSubMap[? "tagMap"];
	//show_debug_message(string(tokenTagMap[? global.displayTokenField]) + " ... shapeTextX: " + string(shapeTextX));

	
	
	if (justify == justifyLeft) {
		// LEFT JUSTIFY
		
		if (shape == shapeText) {
			// Left Prose
			tokenPixelXDest = wordLeftMargin + scrollPlusX + shapeTextX + spaceWidth;

		}
		else {
			// Left Grid
			if(obj_control.drawLineState == obj_control.lineState_ltr){	
				tokenPixelXDest = wordLeftMargin + scrollPlusX + (displayCol * gridSpaceHorizontal) + spaceWidth;
			}
			else{
				tokenPixelXDest = camWidth - (scrollPlusX + (displayCol * gridSpaceHorizontal) + spaceWidth);
			}
			
		}
	}
	else {
		// RIGHT JUSTIFY
		
		if (shape == shapeText) {
			// Right Prose
			if(obj_control.drawLineState == obj_control.lineState_ltr){	
				tokenPixelXDest = camWidth - global.scrollBarWidth - global.toolPaneWidth - shapeTextX + scrollPlusX;
			}
			else{
				tokenPixelXDest = camWidth - global.scrollBarWidth - global.toolPaneWidth - unitWidth + shapeTextX + scrollPlusX;
				//tokenPixelXDest = camWidth - ((shapeTextX) + spaceWidth + gridSpaceHorizontal*2 - scrollPlusX);
			}
		}
		else {
			// Right Grid
			//tokenPixelXDest = camWidth - global.scrollBarWidth - (entryListSize * gridSpaceHorizontal) + (indexOfList * gridSpaceHorizontal) + scrollPlusX;
			if(obj_control.drawLineState == obj_control.lineState_ltr){	
				tokenPixelXDest = scrollPlusX + (displayCol * gridSpaceHorizontal) + spaceWidth + gridSpaceHorizontal*2;
			}
			else{
				tokenPixelXDest = camWidth - (scrollPlusX + (displayCol * gridSpaceHorizontal) + spaceWidth + gridSpaceHorizontal*2);
			}
		}
	}
	
	
	
	// make pixelX drift over to pixelXDest
	tokenPixelX = floor(lerp(tokenPixelX, tokenPixelXDest, 0.2));
	tokenSubMap[? "pixelX"] = tokenPixelX;
	
	return tokenPixelX;
	
}