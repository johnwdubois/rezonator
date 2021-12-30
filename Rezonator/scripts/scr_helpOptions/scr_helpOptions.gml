function scr_helpOptions(optionSelected) {
	//helpOptions

	switch (optionSelected)
	{
		case "menu_help":// hide/show track chains
			obj_panelPane.functionHelp_collapsed = !obj_panelPane.functionHelp_collapsed;
			break;
		case "menu_guide":// hide/show rez chains
			url_open("https://johnwdubois.github.io/rezonator/");
			break;
		case "menu_about":// hide/show stack chains
			url_open("http://rezonator.com/");
			break;
		default:
			break;
	}



}
