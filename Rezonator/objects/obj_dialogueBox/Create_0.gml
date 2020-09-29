/// @description Insert description here
// You can write your code in this editor


// scrollbar variables
scrollBarHolding = false;
scrollBarUpButtonHeld = false;
scrollBarDownButtonHeld = false;
global.scrollBarWidth = 20;
scrollBarHeight = 0;
scrollPlusY = 0;
scrollPlusYDest = 0;
scrollBarPlusY = 0;



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

maxDisplaySize = 30;
displayText = "";


questionWindowActive = false;
//askingQuestion = false;

elmoActive = false;

holdUp = 0;
holdDown = 0;

selectAll = false;

clearAllStacks = false;
clearAllTracks = false;
clearAllRez = false;
clearAllLinks = false;
clearChain = false;
layerLink = false;
combineChains = false;

canDelete = true;
canDeleteHoldingCounter = 0;
canPressLeft = true;
canPressLeftHoldingCounter = 0;
canPressRight = true;
canPressRightHoldingCounter = 0;
holdingLimit = 6;
loopItterations = 0;

grid = obj_chain.rezChainGrid;