// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_setTokenX(wordID, shapeTextX, wordIDListSize, unitWidth, drawWordLoop, camWidth) {
	
	var currentWordDisplayCol = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayCol, wordID - 1);
	var displayColEdit = (drawLineState == lineState_ltr) ? currentWordDisplayCol : wordIDListSize - currentWordDisplayCol;
	var speakerLabelWidth = speakerLabelColXList[| 3] + 20;
	var wordLeftMarginEdit = 0;
	if (drawLineState == lineState_ltr) {
		wordLeftMarginEdit = (justify == justifyLeft) ? wordLeftMargin : speakerLabelWidth - wordLeftMargin;
	}
	else {
		wordLeftMarginEdit = (justify == justifyLeft) ? wordLeftMargin : wordLeftMargin;
	}
	
	var justifyRightPlusXBlock = (drawLineState == lineState_ltr) ? 0 : gridSpaceHorizontal * 2;
	var justifyRightPlusXText = (drawLineState == lineState_ltr) ? 0 : gridSpaceHorizontal;
	

	// horizontally move this word to its desired x-pixel value
	var currentWordDestX = 0;
	if (justify == justifyLeft) {
		if (shape == shapeText) {
			currentWordDestX = shapeTextX;
		}
		else {
			currentWordDestX = displayColEdit * gridSpaceHorizontal + wordLeftMarginEdit;
		}
	}
	else if (justify == justifyCenter) {
		if (shape == shapeText) {
			currentWordDestX = (camWidth / 2) - (unitWidth / 2) + shapeTextX + wordLeftMarginEdit;
		}
		else {
			currentWordDestX = (camWidth / 2) - (ceil((wordIDListSize / 2)) * gridSpaceHorizontal) + (displayColEdit * gridSpaceHorizontal) + wordLeftMarginEdit;
		}
	}
	else if (justify == justifyRight) {
		if (shape == shapeText) {
			currentWordDestX = camWidth - global.toolPaneWidth -global.scrollBarWidth - unitWidth + shapeTextX + wordLeftMarginEdit - justifyRightPlusXText;
		}
		else {
			currentWordDestX = camWidth - (wordIDListSize * gridSpaceHorizontal) + (displayColEdit * gridSpaceHorizontal) + wordLeftMarginEdit - justifyRightPlusXBlock;
		}
	}
	
	var currentWordX = ds_grid_get(dynamicWordGrid, dynamicWordGrid_colPixelX, wordID - 1);
	if (is_string(currentWordX)) {
		currentWordX = 0;
	}
	leftScreenBound = min(currentWordX, leftScreenBound);
		
	if (currentWordX < currentWordDestX) {
		currentWordX += abs(currentWordX - currentWordDestX) / 4;
	}
	else if (currentWordX > currentWordDestX) {
		currentWordX -= abs(currentWordX - currentWordDestX) / 4;
	}
		
	ds_grid_set(dynamicWordGrid, dynamicWordGrid_colPixelX, wordID - 1, currentWordX);
	ds_grid_set(dynamicWordGrid, dynamicWordGrid_colDisplayWordSeq, wordID - 1, drawWordLoop);
	
	return currentWordX;

}