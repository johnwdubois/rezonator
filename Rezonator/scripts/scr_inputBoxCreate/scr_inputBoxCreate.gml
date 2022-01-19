

function scr_inputBoxCreate(strDefault){
	
	// get dimensions for input window (windowHeight will adjust based on font size)
	textBoxX = 0;
	textBoxY = 0;
	windowWidth = 100;
	windowHeight = 100;
	windowFocused = true;
	
	// str, cursor, & highlight
	str = strDefault;
	cursorIndex = string_length(str);
	highlightIndex = 0;
	strToCursor = "";
	strToHighlight = "";

	// frames that left/right/backspace has been held for
	leftArrowHold = 0;
	rightArrowHold = 0;
	backspaceHold = 0;
	
	// cursor blinking effect
	blinkRate = 30;
	drawCursor = true;
	alarm[0] = blinkRate;

	// declare variables for text positioning
	textX = 0;
	textY = 0;
	cursorX = 0;
	
	// surface variables for clipping effect
	clipSurface = -1;
	clipWidth = 0;
	clipHeight = 0;
	clipX = 0;
	clipY = 0;
	xOffset = 0;

	// track drag & double-click
	validDrag = false;
	doubleClickTimerFull = 30;
	doubleClickTimer = 0;
	doubleClick = false;
	

}