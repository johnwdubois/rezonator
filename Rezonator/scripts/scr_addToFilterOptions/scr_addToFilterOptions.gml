function scr_addToFilterOptions(optionSelected) {

	switch (optionSelected) {
		case "menu_resonance":
			scr_toggleFilterForAllChains("resonance");
			break;
		case "menu_track":
			scr_toggleFilterForAllChains("trail");
			break;
		case "menu_stack":
			scr_toggleFilterForAllChains("stack");
			break;
		default:
			break;
	}

}
