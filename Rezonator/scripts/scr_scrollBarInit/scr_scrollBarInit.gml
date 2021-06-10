// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_scrollBarInit(){
	
	// scrollbar variables
	scrollBarHolding = false;
	scrollBarUpButtonHeld = false;
	scrollBarDownButtonHeld = false;
	scrollBarHeight = 0;
	scrollPlusY = 0;
	scrollPlusYDest = 0;
	scrollBarPlusY = 0;
	mouseoverScrollBar = false;

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

}