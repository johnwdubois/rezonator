function scr_proseOptions(optionSelected) {
	//proseOptions

	switch (optionSelected)
	{
		case "menu_prose":// other shape
			if (obj_control.shape == obj_control.shapeBlock) {
			obj_control.shape = obj_control.shapeText;
			}
		
		break;
		case "menu_grid":// block shape
			if (obj_control.shape == obj_control.shapeText) {
				obj_control.shape = obj_control.shapeBlock;
			}
		break;
		default:
		break;
	
	}


}
