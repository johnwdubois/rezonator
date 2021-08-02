// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_setTokenX(tokenSubMap, displayCol, entryListSize, indexOfList, unitWidth, shapeTextX, camWidth, tokenString) {
	var spaceWidth = string_width("    ");
	var tokenPixelX = tokenSubMap[? "pixelX"];
	var tokenPixelXDest = 0;
	

	
	
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
	else if (justify == justifyCenter) {
		// CENTER JUSTIFY
		
		if (shape == shapeText) {
			// Center Prose
			tokenPixelXDest = (camWidth / 2) - (unitWidth / 2) + shapeTextX + scrollPlusX;
		}
		else {
			// Center Grid
			tokenPixelXDest = (camWidth / 2) - ((entryListSize / 2) * gridSpaceHorizontal) + (indexOfList * gridSpaceHorizontal) + scrollPlusX;
		}
		
	}
	else if (justify == justifyRight) {
		// RIGHT JUSTIFY
		
		if (shape == shapeText) {
			// Right Prose
			if(obj_control.drawLineState == obj_control.lineState_ltr){	
				tokenPixelXDest = camWidth - global.scrollBarWidth - global.toolPaneWidth - shapeTextX + scrollPlusX;
			}
			else{
				tokenPixelXDest = camWidth - global.scrollBarWidth - global.toolPaneWidth - unitWidth + string_width(tokenString) + scrollPlusX;
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