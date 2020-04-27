/*
	obj_gridViewer: Create
	
	Last Updated: 2019-02-11
	
	Called from: The creation of the gridViewer object
	
	Purpose: Instantiate all variables used by the gridViewer object
	
	Mechanism: variable creation and assignment
	
	Author: Terry DuBois
*/

gridViewColXListMap = ds_map_create();
gridViewColXHolding = -1
gridViewColXHoldingPrev = 0;
gridViewColXHoldingDiff = 0;
gridViewColPrevList = ds_list_create();


//scrollTogether = false;

gridList = ds_list_create();
ds_list_add(gridList,
	obj_control.unitGrid,
	obj_control.lineGrid,
	obj_control.wordGrid,
	obj_control.dynamicWordGrid,
	obj_control.filterGrid,
	obj_control.searchGrid,
	obj_control.hitGrid,
	obj_control.wordDrawGrid
	);
alarm[0] = 1;


grid = obj_control.unitGrid;

//gridCurrentTopViewRow[0] = 0;
//gridCurrentTopViewRow[1] = 0;

windowX = 20;
windowY = room_height / 5;
windowWidth = room_width / 2;
windowHeight = 500;

//windowX[1] = room_width / 2 + 40;
//windowY[1] = room_height / 5;
//windowWidth[1] = room_width - windowX[1];
//windowHeight[1] = 500;

//scrollRange[0] = 40;
//scrollBarHolding[0] = false;
//scrollBarHoldingPlusY[0] = 0;

//scrollRange[1] = 40;
//scrollBarHolding[1] = false;
//scrollBarHoldingPlusY[1] = 0;

//mouseoverRow = -1;
//mouseoverRelativeRow[0] = -1;
//mouseoverRelativeRow[1] = -1;

holdUp = 0; //for controlling the speed of gridView's scrolling
holdDown = 0;


windowResizeXHolding = false;
windowResizeYHolding = false;

focusedCol = -1;
focusedRow = -1;
focusedItemString = " ";

clipSurface = -1;
clipWidth = 100;
clipHeight = 100;
clipX = 0;
clipY = 0;
	

// scrollbar variables
scrollBarHolding = false;
scrollBarUpButtonHeld = false;
scrollBarDownButtonHeld = false;
scrollBarWidth = 20;
scrollBarHeight = 0;
scrollPlusY = 100;
scrollPlusYDest = 100;
scrollBarPlusY = 0;

x = 32;
y = 200;



notRefreshed = true;