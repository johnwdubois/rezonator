function scr_scrollBarInit() {
	
	// scrollbar variables
	scrollBarHolding = false;
	scrollBarUpButtonHeld = false;
	scrollBarDownButtonHeld = false;
	scrollBarHeight = 0;
	scrollPlusY = 999;
	scrollPlusYDest = 999;
	scrollBarPlusY = 0;
	mouseoverScrollBar = false;
	mouseoverHorScrollBar = false;

	windowHeight = 299;
	windowWidth = 360;
	clipSurface = -1;
	clipWidth = 100;
	clipHeight = 100;
	clipX = 0;
	clipY = 0;
	scrollPlusY = 0;
	windowResizeXHolding = false;
	windowResizeYHolding = false;
	canResizeWindowX = true;
	canResizeWindowY = true;
	
	// horizontal scrollbar variables
	scrollBarHorHolding = false;
	scrollBarLeftButtonHeld = false;
	scrollBarRightButtonHeld = false;
	scrollBarHorWidth = 20;
	scrollBarHorHeight = 0;
	scrollHorPlusX = 100;
	scrollHorPlusXDest = 100;
	scrollBarHorPlusX = 0;

	scrollHorPlusXPrev = 0;
	scrollHorPlusXDiff = 0;

}