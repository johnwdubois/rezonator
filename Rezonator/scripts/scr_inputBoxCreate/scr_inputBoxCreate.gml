// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_inputBoxCreate(){
	str = "";

	windowWidth = 700;
	windowHeight = 400;

	cursorIndex = 0;
	strToCursor = "";
	strToHighlight = "";

	leftArrowHold = 0;
	rightArrowHold = 0;
	backspaceHold = 0;

	highlightIndex = 0;

	blinkRate = 30;
	drawCursor = true;
	alarm[0] = blinkRate;




	overflow = 0;
	overflowMax = 20;
	xOffset = 0;
	firstVisChar = "";

	textX = 0;
	textY = 0;
	cursorX = 0;

	validDrag = false;

	clipSurface = -1;
	clipWidth = 100;
	clipHeight = 100;
	clipX = 0;
	clipY = 0;

}