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
mapViewActive = true;

//scrollTogether = false;

gridList = ds_list_create();
ds_list_add(gridList,
	obj_control.unitGrid,
	obj_control.wordGrid,
	);



grid = obj_control.unitGrid;

//gridCurrentTopViewRow[0] = 0;
//gridCurrentTopViewRow[1] = 0;

windowX = camera_get_view_width(view_get_camera(0)) / 5;
windowY = camera_get_view_height(view_get_camera(0)) / 4;
windowWidth = camera_get_view_width(view_get_camera(0)) - (windowX) - 40;
windowHeight = camera_get_view_height(view_get_camera(0)) - (windowY*1.5);
windowX1 = windowX;
windowX2 = windowX1 + windowWidth;
windowY1 = windowY;
windowY2 = windowY1 + windowHeight;

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

mouseoverRow = -1;

holdUp = 0; //for controlling the speed of gridView's scrolling
holdDown = 0;


windowResizeXHolding = false;
windowResizeYHolding = false;

focusedCol = -1;
focusedRow = -1;
focusedItemString = " ";

scr_scrollBarInit();


XDest = 0;




x = windowX;
y = windowY;

rectX2 = 0;


notRefreshed = true;

instance_create_layer(0, 0, "InstancesDialogue", obj_gridListWindow);