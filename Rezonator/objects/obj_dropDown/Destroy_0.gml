/// @description Insert description here
// You can write your code in this editor
if (room == rm_mainScreen) {
	obj_menuBar.mouseOverFile = false;
	obj_menuBar.mouseOverEdit = false;
	obj_menuBar.mouseOverView = false;
	obj_menuBar.mouseOverSearch = false;
	obj_control.wideDropDown = false;
	obj_panelPane.ascendYScale = 1;
}
else if (room == rm_importScreen) {
obj_importMapping.inDropDown = false;
}
if(!object_exists(obj_dropDown)){
	obj_control.menuDepth = -1;
}

if (scr_isNumericAndExists(originalOptionList, ds_type_list)) {
	ds_list_destroy(originalOptionList);
}