/// @description Insert description here
// You can write your code in this editor


scr_scrollBarInit();


maxDisplaySize = 30;
displayText = "";
dialogueBoxText = "";


questionWindowActive = false;

holdUp = 0;
holdDown = 0;

selectAll = false;

clearAllStacks = false;
clearAllTracks = false;
clearAllRez = false;
clearAllLinks = false;
clearChain = false;
clearShow = false;
layerLink = false;
combineChains = false;
removeTagToken = false;
removeTagUnit = false;
removeTagEntry = false;
removeTagChain = false;
removeFieldToken = false;
removeFieldUnit = false;
removeFieldEntry = false;
removeFieldChain = false;
removeSearch = false;
stringToBeRemoved = "";
searchToBeRemoved = "";

canDelete = true;
canDeleteHoldingCounter = 0;
canPressLeft = true;
canPressLeftHoldingCounter = 0;
canPressRight = true;
canPressRightHoldingCounter = 0;
holdingLimit = 6;
loopItterations = 0;



with (obj_dropDown) {
	instance_destroy();
}