function scr_justifyProseOptions(optionSelected) {
	
	// justify options
	switch (optionSelected) {
		case "Left Prose":
			scr_justifyOptions("menu_left");
			scr_proseOptions("menu_prose");
			break;
		case "Left Grid":
			scr_justifyOptions("menu_left");
			scr_proseOptions("menu_grid");
			break;
		case "Center Prose":
			scr_justifyOptions("menu_center");
			scr_proseOptions("menu_prose");
			break;
		case "Center Grid":
			scr_justifyOptions("menu_center");
			scr_proseOptions("menu_grid");
			break;
		case "Right Prose":
			scr_justifyOptions("menu_right");
			scr_proseOptions("menu_prose");
			break;
		case "Right Grid":
			scr_justifyOptions("menu_right");
			scr_proseOptions("menu_grid");
			break;
		default: 
			break;
	}


}
