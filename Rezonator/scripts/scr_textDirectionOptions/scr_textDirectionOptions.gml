

function scr_textDirectionOptions(optionSelected) {

	switch(optionSelected) {
		case "menu_right-to-left":
			obj_control.justify = obj_control.justifyRight;
			obj_control.drawLineState = obj_control.lineState_rtl;
		break;
		case "menu_left-to-right":
			obj_control.justify = obj_control.justifyLeft;
			obj_control.drawLineState = obj_control.lineState_ltr;
		break;
	}
	
	scr_refreshDisplayCol();
	scr_refreshPrevToken();
}