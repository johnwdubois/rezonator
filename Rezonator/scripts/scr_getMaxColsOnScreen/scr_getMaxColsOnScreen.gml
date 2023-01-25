

function scr_getMaxColsOnScreen() {
	
	var camWidth = camera_get_view_width(view_camera[0]);
	return floor((camWidth - global.toolPaneWidth) / obj_control.gridSpaceHorizontal);
	
}