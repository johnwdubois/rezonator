var camWidth = camera_get_view_width(camera_get_active());
var camHeight = camera_get_view_height(camera_get_active());
windowWidth = camWidth / 8;
windowHeight = camHeight / 2;
exportWindowWidth = camWidth / 2;

exportGridList = ds_list_create();
ds_list_add(exportGridList,
	obj_control.unitGrid,
	obj_control.wordGrid,
	obj_control.dynamicWordGrid,
	obj_chain.rezChainGrid,
	obj_chain.trackChainGrid,
	obj_chain.stackChainGrid,
	obj_chain.linkGrid
);

selectedGrid = obj_control.unitGrid;
mouseoverRow = -1;


// scrollbar variables
scrollBarHolding = false;
scrollBarUpButtonHeld = false;
scrollBarDownButtonHeld = false;
global.scrollBarWidth = 20;
scrollBarHeight = 0;
scrollPlusY = 0;
scrollPlusYDest = 0;
scrollBarPlusY = 0;
windowResizeXHolding = false;
windowResizeYHolding = false;
clipSurface = -1;
clipWidth = 100;
clipHeight = 100;
clipX = 0;
clipY = 0;