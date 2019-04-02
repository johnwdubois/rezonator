/*
	obj_gridViewer: Create
	
	Last Updated: 2019-02-11
	
	Called from: The creation of the gridViewer object
	
	Purpose: Instantiate all variables used by the gridViewer object
	
	Mechanism: variable creation and assignment
	
	Author: Terry DuBois
*/

scrollTogether = false;

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

grid[0] = obj_control.unitGrid;
grid[1] = obj_control.lineGrid;

gridCurrentTopViewRow[0] = 0;
gridCurrentTopViewRow[1] = 0;

windowX[0] = 20;
windowY[0] = room_height / 5;
windowWidth[0] = room_width / 2;
windowHeight[0] = 500;

windowX[1] = room_width / 2 + 40;
windowY[1] = room_height / 5;
windowWidth[1] = room_width - windowX[1];
windowHeight[1] = 500;

scrollRange[0] = 40;
scrollBarHolding[0] = false;
scrollBarHoldingPlusY[0] = 0;

scrollRange[1] = 40;
scrollBarHolding[1] = false;
scrollBarHoldingPlusY[1] = 0;

mouseoverRelativeRow[0] = -1;
mouseoverRelativeRow[1] = -1;

holdUp = 0; //for controlling the speed of gridView's scrolling
holdDown = 0;
