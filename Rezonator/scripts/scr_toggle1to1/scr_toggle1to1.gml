function scr_toggle1to1() {
	
	// get panelL and panelR scroll values
	var _panelLScroll = -1;
	var _panelRScroll = -1;
	with (obj_panelPane) {
		if (currentFunction == functionChainList) _panelLScroll = scrollPlusY;
		else if (currentFunction == functionChainContents) _panelRScroll = scrollPlusY;
	}
	
	var _1ToMany = !obj_panelPane.chainViewOneToMany;
	show_debug_message("before _panelLScroll: " + string(_panelLScroll) + ", _panelRScroll: " + string(_panelRScroll) + ", _1ToMany: " + string(_1ToMany));
	
	
	with (obj_panelPane) {
		
		scrollPlusY_LSync = _panelLScroll;
		scrollPlusY_RSync = _panelRScroll;
		
		chainViewOneToMany = _1ToMany;
	}

}