function scr_justifyOptions(optionSelected) {
	
	// justify options
	switch (optionSelected) {
		case "menu_left": // left justified
			if (obj_control.justify != obj_control.justifyLeft) {
				obj_control.justify = obj_control.justifyLeft;
			}
			break;
		case "menu_right": // right justified
			if (obj_control.justify != obj_control.justifyRight) {
				obj_control.justify = obj_control.justifyRight;
			}
			break;
		case "menu_center": // center justified
			if (obj_control.justify != obj_control.justifyCenter) {
				obj_control.justify = obj_control.justifyCenter;
			}
			break;
		default: 
			break;
	}
	

	scr_refreshDisplayCol();


}
