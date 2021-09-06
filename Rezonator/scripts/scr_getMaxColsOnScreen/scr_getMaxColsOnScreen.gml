// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_getMaxColsOnScreen(){
	
	var camWidth = camera_get_view_width(view_camera[0]);
	return floor((camWidth - global.toolPaneWidth) / obj_control.gridSpaceHorizontal);
	
}