// Instatiates drop down object
optionSpacing = 30;

originalWindowWidth = 110;

c_ltblue = make_color_rgb(183, 183, 255);


if (room == rm_mainScreen) {
	if (obj_menuBar.menuClickedIn) {
		originalWindowWidth = 200;
	}
	if (obj_control.wideDropDown) {
		if (instance_exists(obj_dialogueBox)) {
			if (obj_control.stackShowWindowActive) {
				originalWindowWidth = 137;
			}
		}
		else {
			originalWindowWidth = 150;
		}
	}
	if (!obj_menuBar.menuClickedIn && !obj_control.wideDropDown) {
		alarm[1] = 1;
	}
}
windowWidth = originalWindowWidth;
windowHeight = 100;


ableToClick = false;
alarm[0] = 10;
if (room == rm_mainScreen) {
	obj_control.ableToCreateDropDown = false;
}
optionCurrent = -1;

mouseOverDropDown =  false;
textBuffer = 10;

// scrollbar variables
clipSurface = -1;
clipWidth = 100;
clipHeight = 100;
clipX = 0;
clipY = 0;
windowResizeXHolding = false;
windowResizeYHolding = false;
canResizeWindowX = false;
canResizeWindowY = false;
scrollBarHolding = false;
scrollBarUpButtonHeld = false;
scrollBarDownButtonHeld = false;
scrollBarHeight = 0;
scrollPlusY = 0;
scrollPlusYDest = 0;
scrollBarPlusY = 0;

scrollBarHoldingDelay = false;