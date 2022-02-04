/// @description change prose/grid
if (instance_exists(obj_dialogueBox) || !shortcutsEnabled) {
	exit;
}

if (obj_control.shape == obj_control.shapeBlock) {
	obj_control.shape = obj_control.shapeText;
}
else if (obj_control.shape == obj_control.shapeText) {
	obj_control.shape = obj_control.shapeBlock;
}