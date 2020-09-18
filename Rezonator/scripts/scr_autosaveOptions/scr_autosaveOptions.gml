function scr_autosaveOptions(argument0) {
	var optionSelected = argument0;

	var wasOff = (global.autosaveTimer == -1);


	switch (optionSelected)
	{
		case "5 minutes":
			global.autosaveTimer = 18000;
			break;
		case "10 minutes":
			global.autosaveTimer = 36000;
			break;
		case "20 minutes":		
			global.autosaveTimer = 72000;
			break;
		case "30 minutes":
			global.autosaveTimer = 108000;
			break;
		case "Off":
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
