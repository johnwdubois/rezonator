// Instatiates drop down object
optionSpacing = 30;

originalWindowWidth = 110;

c_ltblue = make_color_rgb(183, 183, 255);


if (room == rm_mainScreen) {
	if (obj_menuBar.menuClickedIn) {
		originalWindowWidth = 200;
	}
	if (obj_control.wideDropDown) {
		if (!instance_exists(obj_dialogueBox)) {
			originalWindowWidth = 150;
		}
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
level = -1;
prevDropDown = -1;

mouseOverDropDown =  false;
textBuffer = 10;

scr_scrollBarInit();

scrollBarHoldingDelay = false;


multiDropDownCancel = false;
expandableTimer = 0;
expandableTimerFull = 30;
expandableTimerClicked = false;
prevMouseoverOption = -2;
prevOptionClicked = -1;
currentMouseoverOption = -1;
myAlpha = 0;

arrowKeySelection = false;

lastMouseX = 0;
lastMouseY = 0;
mouseMoved = false;
alarm[3] = 1;

prevOptionClickedIndex = -1;

canPressUp = true;
canPressDown = true;