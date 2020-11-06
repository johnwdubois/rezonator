function scr_helpOptions(argument0) {
	//helpOptions
	var optionSelected = argument0;

	switch (optionSelected)
	{
		case "Help":// hide/show track chains
			obj_panelPane.functionHelp_collapsed = !obj_panelPane.functionHelp_collapsed;
			break;
		case "Docs":// hide/show rez chains
			scr_openURL("http://rezonator.com/documentation/");
			break;
		case "About":// hide/show stack chains
			scr_openURL("http://rezonator.com/");
			break;
		default:
			break;
	}



}
