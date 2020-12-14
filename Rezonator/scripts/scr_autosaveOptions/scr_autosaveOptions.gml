function scr_autosaveOptions(optionSelected) {

	var wasOff = (global.autosaveTimer == -1);


	switch (optionSelected)
	{
		case "menu_5-min":
			global.autosaveTimer = 18000;
			break;
		case "menu_10-min":
			global.autosaveTimer = 36000;
			break;
		case "menu_20-min":		
			global.autosaveTimer = 72000;
			break;
		case "menu_30-min":
			global.autosaveTimer = 108000;
			break;
		case "menu_off":
			global.autosaveTimer = -1;
			break;
		default:
			break;
	}

	if (wasOff) {
		with(obj_fileLoader){
			alarm[1] = global.autosaveTimer;
		}
	}	


}
