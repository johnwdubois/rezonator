if (obj_control.shapeStartText == true) {
	obj_control.shapeStartText = false;
	//obj_control.shape = obj_control.shapeBlock;
}
if (obj_control.shape == obj_control.shapeBlock) {
	obj_control.shape = obj_control.shapeText;
}
else {
	obj_control.shape = obj_control.shapeBlock;
}