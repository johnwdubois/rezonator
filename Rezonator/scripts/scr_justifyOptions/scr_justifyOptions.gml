function scr_justifyOptions(optionSelected) {
	
	// justify options
	switch (optionSelected) {
		case "menu_left": // left justified
			obj_control.justify = obj_control.justifyLeft;
			break;
		case "menu_right": // right justified
			obj_control.justify = obj_control.justifyRight;
			break;
		case "menu_center": // center justified
			obj_control.justify = obj_control.justifyCenter;
			break;
		default: 
			break;
	}
	

	scr_refreshDisplayCol();


}
