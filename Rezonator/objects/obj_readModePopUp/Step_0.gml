/// @description Insert description here
// You can write your code in this editor

//mouse over the whole popUp
if (mouse_check_button_released(mb_left)) {
	instance_destroy();
}

if (point_in_rectangle(mouse_x, mouse_y,camera_get_view_width(camera_get_active()) - 295, 0 + obj_menuBar.menuHeight, camera_get_view_width(camera_get_active()) - 105,200 + obj_menuBar.menuHeight)) {
	obj_control.mouseoverPanelPane = true;
}
else{
	obj_control.mouseoverPanelPane = false;
}
