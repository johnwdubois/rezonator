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
global.scrollBarWidth = 20;
scrollBarHeight = 0;
scrollPlusY = 0;
scrollPlusYDest = 0;
scrollBarPlusY = 0;

scrollBarHoldingDelay = false;

optionListTypeSort = 0;
optionListTypeChainList = 1;
optionListTypeChainRecolor = 2;
optionListTypeSpeakerLabel = 3;
optionListTypeFile = 4;
optionListTypeAdvanced = 5;
optionListTypeView = 6;
optionListTypeSearch = 7;
optionListTypeRightClickWord = 8;
optionListTypeWordTags = 9;
optionListTypeGame = 10;
optionListTypeNewWord = 11;
optionListTypeMappingTag = 12;
optionListTypeZoom = 13;
optionListTypePane = 14;
optionListTypeWord = 15;
optionListTypeJustify = 16;
optionListTypeProse = 17;
optionListTypeHide = 18;
optionListTypeContext = 19;
optionListTypeClear = 20;
optionListTypeSettings = 21;
optionListTypeTools = 22;
optionListTypeHelp = 23;
optionListTypeToolsSort = 24;
optionListTypeStackShow = 25;
optionListTypeDelete = 26;
optionListTypeTokenSelection = 27;
optionListTypeStack = 28;
optionListTypeCreateStack = 29;
optionListTypeShowStack = 30;
optionListTypeUnitSelection = 31;
optionListTypeSpecialFields = 32;
optionListTypeFilter = 33;
optionListTypeAddToFilter = 34;
optionListTypeTokenTagMap = 35;
optionListTypeTokenMarker = 36;
optionListTypeUnitMarker = 37;
optionListTypeUnitTagMap = 38;
optionListTypeGridViewerSelectGrid = 39;
optionListTypeAutosave = 40;
optionListTypeStackTag = 41;
optionListTypeEdit = 42;
optionListTypePlayAndLearn = 43;
optionListTypeNav = 44;