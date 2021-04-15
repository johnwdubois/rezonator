// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_setTokenX(tokenSubMap, displayCol, wordIDListSize, unitWidth, shapeTextX, camWidth) {
	
	var spaceWidth = string_width("   ");
	var tokenPixelX = tokenSubMap[? "pixelX"];
	var tokenPixelXDest = 0;
	
	if (shape == shapeText) {
		tokenPixelXDest = wordLeftMargin + scrollPlusX + shapeTextX + spaceWidth;
	}
	else {
		tokenPixelXDest = wordLeftMargin + scrollPlusX + (displayCol * gridSpaceHorizontal) + spaceWidth;
	}
	
	// make pixelX drift over to pixelXDest
	tokenPixelX = floor(lerp(tokenPixelX, tokenPixelXDest, 0.2));
	tokenSubMap[? "pixelX"] = tokenPixelX;
	
	return tokenPixelX;
	
}