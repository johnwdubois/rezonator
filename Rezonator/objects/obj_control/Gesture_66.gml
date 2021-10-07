/// @description Insert description here
// You can write your code in this editor
show_debug_message("drag start!");
if (!clickedOnToken) {
	drag_offsetY = scrollPlusYDest - event_data[?"posY"];
	if (extraTokenX) drag_offsetX = scrollPlusXDest - event_data[?"posX"];
	inDrag = true;
}