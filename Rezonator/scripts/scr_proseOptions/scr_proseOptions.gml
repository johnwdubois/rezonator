function scr_proseOptions(argument0) {
	//proseOptions
	var optionSelected = argument0;

	switch (optionSelected)
	{
		case "Prose":// other shape
			if (obj_control.shape == obj_control.shapeBlock) {
			obj_control.shape = obj_control.shapeText;
			}
		
		break;
		case "Grid":// block shape
			if (obj_control.shape == obj_control.shapeText) {
				obj_control.shape = obj_control.shapeBlock;
			}
		break;
		default:
		break;
	
	}


}
