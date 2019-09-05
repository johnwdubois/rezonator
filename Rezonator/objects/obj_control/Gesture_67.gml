/// @description Insert description here
// You can write your code in this editor
if(device_mouse_check_button(0, mb_left) and device_mouse_check_button(1, mb_left)) {
	scrollPlusYDest = event_data[?"posY"] + drag_offsetY;
}
