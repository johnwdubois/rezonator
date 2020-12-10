/// @description Insert description here
// You can write your code in this editor
randLine1 = 1;
randLine2 = randLine1 + floor(random(7)) + 1;

splitSave = false;


stackerFunctionDefault = 0;
stackerFunctionRandom = 1;
stackerFunctionTurn = 2;
stackerFunctionSent = 3;
stackerFunctionGroup = 4;
currentStackerFuntion = stackerFunctionDefault;

endNoteTagsGrid = ds_grid_create(2, 0);
endNoteTagsGrid_colTag = 0;
endNoteTagsGrid_colChecked = 1;
endCol = -1;


alarm[7] = 2;

showEndNoteWindow = false;
confirmStackCreate = false;
createStacksRandom = false;
createStacksTurn = false;
createStacksSentence = false;
createStacksGroup = false;



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