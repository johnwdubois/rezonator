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
				var alignChains = (obj_control.justify == obj_control.justifyLeft);
			    scr_setValueForAllChains("rezChain", "align", false);
			    scr_setValueForAllChains("trackChain", "align", false);
			}
			break;
		case "menu_center": // center justified
			if (obj_control.justify != obj_control.justifyCenter) {
				obj_control.justify = obj_control.justifyCenter;
				var alignChains = (obj_control.justify == obj_control.justifyLeft);
			    scr_setValueForAllChains("rezChain", "align", false);
			    scr_setValueForAllChains("trackChain", "align", false);
			}
			break;
		default: 
			break;
	}


}
