function scr_adjustTokenSpacing(numToAdd) {

	if (instance_exists(obj_control)) {
		with (obj_control) {
			if (shape == shapeBlock) {
				gridSpaceHorizontal += numToAdd;
			}
			else {
				proseSpaceHorizontal += numToAdd;
			}
		
			gridSpaceHorizontal = clamp(gridSpaceHorizontal, gridSpaceHorizontalMin, gridSpaceHorizontalMax);
			proseSpaceHorizontal = clamp(proseSpaceHorizontal, proseSpaceHorizontalMin, proseSpaceHorizontalMax);
		}
		
		if (!scr_checkNativeJustification() && obj_control.shape == obj_control.shapeBlock) scr_refreshDisplayColAndPrevToken();
	}

}