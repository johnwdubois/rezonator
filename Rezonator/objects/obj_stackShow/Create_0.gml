/// @description Insert description here
// You can write your code in this editor

// scrollbar variables
scrollBarHolding = false;
scrollBarUpButtonHeld = false;
scrollBarDownButtonHeld = false;
scrollBarHeight = 0;
scrollPlusY = 0;
scrollPlusYDest = 0;
scrollBarPlusY = 0;

//panel pane variables
windowHeight = 289;
windowWidth = 360;
clipSurface = -1;
clipWidth = 100;
clipHeight = 100;
clipX = 0;
clipY = 0;
scrollPlusY = 0;
windowResizeXHolding = false;
windowResizeYHolding = false;
canResizeWindowX = false;
canResizeWindowY = false;

holdUp = 0;
holdDown = 0;

gameHover = false;
currentGame = "Present";

//option to choose all stacks
selectAll = false;


var verticleBuffer = 230;
var horizontalBuffer = 300;
windowX1 = camera_get_view_width(camera_get_active()) /2 - horizontalBuffer;
windowY1 = camera_get_view_height(camera_get_active())/2 - verticleBuffer;
windowX2 = camera_get_view_width(camera_get_active()) /2 + horizontalBuffer;
windowY2 = camera_get_view_height(camera_get_active())/2 + verticleBuffer;