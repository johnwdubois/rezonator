function scr_justifyProseOptions(optionSelected) {
	
	// justify options
	switch (optionSelected) {
		case "flyout_left-prose":
			scr_justifyOptions("menu_left");
			scr_proseOptions("menu_prose");
			break;
		case "flyout_left-grid":
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
		case "flyout_right-prose":
			scr_justifyOptions("menu_right");
			scr_proseOptions("menu_prose");
			break;
		case "flyout_right-grid":
			scr_justifyOptions("menu_right");
			scr_proseOptions("menu_grid");
			break;
		default: 
			break;
	}


}
