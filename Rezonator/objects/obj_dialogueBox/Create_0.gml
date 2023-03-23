scr_scrollBarInit();


maxDisplaySize = 30;

displayText = "";



titleText = "";
descriptionText = "";

inputWindowActive = false;
questionWindowActive = false;
alertWindowActive = false;

mouseoverCancel = false;
mouseoverOk = false;
mouseoverNo = false;

noButtonActive = false;

holdUp = 0;
holdDown = 0;

selectAll = false;

clearAllStacks = false;
clearAllTracks = false;
clearAllChunks = false;
clearAllRez = false;
clearAllLinks = false;
clearChain = false;
clearChainMulti = false;
clearShow = false;
layerLink = false;
combineChains = false;
removeTags = false;
removeTagToken = false;
removeTagUnit = false;
removeTagEntry = false;
removeTagChain = false;
removeTagChunk = false;
removeTagLink = false;
removeFieldToken = false;
removeFieldUnit = false;
removeFieldEntry = false;
removeFieldChain = false;
removeFieldChunk = false;
removeFieldLink = false;
removeSearch = false;
removeTree = false;
mergeUnit = false;
splitUnit = false;
stringToBeRemoved = "";
searchToBeRemoved = "";
swapUnitUp = false;
swapUnitDown = false;
deleteToken = false;
mergeStack = false;
chunkAlreadyExists = false;
confirmSideLink = false;
stackingToActivate = "";


canDelete = true;
canDeleteHoldingCounter = 0;
canPressLeft = true;
canPressLeftHoldingCounter = 0;
canPressRight = true;
canPressRightHoldingCounter = 0;
holdingLimit = 6;
loopItterations = 0;

largestPixelY = 0;



with (obj_dropDown) {
	instance_destroy();
}


camWidth = camera_get_view_width(camera_get_active());
camHeight = camera_get_view_height(camera_get_active());
camMidX = camWidth / 2;
camMidY = camHeight / 2;
boxHeight = max((inputWindowActive) ? 400 : 270, camHeight / 4);
boxWidth = max(640, camHeight / 3);
boxRectX1 = camMidX - boxWidth/2;
boxRectY1 = camMidY - boxHeight/2;
boxRectX2 = camMidX + boxWidth/2;
boxRectY2 = camMidY + boxHeight/2;

buttonY1 = 0;
buttonY2 = 0;

blink = false;
blinkAlpha = 0;

inputBoxList = undefined;