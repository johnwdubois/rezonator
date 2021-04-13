function scr_hideOptions(optionSelected) {
	//hideOptions

	switch (optionSelected)
	{
		case "Track":// hide/show track chains
			obj_chain.toggleDrawTrack = !obj_chain.toggleDrawTrack;
		break;
		case "menu_rez":// hide/show rez chains
			obj_chain.toggleDrawRez = !obj_chain.toggleDrawRez;
		break;
		case "menu_stack":// hide/show stack chains
			obj_chain.toggleDrawStack = !obj_chain.toggleDrawStack;
		break;
		default:
		break;
	
	}



}
