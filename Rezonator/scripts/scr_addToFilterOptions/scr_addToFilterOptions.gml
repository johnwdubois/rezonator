function scr_addToFilterOptions(optionSelected) {

	switch (optionSelected) {
		case "menu_rez":
			scr_toggleFilterForAllChains("rezChain");
			break;
		case "menu_track":
			scr_toggleFilterForAllChains("trackChain");
			break;
		case "menu_stack":
			scr_toggleFilterForAllChains("stackChain");
			break;
		default:
			break;
	}

}
