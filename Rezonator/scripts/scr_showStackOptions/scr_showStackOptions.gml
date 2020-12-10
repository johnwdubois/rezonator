function scr_showStackOptions(optionSelected) {

	switch (optionSelected)
	{	
	
		case "Default":

			show_message(scr_get_translation("msg_default-stack"));
			break;
		case "menu_random":

			show_message(scr_get_translation("msg_random-stack"));
			break;
		default:
			break;
	}


}
