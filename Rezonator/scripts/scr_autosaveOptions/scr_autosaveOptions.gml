function scr_autosaveOptions(optionSelected) {

	switch (optionSelected)
	{
		case "menu_5-min":
			global.autosaveTimerFull = 300;
			break;
		case "menu_10-min":
			global.autosaveTimerFull = 600;
			break;
		case "menu_20-min":		
			global.autosaveTimerFull = 1200;
			break;
		case "menu_30-min":
			global.autosaveTimerFull = 1800;
			break;
		case "menu_off":
			global.autosaveTimerFull = -1;
			break;
		default:
			break;
	}
	
	global.autosaveTimer = global.autosaveTimerFull;

}
