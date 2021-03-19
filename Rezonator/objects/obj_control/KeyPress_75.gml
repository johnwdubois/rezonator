/// @description change prose/grid


if (obj_control.shape == obj_control.shapeBlock) {
obj_control.shape = obj_control.shapeText;
}
else if (obj_control.shape == obj_control.shapeText) {
	obj_control.shape = obj_control.shapeBlock;
}