// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_adjustTokenSpacing(numToAdd){
	
	if (instance_exists(obj_control)) {
		if (obj_control.shape == obj_control.shapeBlock) {
			obj_control.gridSpaceHorizontal += numToAdd;
		}
		else {
			obj_control.proseSpaceHorizontal += numToAdd;
		}
		
		obj_control.gridSpaceHorizontal = clamp(obj_control.gridSpaceHorizontal, obj_control.gridSpaceHorizontalMin, obj_control.gridSpaceHorizontalMax);
		obj_control.proseSpaceHorizontal = clamp(obj_control.proseSpaceHorizontal, obj_control.proseSpaceHorizontalMin, obj_control.proseSpaceHorizontalMax);
	}


}