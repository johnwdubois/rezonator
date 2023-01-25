/// @description check for mouse movement
var minDist  = 1;
mouseMoved = (abs(lastMouseX - mouse_x) >= minDist or abs(lastMouseY - mouse_y) >= minDist);
lastMouseX = mouse_x;
lastMouseY = mouse_y;
if (instance_exists(obj_dropDown)) {
	alarm[3] = 1;
}